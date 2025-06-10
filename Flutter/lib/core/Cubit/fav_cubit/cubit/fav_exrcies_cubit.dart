import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/core/Entity/ExerciseEntity.dart';
import 'package:graduation_project_ui/core/Repo/Fav_Exercies_Repo_Imp.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Id.dart';
part 'fav_exrcies_state.dart';

class FavExrciesCubit extends Cubit<FavExrciesState> {
  final FavExerciesRepoImp favExerciesRepoImp;
  FavExrciesCubit({required this.favExerciesRepoImp})
      : super(FavExrciesInitial());

  Future<void> getFavExercises() async {
    emit(FavExrciesLoading());
    var result = await favExerciesRepoImp.getExercises();
    result.fold((failuers) => emit(FavExrciesFailure(failuers.Massage)),
        (products) => emit(FavExrciesSuccess(products)));
  }

  Future<void> addFavExercises(ExerciseEntity exerciseEntity) async {
    try {
      await favExerciesRepoImp.databaseService
          .addWorkoutToFavorites(getCurrentUserId(), exerciseEntity.toModel());

      // Update the current state with the new exercise if we're in success state
      if (state is FavExrciesSuccess) {
        final currentExercises =
            List<dynamic>.from((state as FavExrciesSuccess).Fav_exercise);

        // Check if the exercise is already in the list to avoid duplicates
        final alreadyExists = currentExercises.any((exercise) {
          if (exercise is ExerciseEntity) {
            return exercise.id == exerciseEntity.id;
          }
          return false;
        });

        if (!alreadyExists) {
          currentExercises.add(exerciseEntity);
          emit(FavExrciesSuccess(currentExercises));
        }
      } else {
        // If not in success state, reload the entire list
        getFavExercises();
      }
    } catch (e) {
      // If there's an error, reload the list to ensure consistency
      getFavExercises();
    }
  }

  Future<void> removeFromFavorites(ExerciseEntity exercise) async {
    try {
      await favExerciesRepoImp.databaseService
          .removeWorkoutFromFavorites(getCurrentUserId(), exercise.toModel());

      // Update the current state by removing the exercise if we're in success state
      if (state is FavExrciesSuccess) {
        final currentExercises = (state as FavExrciesSuccess).Fav_exercise;
        final updatedExercises = currentExercises.where((e) {
          if (e is ExerciseEntity) {
            return e.id != exercise.id;
          }
          return true;
        }).toList();
        emit(FavExrciesSuccess(updatedExercises));
      }
    } catch (e) {
      // If there's an error, reload the list to ensure consistency
      getFavExercises();
    }
  }
}

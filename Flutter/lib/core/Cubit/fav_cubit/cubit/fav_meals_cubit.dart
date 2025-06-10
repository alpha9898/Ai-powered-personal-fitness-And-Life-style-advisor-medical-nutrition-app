import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/core/Entity/MealEntity.dart';
import 'package:graduation_project_ui/core/Repo/Fav_Meals_Repo_Imp.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Id.dart';
part 'fav_meals_state.dart';

class FavMealsCubit extends Cubit<FavMealsState> {
  final FavMealsRepoImp favMealsRepoImp;
  FavMealsCubit({required this.favMealsRepoImp}) : super(FavMealsInitial());

  Future<void> getFavMeals() async {
    emit(FavMealsLoading());
    var result = await favMealsRepoImp.getMeals();
    result.fold((failuers) => emit(FavMealsFailure(failuers.Massage)),
        (meals) => emit(FavMealsSuccess(meals)));
  }

  Future<void> addFavMeal(Mealentity mealentity) async {
    await favMealsRepoImp.databaseService
        .addMealToFavorites(getCurrentUserId(), mealentity.toModel());

    // Update the current state with the new meal if we're in success state
    if (state is FavMealsSuccess) {
      final currentMeals = (state as FavMealsSuccess).favMeals;
      // Check if the meal is already in the list to avoid duplicates
      final alreadyExists = currentMeals.any((m) {
        if (m is Mealentity) {
          return m.id == mealentity.id;
        }
        return false;
      });

      if (!alreadyExists) {
        final updatedMeals = List.from(currentMeals)..add(mealentity);
        emit(FavMealsSuccess(updatedMeals));
      }
    }
  }

  Future<void> removeFromFavorites(Mealentity meal) async {
    try {
      await favMealsRepoImp.databaseService
          .removeMealFromFavorites(getCurrentUserId(), meal.toModel());

      // Update the current state by removing the meal if we're in success state
      if (state is FavMealsSuccess) {
        final currentMeals = (state as FavMealsSuccess).favMeals;
        print('Before removal: ${currentMeals.length} meals');
        print('Removing meal with ID: ${meal.id}');

        final updatedMeals = currentMeals.where((m) {
          if (m is Mealentity) {
            final shouldKeep = m.id != meal.id;
            if (!shouldKeep) {
              print('Found and removing meal: ${m.name} (${m.id})');
            }
            return shouldKeep;
          }
          return true; // Keep items that are not Mealentity (shouldn't happen but safe)
        }).toList();

        print('After removal: ${updatedMeals.length} meals');
        emit(FavMealsSuccess(updatedMeals));
      } else {
        print(
            'State is not FavMealsSuccess, current state: ${state.runtimeType}');
      }
    } catch (e) {
      print('Error removing meal from favorites: $e');
    }
  }

  Future<bool> isMealFavorite(String mealId) async {
    try {
      var favData = await favMealsRepoImp.databaseService
          .fetchFavoriteMeals(getCurrentUserId());
      final Map<String, dynamic>? docData = favData.data();

      if (docData == null || !docData.containsKey('favoriteMeals')) {
        return false;
      }

      final favorites = (docData['favoriteMeals'] as List? ?? []);
      return favorites.any((meal) => meal['id'] == mealId);
    } catch (e) {
      return false;
    }
  }
}

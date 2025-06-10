import 'package:bloc/bloc.dart';
import 'package:graduation_project_ui/core/Entity/ExerciseEntity.dart';
import 'package:graduation_project_ui/core/Repo/Exercise_Repo.dart';
import 'package:graduation_project_ui/core/Repo/Exercise_Repo_impl.dart';
import 'package:meta/meta.dart';

part 'exercies_state.dart';

class ExerciesCubit extends Cubit<ExerciesState> {
  final ExerciseRepo exerciseRepoImpl;
  ExerciesCubit({required this.exerciseRepoImpl}) : super(ExerciesInitial());

  Future<void> getExercises() async {
    emit(ExerciesLoding());
    var result = await exerciseRepoImpl.getExercises();
    result.fold((failuers) => emit(ExerciesFailure(failuers.Massage)),
        (products) => emit(ExerciesSuccess(products)));
  }
}

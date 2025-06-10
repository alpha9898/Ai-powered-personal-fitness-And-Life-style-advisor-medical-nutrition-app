import 'package:bloc/bloc.dart';
import 'package:graduation_project_ui/core/Entity/ExerciseEntity.dart';
import 'package:graduation_project_ui/core/Repo/Exercise_Repo.dart';
import 'package:graduation_project_ui/core/helper/getDailyRandomIndexes.dart';
import 'package:meta/meta.dart';

part 'recommindtion_exercies_state.dart';

class RecommindtionExerciesCubit extends Cubit<RecommindtionExerciesState> {
  final ExerciseRepo exerciseRepoImpl;
  RecommindtionExerciesCubit({required this.exerciseRepoImpl})
      : super(RecommindtionExerciesInitial());

  Future<void> getRecommindtionExercies(String bodycondition) {
    emit(RecommindtionExerciesLoding());
    return exerciseRepoImpl
        .getrecommendedExercises(bodycondition)
        .then((value) {
      value.fold(
        (failuers) => emit(RecommindtionExerciesFailure(failuers.Massage)),
        (allExercises) {
          if (allExercises.length < 5) {
            emit(RecommindtionExerciesFailure("عدد التمارين غير كافي"));
          } else {
            final indexes = getDailyRandomIndexes(total: allExercises.length);
            final dailyExercises = indexes.map((i) => allExercises[i]).toList();
            emit(RecommindtionExerciesSuccess(dailyExercises));
          }
        },
      );
    });
  }
}

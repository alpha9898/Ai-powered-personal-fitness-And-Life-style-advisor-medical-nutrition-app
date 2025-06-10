part of 'recommindtion_exercies_cubit.dart';

@immutable
sealed class RecommindtionExerciesState {}

final class RecommindtionExerciesInitial extends RecommindtionExerciesState {}

final class RecommindtionExerciesLoding extends RecommindtionExerciesState {}

final class RecommindtionExerciesSuccess extends RecommindtionExerciesState {
  final List<ExerciseEntity> Exerciselist;
  RecommindtionExerciesSuccess(this.Exerciselist);
}

final class RecommindtionExerciesFailure extends RecommindtionExerciesState {
  final String message;
  RecommindtionExerciesFailure(this.message);
}

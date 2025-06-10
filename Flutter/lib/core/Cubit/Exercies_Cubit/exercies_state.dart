part of 'exercies_cubit.dart';

@immutable
sealed class ExerciesState {}

final class ExerciesInitial extends ExerciesState {}

final class ExerciesLoding extends ExerciesState {}

final class ExerciesSuccess extends ExerciesState {
  final List<ExerciseEntity> exercies;

  ExerciesSuccess(this.exercies);
}

final class ExerciesFailure extends ExerciesState {
  final String message;

  ExerciesFailure(this.message);
}

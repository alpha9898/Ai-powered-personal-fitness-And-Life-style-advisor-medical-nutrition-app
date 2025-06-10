import 'package:dartz/dartz.dart';
import 'package:graduation_project_ui/core/Entity/ExerciseEntity.dart';
import 'package:graduation_project_ui/core/Errors/failuers.dart';

abstract class ExerciseRepo {
  Future<Either<Failuers, List<ExerciseEntity>>> getExercises();
  Future<Either<Failuers, List<ExerciseEntity>>> getrecommendedExercises(
      String bodycondition);
}

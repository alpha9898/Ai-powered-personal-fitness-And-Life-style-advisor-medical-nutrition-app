import 'package:dartz/dartz.dart';
import 'package:graduation_project_ui/core/Entity/ExerciseEntity.dart';
import 'package:graduation_project_ui/core/Errors/failuers.dart';
import 'package:graduation_project_ui/core/Models/ExerciseModel.dart';
import 'package:graduation_project_ui/core/Repo/Exercise_Repo.dart';
import 'package:graduation_project_ui/core/Services/Data_Base_Service.dart';
import 'package:graduation_project_ui/core/Utils/Backend_const.dart';

class ExerciseRepoImpl extends ExerciseRepo {
  final DatabaseService databaseService;
  ExerciseRepoImpl({required this.databaseService});

  @override
  Future<Either<Failuers, List<ExerciseEntity>>> getExercises() async {
    try {
      var data = await databaseService.getData(path: BackendConst.getExercises)
          as List<Map<String, dynamic>>;
      List<ExerciseEntity> exercises =
          data.map((e) => Exercisemodel.fromJson(e).toEntity()).toList();
      return Right(exercises);
    } on Exception catch (e) {
      return Left(ServerFailuers(e.toString()));
    }
  }

  @override
  Future<Either<Failuers, List<ExerciseEntity>>> getrecommendedExercises(
      String bodycondition) async {
    if (bodycondition == 'Underweight') {
      try {
        var data = await databaseService.getData(
                path: BackendConst.getUnderweightExercises)
            as List<Map<String, dynamic>>;
        List<ExerciseEntity> exercises =
            data.map((e) => Exercisemodel.fromJson(e).toEntity()).toList();
        return Right(exercises);
      } on Exception catch (e) {
        return Left(ServerFailuers(e.toString()));
      }
    } else if (bodycondition == 'Overweight' || bodycondition == 'Obese') {
      try {
        var data = await databaseService.getData(
                path: BackendConst.getOverweightExercises)
            as List<Map<String, dynamic>>;
        List<ExerciseEntity> exercises =
            data.map((e) => Exercisemodel.fromJson(e).toEntity()).toList();
        return Right(exercises);
      } on Exception catch (e) {
        return Left(ServerFailuers(e.toString()));
      }
    } else if (bodycondition == 'Normal weight') {
      try {
        var data =
            await databaseService.getData(path: BackendConst.getNormalExercises)
                as List<Map<String, dynamic>>;
        List<ExerciseEntity> exercises =
            data.map((e) => Exercisemodel.fromJson(e).toEntity()).toList();
        return Right(exercises);
      } on Exception catch (e) {
        return Left(ServerFailuers(e.toString()));
      }
    } else {
      try {
        var data =
            await databaseService.getData(path: BackendConst.getNormalExercises)
                as List<Map<String, dynamic>>;
        List<ExerciseEntity> exercises =
            data.map((e) => Exercisemodel.fromJson(e).toEntity()).toList();
        return Right(exercises);
      } on Exception catch (e) {
        return Left(ServerFailuers(e.toString()));
      }
    }
  }
}

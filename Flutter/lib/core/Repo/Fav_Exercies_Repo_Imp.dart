import 'package:dartz/dartz.dart';
import 'package:graduation_project_ui/core/Entity/ExerciseEntity.dart';
import 'package:graduation_project_ui/core/Errors/failuers.dart';
import 'package:graduation_project_ui/core/Models/ExerciseModel.dart';
import 'package:graduation_project_ui/core/Services/Data_Base_Service.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Id.dart';

class FavExerciesRepoImp {
  DatabaseService databaseService;
  FavExerciesRepoImp({required this.databaseService});

  Future<Either<Failuers, List<dynamic>>> getExercises() async {
    try {
      var data =
          await databaseService.fetchFavoriteWorkouts(getCurrentUserId());
      final Map<String, dynamic>? docData = data.data();

      // Safe access to favoriteWorkouts field
      final List<dynamic> exercises = [];
      if (docData != null && docData.containsKey('favoriteWorkouts')) {
        final favoriteWorkoutsList = docData['favoriteWorkouts'] as List? ?? [];
        for (var exerciseData in favoriteWorkoutsList) {
          try {
            exercises.add(Exercisemodel.fromJson(exerciseData).toEntity());
          } catch (e) {
            // Skip invalid exercise data
            continue;
          }
        }
      }

      return Right(exercises);
    } on Exception catch (e) {
      return Left(ServerFailuers(e.toString()));
    }
  }
}

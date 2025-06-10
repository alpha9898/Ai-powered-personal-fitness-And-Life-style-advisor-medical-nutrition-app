import 'package:dartz/dartz.dart';
import 'package:graduation_project_ui/core/Entity/MealEntity.dart';
import 'package:graduation_project_ui/core/Errors/failuers.dart';
import 'package:graduation_project_ui/core/Models/MealModel.dart';
import 'package:graduation_project_ui/core/Services/Data_Base_Service.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Id.dart';

class FavMealsRepoImp {
  DatabaseService databaseService;
  FavMealsRepoImp({required this.databaseService});

  Future<Either<Failuers, List<dynamic>>> getMeals() async {
    try {
      var data = await databaseService.fetchFavoriteMeals(getCurrentUserId());
      final Map<String, dynamic>? docData = data.data();

      // Safe access to favoriteMeals field
      final List<dynamic> meals = [];
      if (docData != null && docData.containsKey('favoriteMeals')) {
        final favoriteMealsList = docData['favoriteMeals'] as List? ?? [];
        for (var mealData in favoriteMealsList) {
          try {
            meals.add(Mealmodel.fromJson(mealData).toEntity());
          } catch (e) {
            // Skip invalid meal data
            continue;
          }
        }
      }

      return Right(meals);
    } on Exception catch (e) {
      return Left(ServerFailuers(e.toString()));
    }
  }
}

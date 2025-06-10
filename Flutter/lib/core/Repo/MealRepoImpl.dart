import 'package:dartz/dartz.dart';
import 'package:graduation_project_ui/core/Entity/MealEntity.dart';
import 'package:graduation_project_ui/core/Errors/failuers.dart';
import 'package:graduation_project_ui/core/Models/MealModel.dart';
import 'package:graduation_project_ui/core/Repo/MealRepo.dart';
import 'package:graduation_project_ui/core/Services/Data_Base_Service.dart';
import 'package:graduation_project_ui/core/Utils/Backend_const.dart';

class Mealrepoimpl implements Mealrepo {
  final DatabaseService databaseService;

  Mealrepoimpl({required this.databaseService});
  @override
  Future<Either<Failuers, List<Mealentity>>> getMeals() async {
    try {
      final data = await databaseService.getData(path: BackendConst.getMeals)
          as List<Map<String, dynamic>>;
      List<Mealentity> meals =
          data.map((e) => Mealmodel.fromJson(e).toEntity()).toList();
      return Right(meals);
    } on Exception catch (e) {
      return Left(ServerFailuers(e.toString()));
    }
  }
}

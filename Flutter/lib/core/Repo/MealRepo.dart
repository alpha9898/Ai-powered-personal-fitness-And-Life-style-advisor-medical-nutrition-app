import 'package:dartz/dartz.dart';
import 'package:graduation_project_ui/core/Entity/MealEntity.dart';
import 'package:graduation_project_ui/core/Errors/failuers.dart';

abstract class Mealrepo {
  Future<Either<Failuers, List<Mealentity>>> getMeals();
}

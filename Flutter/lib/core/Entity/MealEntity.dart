import 'package:graduation_project_ui/core/Models/MealModel.dart';

class Mealentity {
  final String id;
  final String name;
  final int Calories;
  final String Category;
  final String Ingredients;
  final String Type;
  String? image;

  Mealentity({
    required this.id,
    required this.name,
    required this.Calories,
    required this.Category,
    required this.Ingredients,
    required this.Type,
    this.image,
  });

  Mealmodel toModel() {
    return Mealmodel(
      id: id,
      name: name,
      Calories: Calories,
      Category: Category,
      Ingredients: Ingredients,
      Type: Type,
      image: image,
    );
  }
}

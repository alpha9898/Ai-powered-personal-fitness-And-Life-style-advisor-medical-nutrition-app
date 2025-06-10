import 'package:graduation_project_ui/core/Entity/MealEntity.dart';

class Mealmodel {
  final String id;
  final String name;
  final int Calories;
  final String Category;
  final String Ingredients;
  final String Type;
  String? image;

  Mealmodel({
    required this.id,
    required this.name,
    required this.Calories,
    required this.Category,
    required this.Ingredients,
    required this.Type,
    this.image,
  });

  factory Mealmodel.fromJson(Map<String, dynamic> json) => Mealmodel(
        id: json['id'],
        name: json['Meal Name'],
        Calories: json['Calories'],
        Category: json['Category'],
        Ingredients: json['Ingredients'],
        Type: json['Meal Type'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'Meal Name': name,
        'Calories': Calories,
        'Category': Category,
        'Ingredients': Ingredients,
        'Meal Type': Type,
        'image': image,
      };

  Mealentity toEntity() {
    return Mealentity(
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

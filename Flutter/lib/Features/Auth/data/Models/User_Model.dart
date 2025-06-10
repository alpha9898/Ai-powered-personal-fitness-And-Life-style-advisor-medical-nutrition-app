import 'package:graduation_project_ui/Features/Auth/domin/Entites/User_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String email,
    String? profileImage,
    double? weight,
    double? height,
    String? gender,
    int? age,
    String? bodyCondition,
    List<String> recommendedWorkouts = const [],
    List<String> favoriteWorkouts = const [],
    List<String> recommendedMeals = const [],
  }) : super(
          id: id,
          name: name,
          email: email,
          profileImage: profileImage,
          weight: weight,
          height: height,
          gender: gender,
          age: age,
          bodyCondition: bodyCondition,
          recommendedWorkouts: recommendedWorkouts,
          favoriteWorkouts: favoriteWorkouts,
          recommendedMeals: recommendedMeals,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      weight: json['weight']?.toDouble(),
      height: json['height']?.toDouble(),
      gender: json['gender'],
      age: json['age']?.toInt(),
      bodyCondition: json['bodyCondition'],
      recommendedWorkouts: List<String>.from(json['recommendedWorkouts'] ?? []),
      favoriteWorkouts: List<String>.from(json['favoriteWorkouts'] ?? []),
      recommendedMeals: List<String>.from(json['recommendedMeals'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'weight': weight,
      'height': height,
      'gender': gender,
      'age': age,
      'bodyCondition': bodyCondition,
      'recommendedWorkouts': recommendedWorkouts,
      'favoriteWorkouts': favoriteWorkouts,
      'recommendedMeals': recommendedMeals,
    };
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      profileImage: user.profileImage,
      weight: user.weight,
      height: user.height,
      gender: user.gender,
      age: user.age,
      bodyCondition: user.bodyCondition,
      recommendedWorkouts: user.recommendedWorkouts,
      favoriteWorkouts: user.favoriteWorkouts,
      recommendedMeals: user.recommendedMeals,
    );
  }
}

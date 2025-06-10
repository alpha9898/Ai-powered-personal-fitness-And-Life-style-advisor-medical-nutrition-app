class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final double? weight;
  final double? height;
  final String? gender;
  final int? age;
  final String? bodyCondition;
  final List<String> recommendedWorkouts;
  final List<String> favoriteWorkouts;
  final List<String> recommendedMeals;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.weight,
    this.height,
    this.gender,
    this.age,
    this.bodyCondition,
    this.recommendedWorkouts = const [],
    this.favoriteWorkouts = const [],
    this.recommendedMeals = const [],
  });
}

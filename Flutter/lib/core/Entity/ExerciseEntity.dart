import 'package:graduation_project_ui/core/Models/ExerciseModel.dart';

class ExerciseEntity {
  final String id;
  final String name;
  String? image;
  final String description;
  String? videoUrl;
  final num calories;
  final num duration;
  final num repetitions;
  final String type;

  ExerciseEntity({
    required this.id,
    required this.name,
    this.image,
    required this.description,
    required this.repetitions,
    this.videoUrl,
    required this.calories,
    required this.duration,
    required this.type,
  });

  Exercisemodel toModel() {
    return Exercisemodel(
      id: id,
      name: name,
      image: image,
      description: description,
      videoUrl: videoUrl,
      calories: calories,
      repetitions: repetitions,
      duration: duration,
      type: type,
    );
  }
}

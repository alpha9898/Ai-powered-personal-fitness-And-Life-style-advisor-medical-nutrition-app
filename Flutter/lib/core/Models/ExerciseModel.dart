import 'package:graduation_project_ui/core/Entity/ExerciseEntity.dart';

class Exercisemodel {
  final String id;
  final String name;
  String? image;
  final String description;
  String? videoUrl;
  final num calories;
  final num repetitions;
  final num duration;
  final String type;

  Exercisemodel({
    required this.id,
    required this.name,
    this.image,
    required this.description,
    this.videoUrl,
    required this.repetitions,
    required this.calories,
    required this.duration,
    required this.type,
  });

  factory Exercisemodel.fromJson(Map<String, dynamic> json) {
    return Exercisemodel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      videoUrl: json['videoUrl'],
      calories: json['calories'],
      duration: json['duration'],
      repetitions: json['repetitions'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'videoUrl': videoUrl,
      'calories': calories,
      'repetitions': repetitions,
      'duration': duration,
      'type': type,
    };
  }

  ExerciseEntity toEntity() {
    return ExerciseEntity(
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

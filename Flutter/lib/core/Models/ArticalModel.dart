import 'package:flutter/foundation.dart';
import 'package:graduation_project_ui/core/Entity/ArticalEntity.dart';

class Articalmodel {
  final String id;
  final String title;
  final String description;
  String? url;
  String? image;
  Articalmodel(
      {required this.id,
      required this.title,
      required this.description,
      this.url,
      this.image});

  factory Articalmodel.fromJson(Map<String, dynamic> json) {
    return Articalmodel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'image': image,
    };
  }

  Articalentity toEntity() {
    return Articalentity(
      id: id,
      title: title,
      description: description,
      url: url,
      image: image,
    );
  }
}

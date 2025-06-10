import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Entity/ArticalEntity.dart';

class ArticlesItem extends StatelessWidget {
  const ArticlesItem(
      {super.key,
      required this.image,
      required this.title,
      required this.articalentity});
  final String image, title;
  final Articalentity articalentity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                articalentity.image!,
                height: 135,
                width: 165,
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              top: 4,
              left: 125,
              child: Icon(Icons.star, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 8),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            articalentity.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

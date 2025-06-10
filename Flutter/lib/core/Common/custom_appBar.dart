import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class CustomAppbar extends StatelessWidget {
  CustomAppbar({super.key, required this.title, required this.onPressed});
  final String title;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.yellow),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(
              color: KPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

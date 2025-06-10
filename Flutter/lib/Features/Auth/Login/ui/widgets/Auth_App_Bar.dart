import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({super.key, required this.title, this.onPressed});
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 45),
      child: Row(
        children: [
          IconButton(
            color: KPacScoundColor,
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            title,
            style: const TextStyle(
                color: KPacScoundColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}

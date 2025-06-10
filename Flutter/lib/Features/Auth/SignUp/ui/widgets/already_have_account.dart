import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class already_have_account extends StatelessWidget {
  const already_have_account({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
              text: 'Already have an account?',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                GoRouter.of(context).pop();
              },
            text: ' Log In',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: KPacScoundColor,
            ),
          ),
        ],
      ),
    );
  }
}

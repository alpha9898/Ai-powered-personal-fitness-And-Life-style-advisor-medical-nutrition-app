import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class terms_and_privacy extends StatelessWidget {
  const terms_and_privacy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: ' Terms of Use ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: KPacScoundColor,
            ),
          ),
          TextSpan(
            text: ' and ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: ' Privacy Policy.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: KPacScoundColor,
            ),
          ),
        ],
      ),
    );
  }
}

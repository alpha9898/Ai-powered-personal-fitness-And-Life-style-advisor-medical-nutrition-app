import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class CoustomIndecator extends StatelessWidget {
  const CoustomIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: 3,
      decorator: DotsDecorator(
        activeColor: Colors.white,
        color: KDarkerPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}

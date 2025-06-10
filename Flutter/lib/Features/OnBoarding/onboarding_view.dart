import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/OnBoarding/Widgets/onbooarding_body.dart';
import 'package:graduation_project_ui/core/Size_config.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const OnbooardingBody();
  }
}

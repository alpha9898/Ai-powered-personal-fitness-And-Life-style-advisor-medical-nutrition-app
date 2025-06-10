import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:graduation_project_ui/Features/OnBoarding/Widgets/next_button.dart';
import 'package:graduation_project_ui/Features/OnBoarding/Widgets/onboarding_screen_item.dart';
import 'package:graduation_project_ui/constant.dart';
import 'package:graduation_project_ui/core/Services/Shared_Preferences_Singlton.dart';
import 'package:graduation_project_ui/core/Size_config.dart';

class OnbooardingBody extends StatefulWidget {
  const OnbooardingBody({super.key});

  @override
  State<OnbooardingBody> createState() => _OnbooardingBodyState();
}

class _OnbooardingBodyState extends State<OnbooardingBody> {
  PageController? pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            PageView(
              controller: pageController,
              children: [
                OnboardingScreenItem(
                  text: 'Start Your Journey Towards A\n More Active Lifestyle',
                  photo: 'assets/images/onboard1-training-workout-gym3.png',
                  svgLogo: 'assets/Svg/Vector.svg',
                ),
                OnboardingScreenItem(
                  text: 'Find nutrition tips that fit\n your lifestyle',
                  photo:
                      'assets/images/beautiful-young-sporty-woman-training-workout-gym3.png',
                  svgLogo: 'assets/Svg/apple.svg',
                ),
                OnboardingScreenItem(
                  text: 'A community for you,\n challenge yourself',
                  photo:
                      'assets/images/beautiful-young-sporty-man-training-workout-gym3.png',
                  svgLogo: 'assets/Svg/Community.svg',
                ),
              ],
            ),
            Positioned(
              top: SizeConfig.screenHeight! * 0.65,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 87.0),
                child: GestureDetector(
                    onTap: () {
                      SharedPreferencesSinglton.setBool(
                          onBoardingSeenKey, true);
                      GoRouter.of(context).push('/Login_view');
                    },
                    child: const NextButton()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:graduation_project_ui/Features/OnBoarding/Widgets/textcontainer.dart';

import 'package:graduation_project_ui/core/Size_config.dart';

class OnboardingScreenItem extends StatelessWidget {
  OnboardingScreenItem(
      {super.key,
      required this.text,
      required this.photo,
      required this.svgLogo});
  String text;
  String photo;
  String svgLogo;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(photo), fit: BoxFit.fill),
            ),
          ),
          Positioned(
            top: SizeConfig.screenHeight! / 2.4,
            child: textcontainer(
              text: text,
              svgLogo: svgLogo,
            ),
          ),
        ],
      ),
    );
  }
}

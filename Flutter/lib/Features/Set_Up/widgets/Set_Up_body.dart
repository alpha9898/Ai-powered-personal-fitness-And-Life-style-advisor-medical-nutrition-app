import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/Common/Button.dart';
import 'package:graduation_project_ui/core/Common/common_container.dart';
import 'package:graduation_project_ui/core/Size_config.dart';

class SetUpBody extends StatelessWidget {
  const SetUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: SizeConfig.screenHeight! * 0.5,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'assets/images/beautiful-young-sporty-woman-training-workout-gym4.png'))),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          textAlign: TextAlign.center,
          'Consistency Is \n The Key To Progress. \n Don t Give Up!',
          style: TextStyle(
              color: KPacScoundColor,
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 12,
        ),
        CommonContainer(
          heighht: SizeConfig.screenHeight! * 0.16,
          width: SizeConfig.screenWidth!,
          child: const Center(
            child: Text(
              textAlign: TextAlign.center,
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
              style: TextStyle(color: Color(0xFF232323)),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push('/The_Gander');
          },
          child: custom_Button(
            text: 'Next',
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/Set_Up/widgets/Age_page.dart';
import 'package:graduation_project_ui/Features/Set_Up/widgets/The_Gender_Row.dart';
import 'package:graduation_project_ui/core/Common/Button.dart';
import 'package:graduation_project_ui/core/Common/common_container.dart';
import 'package:graduation_project_ui/core/Size_config.dart';

class TheGender extends StatefulWidget {
  const TheGender({super.key});

  @override
  State<TheGender> createState() => _TheGenderState();
}

class _TheGenderState extends State<TheGender> {
  String selectedGender = "Male"; // الافتراضي
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'What’s Your Gender',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CommonContainer(
            heighht: SizeConfig.screenWidth! * 0.25,
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
          TheGenderRow(
            onGenderSelected: (gender) {
              setState(() {
                selectedGender = gender;
              });
            },
          ),
          const SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AgePage(
                    selectedGender: selectedGender,
                  ),
                ),
              );
            },
            child: custom_Button(
              text: 'Continue',
            ),
          )
        ],
      ),
    );
  }
}

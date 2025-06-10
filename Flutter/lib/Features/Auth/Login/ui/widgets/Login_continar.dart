import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/OnBoarding/Widgets/Text_Faild.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/Size_config.dart';

class LoginContinar extends StatelessWidget {
  const LoginContinar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight! * 0.27,
      width: SizeConfig.screenWidth,
      color: KPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'UserName or Email',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFaild(
                onSaved: (value) {},
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Password',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFaild(
                onSaved: (value) {},
                obscureText: true,
              ),
              const SizedBox(
                height: 8,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

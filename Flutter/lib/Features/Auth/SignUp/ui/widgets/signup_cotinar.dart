import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/OnBoarding/Widgets/Text_Faild.dart';
import 'package:graduation_project_ui/core/Common/common_container.dart';
import 'package:graduation_project_ui/core/Size_config.dart';

class SignupCotinar extends StatelessWidget {
  const SignupCotinar({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      heighht: null,
      width: SizeConfig.screenWidth!,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Full name',
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
                height: 20,
              ),
              const Text(
                'Email',
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
                height: 20,
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
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Confirm Password',
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
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

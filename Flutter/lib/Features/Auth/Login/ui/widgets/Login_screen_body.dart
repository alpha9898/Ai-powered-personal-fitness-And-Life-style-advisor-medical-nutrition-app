import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/Features/Auth/Login/cubit/Login_cubit/login_cubit.dart';
import 'package:graduation_project_ui/Features/Auth/Login/ui/widgets/Auth_App_Bar.dart';
import 'package:graduation_project_ui/Features/Auth/Login/ui/widgets/Login_continar.dart';
import 'package:graduation_project_ui/Features/Auth/SignUp/ui/widgets/password_faild.dart';
import 'package:graduation_project_ui/Features/OnBoarding/Widgets/Text_Faild.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/Common/Button.dart';

import 'package:graduation_project_ui/core/Size_config.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String user_email_from_Textfaild, user_password_from_Textfaild;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                const AuthAppBar(
                  title: 'Log In ',
                ),
                SizedBox(
                  height: SizeConfig.defaultSize! * 7,
                ),
                const Text(
                  'Welcome',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfig.defaultSize! * 3,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit,\n sed do eiusmod tempor incididunt ut labore et dolore\n magna aliqua. ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: SizeConfig.defaultSize! * 4,
                ),
                Container(
                  height: SizeConfig.screenHeight! * 0.27,
                  width: SizeConfig.screenWidth,
                  color: KPrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Form(
                      key: formKey,
                      autovalidateMode: autovalidateMode,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'UserName or Email',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFaild(
                            onSaved: (value) {
                              user_email_from_Textfaild = value!;
                            },
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Password',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          PasswordFaild(onSaved: (value) {
                            user_password_from_Textfaild = value!;
                          }),
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
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.read<LoginCubit>().signInWithEmailAndPassword(
                          email: user_email_from_Textfaild,
                          password: user_password_from_Textfaild);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }

                    //  GoRouter.of(context).push('/Set_Up');
                  },
                  child: custom_Button(
                    text: 'Log in',
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Don’t have an account?',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            GoRouter.of(context).push('/Sign_Up');
                          },
                        text: ' Sign Up',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: KPacScoundColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

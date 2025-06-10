import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Auth/Login/ui/widgets/Auth_App_Bar.dart';
import 'package:graduation_project_ui/Features/Auth/SignUp/cubit/Sign_Up_Cubit/sign_up_cubit_cubit.dart';
import 'package:graduation_project_ui/Features/Auth/SignUp/ui/widgets/already_have_account.dart';
import 'package:graduation_project_ui/Features/Auth/SignUp/ui/widgets/password_faild.dart';
import 'package:graduation_project_ui/Features/Auth/SignUp/ui/widgets/terms_and_privacy.dart';
import 'package:graduation_project_ui/Features/OnBoarding/Widgets/Text_Faild.dart';
import 'package:graduation_project_ui/core/Common/common_container.dart';
import 'package:graduation_project_ui/core/Size_config.dart';

import 'package:graduation_project_ui/core/Common/Button.dart';
import 'package:graduation_project_ui/core/helper/buld_error_bar.dart';

class SignupBody extends StatefulWidget {
  const SignupBody({super.key});

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String userName_form_text_faild,
      emai_form_text_faild,
      password_form_text_faild,
      Confirm_password_form_text_faild;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            AuthAppBar(
              title: 'Create Account',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'let\'s start!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            CommonContainer(
              heighht: null,
              width: SizeConfig.screenWidth!,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Form(
                  key: formkey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Full name',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFaild(
                        onSaved: (value) {
                          userName_form_text_faild = value!;
                        },
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Email',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFaild(
                        onSaved: (value) {
                          emai_form_text_faild = value!;
                        },
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Password',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PasswordFaild(
                        onSaved: (value) {
                          password_form_text_faild = value!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Confirm Password',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PasswordFaild(
                        onSaved: (value) {
                          Confirm_password_form_text_faild = value!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('By continuing, you agree to ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            terms_and_privacy(),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                if (formkey.currentState!.validate()) {
                  formkey.currentState!.save();
                  if (password_form_text_faild ==
                      Confirm_password_form_text_faild) {
                    context
                        .read<SignUpCubitCubit>()
                        .createUserWithEmailAndPassword(
                            name: userName_form_text_faild,
                            email: emai_form_text_faild,
                            password: password_form_text_faild);
                  } else {
                    Error_bar(context, 'the password does not match ');
                  }
                } else {
                  setState(() {
                    autovalidateMode = AutovalidateMode.always;
                  });
                }
              },
              child: custom_Button(
                text: 'Sign Up',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            already_have_account(),
          ],
        ),
      ),
    );
  }
}

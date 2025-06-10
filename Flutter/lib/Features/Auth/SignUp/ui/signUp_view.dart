import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Auth/SignUp/cubit/Sign_Up_Cubit/sign_up_cubit_cubit.dart';
import 'package:graduation_project_ui/Features/Auth/SignUp/ui/widgets/signUp_body.dart';
import 'package:graduation_project_ui/Features/Auth/domin/Repos/Auth_Repo.dart';
import 'package:graduation_project_ui/core/Services/get_it_Service.dart';
import 'package:graduation_project_ui/core/helper/buld_error_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (context) => SignUpCubitCubit(getIt.get<AuthRepo>()),
        child: SignUp_Body_bloc_consumer(),
      )),
    );
  }
}

class SignUp_Body_bloc_consumer extends StatelessWidget {
  const SignUp_Body_bloc_consumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubitCubit, SignUpCubitState>(
      listener: (context, state) {
        if (state is SignUpCubitSuccess) {
          Navigator.pop(context);
          Error_bar(context, 'Success');
        }
        if (state is SignUpCubitFailure) {
          Error_bar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is SignUpCubitLoading ? true : false,
            child: const SignupBody());
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/Features/Auth/Login/cubit/Login_cubit/login_cubit.dart';
import 'package:graduation_project_ui/Features/Auth/Login/ui/widgets/Login_screen_body.dart';
import 'package:graduation_project_ui/Features/Auth/domin/Repos/Auth_Repo.dart';
import 'package:graduation_project_ui/core/Services/get_it_Service.dart';
import 'package:graduation_project_ui/core/helper/Check_Set_Up.dart';
import 'package:graduation_project_ui/core/helper/buld_error_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt.get<AuthRepo>()),
      child: LoginBodyBlocConsumer(),
    );
  }
}

class LoginBodyBlocConsumer extends StatelessWidget {
  const LoginBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginISuccess) {
          String UserId = state.userEntity.id;
          bool isSetUp = await checkIfUserCompletedSetup(UserId);

          if (isSetUp) {
            GoRouter.of(context).pushReplacement('/Main_view');
          } else {
            GoRouter.of(context).pushReplacement('/Set_Up');
          }

          Error_bar(context, 'Welcoem Hobaa');
        }
        if (state is LoginFailure) {
          Error_bar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is LoginLoading ? true : false,
            child: const LoginScreenBody());
      },
    );
  }
}

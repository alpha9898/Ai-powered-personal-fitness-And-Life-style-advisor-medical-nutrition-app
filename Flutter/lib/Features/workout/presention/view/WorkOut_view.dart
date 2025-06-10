import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/workout/presention/view/widgets/workout_body.dart';

import 'package:graduation_project_ui/core/Cubit/Exercies_Cubit/exercies_cubit.dart';
import 'package:graduation_project_ui/core/Repo/Exercise_Repo.dart';
import 'package:graduation_project_ui/core/Services/get_it_Service.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class WorkoutView extends StatelessWidget {
  const WorkoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: KPacScoundColor),
          backgroundColor: Colors.transparent,
          title: const Text('WorkOut', style: TextStyle(color: KPrimaryColor)),
        ),
        body: SafeArea(
            child: BlocProvider(
          create: (context) =>
              ExerciesCubit(exerciseRepoImpl: getIt.get<ExerciseRepo>()),
          child: const WorkoutBody(),
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Recommendation/widgets/Recommendation_body.dart';
import 'package:graduation_project_ui/core/Cubit/RecommindtionExercies_Cubit/recommindtion_exercies_cubit.dart';
import 'package:graduation_project_ui/core/Repo/Exercise_Repo.dart';

import 'package:graduation_project_ui/core/Services/get_it_Service.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class RecommendationView extends StatelessWidget {
  const RecommendationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: KPacScoundColor),
          backgroundColor: Colors.transparent,
          title: const Text('Recommendation',
              style: TextStyle(color: KPrimaryColor)),
        ),
        body: BlocProvider(
          create: (context) => RecommindtionExerciesCubit(
              exerciseRepoImpl: getIt.get<ExerciseRepo>()),
          child: RecommendationBody(),
        ));
  }
}

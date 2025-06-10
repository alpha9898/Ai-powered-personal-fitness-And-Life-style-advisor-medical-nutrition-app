import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Nutrition/Presention/view/Widgets/Nutrition_body.dart';
import 'package:graduation_project_ui/core/Cubit/Meals_cubit/meals_cubit.dart';

import 'package:graduation_project_ui/core/Repo/MealRepo.dart';
import 'package:graduation_project_ui/core/Services/get_it_Service.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class NutritionView extends StatelessWidget {
  const NutritionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: KPacScoundColor),
          backgroundColor: Colors.transparent,
          title:
              const Text('Nutrition', style: TextStyle(color: KPrimaryColor)),
        ),
        body: BlocProvider(
          create: (context) => MealsCubit(Mealrepoimpl: getIt.get<Mealrepo>()),
          child: const NutritionBody(),
        ));
  }
}

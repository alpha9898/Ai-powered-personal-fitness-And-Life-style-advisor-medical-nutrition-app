import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/Fav_View/Widget/Fav_View_Body.dart';
import 'package:graduation_project_ui/core/Cubit/fav_cubit/cubit/fav_exrcies_cubit.dart';
import 'package:graduation_project_ui/core/Cubit/fav_cubit/cubit/fav_meals_cubit.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class FavView extends StatefulWidget {
  const FavView({super.key});

  @override
  State<FavView> createState() => _FavViewState();
}

class _FavViewState extends State<FavView> {
  @override
  void initState() {
    super.initState();
    // Refresh favorites data when the page is accessed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<FavExrciesCubit>().getFavExercises();
        context.read<FavMealsCubit>().getFavMeals();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: KPacScoundColor),
          backgroundColor: Colors.transparent,
          title: const Text('My Favorites',
              style: TextStyle(color: KPrimaryColor)),
        ),
        body: const SafeArea(
          child: FavViewBody(),
        ));
  }
}

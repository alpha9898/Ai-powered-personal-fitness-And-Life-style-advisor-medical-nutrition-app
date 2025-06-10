import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/Fav_View/Widget/Fav_Exercies_List_View.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/Fav_View/Widget/Fav_Meals_List_View.dart';
import 'package:graduation_project_ui/core/Cubit/fav_cubit/cubit/fav_exrcies_cubit.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class FavViewBody extends StatefulWidget {
  const FavViewBody({super.key});

  @override
  State<FavViewBody> createState() => _FavViewBodyState();
}

class _FavViewBodyState extends State<FavViewBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Your Favorites',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: KPacScoundColor),
            ),
          ),
          const SizedBox(height: 20),

          // Favorite Workouts Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Favorite Workouts',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KPacScoundColor),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Explore Different Workout Styles',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          WorkoutsList_View_blocBuilder(),

          const SizedBox(height: 30),

          // Favorite Meals Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Favorite Meals',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KPacScoundColor),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Your Favorite Recipes',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          FavMealsListView(),
        ],
      ),
    );
  }
}

class WorkoutsList_View_blocBuilder extends StatelessWidget {
  const WorkoutsList_View_blocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavExrciesCubit, FavExrciesState>(
      builder: (context, state) {
        if (state is FavExrciesInitial) {
          context.read<FavExrciesCubit>().getFavExercises();
          return const Center(
            child: CircularProgressIndicator(
              color: KPrimaryColor,
            ),
          );
        } else if (state is FavExrciesLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: KPrimaryColor,
          ));
        } else if (state is FavExrciesSuccess) {
          final favList = state.Fav_exercise;
          if (favList.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'No favorite workouts yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          }
          return Fav_Exercies_List_View(
            Exerciselist: favList,
          );
        } else if (state is FavExrciesFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Error loading workouts: ${state.message}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
          );
        }
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'No favorite workouts yet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}

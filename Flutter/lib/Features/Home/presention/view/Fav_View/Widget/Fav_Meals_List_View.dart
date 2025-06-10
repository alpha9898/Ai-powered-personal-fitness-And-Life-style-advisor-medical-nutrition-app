import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Nutrition/Presention/view/Widgets/Nuration_Item.dart';
import 'package:graduation_project_ui/core/Cubit/fav_cubit/cubit/fav_meals_cubit.dart';
import 'package:graduation_project_ui/core/Entity/MealEntity.dart';

class FavMealsListView extends StatelessWidget {
  const FavMealsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavMealsCubit, FavMealsState>(
      builder: (context, state) {
        if (state is FavMealsInitial) {
          // Load favorites when first accessed
          context.read<FavMealsCubit>().getFavMeals();
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FavMealsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FavMealsSuccess) {
          final favMeals = state.favMeals.cast<Mealentity>();
          if (favMeals.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'No favorite meals yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: favMeals.length,
            itemBuilder: (context, index) => NurationItem(
              mealentity: favMeals[index],
            ),
          );
        } else if (state is FavMealsFailure) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

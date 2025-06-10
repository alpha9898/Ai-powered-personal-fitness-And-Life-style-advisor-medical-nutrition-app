import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Nutrition/Presention/view/Widgets/Nuration_Item.dart';
import 'package:graduation_project_ui/core/Cubit/Meals_cubit/meals_cubit.dart';
import 'package:graduation_project_ui/core/Entity/MealEntity.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class NutritionBody extends StatefulWidget {
  const NutritionBody({super.key});

  @override
  State<NutritionBody> createState() => _NutritionBodyState();
}

class _NutritionBodyState extends State<NutritionBody> {
  @override
  void initState() {
    context.read<MealsCubit>().getMeals();
    // TODO: implement initState
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
              'Recipes for you',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KPacScoundColor),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          List_View_bloc_Builder()
        ],
      ),
    );
  }
}

class List_View_bloc_Builder extends StatelessWidget {
  const List_View_bloc_Builder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsCubit, MealsState>(
      builder: (context, state) {
        if (state is MealsLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: KPrimaryColor,
          ));
        } else if (state is MealsSuccess) {
          return Meals_List_View(
            meals: state.meals,
          );
        } else {
          return const Text('Error');
        }
      },
    );
  }
}

class Meals_List_View extends StatelessWidget {
  final List<Mealentity> meals;
  const Meals_List_View({
    required this.meals,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: meals.length,
        itemBuilder: (context, index) => NurationItem(
              mealentity: meals[index],
            ));
  }
}

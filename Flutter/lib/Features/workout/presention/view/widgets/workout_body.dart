import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/workout/presention/view/widgets/Exercies_List_View.dart';

import 'package:graduation_project_ui/core/Cubit/Exercies_Cubit/exercies_cubit.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class WorkoutBody extends StatefulWidget {
  const WorkoutBody({super.key});

  @override
  State<WorkoutBody> createState() => _WorkoutBodyState();
}

class _WorkoutBodyState extends State<WorkoutBody> {
  @override
  void initState() {
    context.read<ExerciesCubit>().getExercises();
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
              'Let\'s Go WorkOut',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KPacScoundColor),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Explore Different Workout Stylest',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          List_View_blocBuilder()
        ],
      ),
    );

    //ListView.builder(
    //   itemCount: 40,
    //   itemBuilder: (context, index) => const TrainItem(),
    // );
  }
}

class List_View_blocBuilder extends StatelessWidget {
  const List_View_blocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciesCubit, ExerciesState>(
      builder: (context, state) {
        if (state is ExerciesLoding) {
          return Center(
              child: CircularProgressIndicator(
            color: KPrimaryColor,
          ));
        } else if (state is ExerciesSuccess) {
          return Exercies_List_View(
            Exerciselist: state.exercies,
          );
        } else {
          return const Text('Error');
        }
      },
    );
  }
}

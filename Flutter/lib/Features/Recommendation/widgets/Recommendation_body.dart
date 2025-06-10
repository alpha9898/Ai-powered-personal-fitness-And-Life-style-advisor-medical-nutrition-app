import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/RecommendationsTrainItem_ai.dart';
import 'package:graduation_project_ui/core/Cubit/RecommindtionExercies_Cubit/recommindtion_exercies_cubit.dart';

import 'package:graduation_project_ui/core/Utils/App_images.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Data.dart';

class RecommendationBody extends StatefulWidget {
  const RecommendationBody({super.key});

  @override
  State<RecommendationBody> createState() => _RecommendationBodyState();
}

class _RecommendationBodyState extends State<RecommendationBody> {
  @override
  void initState() {
    context
        .read<RecommindtionExerciesCubit>()
        .getRecommindtionExercies(GetUser().bodyCondition.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView_BLocBuilder();
  }
}

class GridView_BLocBuilder extends StatelessWidget {
  const GridView_BLocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommindtionExerciesCubit, RecommindtionExerciesState>(
      builder: (context, state) {
        if (state is RecommindtionExerciesLoding) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RecommindtionExerciesSuccess) {
          final exercises = state.Exerciselist;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // number of items in each row
              mainAxisSpacing: 8.0, // spacing between rows
              crossAxisSpacing: 16.0, // spacing between columns
            ),
            padding: const EdgeInsets.all(8.0), // padding around the grid
            itemCount: state.Exerciselist.length, // total number of items
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return RecommendationstrainitemAi(
                title: exercise.name,
                image: exercise.image!,
                duration: exercise.duration.toString(),
                calories: exercise.calories.toString(),
              );
            },
          );
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}
//  RecommendationstrainitemAi(
//               title: 'squat Exercise',
//               image: Assets.assetsImagesWomanHelpingManGym,
//               duration: '12',
//               calories: '20',
//             ),

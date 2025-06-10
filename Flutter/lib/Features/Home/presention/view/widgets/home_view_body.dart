import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/ArticlesItem_Detalis.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/Articles_item.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/RecommendationsFooditemAi.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/RecommendationsTrainItem_ai.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/Recommendations_widget.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/custom_workout_continar.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/homa_page_header.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/svg_list.dart';
import 'package:graduation_project_ui/core/Cubit/Artical_cubit/artical_cubit.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';
import 'package:graduation_project_ui/core/helper/Random_Number.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    context.read<ArticalCubit>().getArticals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: HomaPageHeader(),
          ),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: SvgList(),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Recommendations_widget(),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Recommendetion_Row_bloc_Listener(),
          ),
          const SizedBox(height: 12),
          CustomWorkoutContinar(),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Articles & Tips',
              style: TextStyle(
                color: Color(0xffE2F163),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Artical_Row_BlocBuilder(),
        ],
      ),
    );
  }
}

class Artical_Row_BlocBuilder extends StatelessWidget {
  const Artical_Row_BlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int number1 = RandomNumberGenerator().getRandomNumber(0, 7);
    final int number2 = RandomNumberGenerator().getRandomNumber(0, 7);
    return BlocBuilder<ArticalCubit, ArticalState>(builder: (context, state) {
      if (state is ArticalLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is ArticalSuccess) {
        {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticlesitemDetalis(
                                  articalentity: state.articals[number1],
                                )),
                      );
                    },
                    child: ArticlesItem(
                      image: Assets.assetsImagesWomanEating,
                      title: 'The Science of Eating Well',
                      articalentity: state.articals[number1],
                    ),
                  ),
                  const SizedBox(width: 26),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticlesitemDetalis(
                                  articalentity: state.articals[number2],
                                )),
                      );
                    },
                    child: ArticlesItem(
                      image: Assets.assetsImagesManTraining,
                      title: '15 Quick & Effective Daily',
                      articalentity: state.articals[number2],
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      } else {
        return const Text('Error');
      }
    });
  }
}

class Recommendetion_Row_bloc_Listener extends StatelessWidget {
  const Recommendetion_Row_bloc_Listener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticalCubit, ArticalState>(
      builder: (context, state) {
        return const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RecommendationsFooditemAi(
              title: 'squat Exercise',
              image: Assets.assetsImagesWomanHelpingManGym,
              duration: '12',
              calories: '20',
            ),
            RecommendationsFooditemAi(
              title: 'Fruit salad',
              image: Assets.assetsImagesEgg,
              duration: '10',
              calories: '15',
            ),
          ],
        );
      },
    );
  }
}

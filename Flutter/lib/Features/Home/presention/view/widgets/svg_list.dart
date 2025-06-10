import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/Features/Home/presention/Models/Svg_Model.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/svg_item.dart';

import 'package:graduation_project_ui/core/Utils/App_images.dart';

class SvgList extends StatelessWidget {
  const SvgList({super.key});

  static var items = [
    SvgModel(
      image: Assets.assetsSvgWorkout,
      color: const Color(0XFF896CFE),
      text: 'Workout',
    ),
    SvgModel(
      image: Assets.assetsSvgProgress,
      color: const Color(0XFF896CFE),
      text: 'Progress',
    ),
    SvgModel(
      image: Assets.assetsSvgNutritionicon,
      color: const Color(0XFF896CFE),
      text: 'Nutrition',
    ),
    SvgModel(
      image: Assets.assetsSvgCommunityicon,
      color: const Color(0XFF896CFE),
      text: 'Community',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              GoRouter.of(context).push('/WorkOut_view');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SvgItem(
                svgModel: items[0],
                height: 7,
              ),
            ),
          ),
          const SizedBox(
            height: 60,
            child: VerticalDivider(
              width: 15,
              thickness: 1,
              color: Color(0xFFB3A0FF),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SvgItem(
                svgModel: items[1],
                height: 7,
              ),
            ),
          ),
          const SizedBox(
            height: 60,
            child: VerticalDivider(
              width: 15,
              thickness: 1,
              color: Color(0xFFB3A0FF),
            ),
          ),
          GestureDetector(
            onTap: () {
              GoRouter.of(context).push('/Nutritions_view');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SvgItem(
                svgModel: items[2],
                height: 7,
              ),
            ),
          ),
          const SizedBox(
            height: 60,
            child: VerticalDivider(
              width: 15,
              thickness: 1,
              color: Color(0xFFB3A0FF),
            ),
          ),
          GestureDetector(
            onTap: () {
              GoRouter.of(context).push('/Community_view');
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SvgItem(
                svgModel: items[3],
                height: 18,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

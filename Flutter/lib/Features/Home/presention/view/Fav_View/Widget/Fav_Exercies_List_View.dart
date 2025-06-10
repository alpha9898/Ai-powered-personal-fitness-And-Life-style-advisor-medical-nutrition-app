import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Common/train_food_tem.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class Fav_Exercies_List_View extends StatelessWidget {
  final List<dynamic> Exerciselist;
  const Fav_Exercies_List_View({
    super.key,
    required this.Exerciselist,
  });

  @override
  Widget build(BuildContext context) {
    log(Exerciselist.length.toString());
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: Exerciselist.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => ExerciesDetiels(
          //             exerciseEntity: Exerciselist[index],
          //           )),
          // );
        },
        child: Train_food_Item(
          image: Assets.assetsImagesUpperBody,
          exerciseEntity: Exerciselist[index],
        ),
      ),
    );
  }
}

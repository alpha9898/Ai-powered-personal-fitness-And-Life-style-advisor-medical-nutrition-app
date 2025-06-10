import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/core/Common/common_container.dart';
import 'package:graduation_project_ui/core/Entity/ExerciseEntity.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class ExerciesDetiels extends StatelessWidget {
  const ExerciesDetiels({super.key, required this.exerciseEntity});
  final ExerciseEntity exerciseEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_sharp,
                      color: Colors.yellow),
                ),
                const Text(
                  'Resources',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                exerciseEntity.name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: KPacScoundColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: KPrimaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'published on September 15',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CommonContainer(
              width: double.infinity,
              heighht: 250,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Center(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(exerciseEntity.image!),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                exerciseEntity.description,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ],
        )),
      ),

      //SafeArea(
      //     child: Column(
      //   children: [
      //     Text(
      //       exerciseEntity.name,
      //       style: const TextStyle(fontSize: 20),
      //     ),
      //     SizedBox(
      //       height: 40,
      //     ),
      //     Text(
      //       exerciseEntity.description,
      //       style: const TextStyle(fontSize: 30),
      //     ),
      //     SizedBox(
      //       height: 40,
      //     ),
      //     Text(
      //       exerciseEntity.calories.toString(),
      //       style: const TextStyle(fontSize: 20),
      //     ),
      //     SizedBox(
      //       height: 40,
      //     ),
      //     Text(
      //       exerciseEntity.duration.toString(),
      //       style: const TextStyle(fontSize: 20),
      //     ),
      //     SizedBox(
      //       height: 40,
      //     ),
      //   ],
      // )),
    );
  }
}

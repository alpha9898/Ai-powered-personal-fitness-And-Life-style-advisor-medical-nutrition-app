import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Entity/ArticalEntity.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class RecommendationsFooditemAi extends StatelessWidget {
  const RecommendationsFooditemAi(
      {super.key,
      required this.title,
      required this.image,
      required this.duration,
      required this.calories});
  final String title, image, duration, calories;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.43,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  image,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      //'squat Exercise',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow:
                          TextOverflow.ellipsis, // هنضيف دي علشان تظهر النقاط
                      maxLines: 1,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.timer,
                              color: KPrimaryColor,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${duration}Muints',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.fireplace,
                              color: KPrimaryColor,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${calories}Kcl',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // const Positioned(
          //   top: 8,
          //   right: 8,
          //   child: Icon(Icons.star, color: Colors.white),
          // ),
        ],
      ),
    );
  }
}

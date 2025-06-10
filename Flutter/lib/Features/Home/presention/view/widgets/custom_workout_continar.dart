import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_ui/Features/Home/presention/Models/BottomNavigationModel.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class CustomWorkoutContinar extends StatelessWidget {
  CustomWorkoutContinar({super.key, this.height});
  double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height * 0.195,
      decoration: const BoxDecoration(color: Color(0xffB3A0FF)),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff232323),
            borderRadius: BorderRadius.circular(20),
          ),
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 0.83,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'Weekly\nChallenge',
                      style: TextStyle(
                        color: Color(0xffE2F163),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'Plank With Hip Twist',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Image.asset(Assets.assetsImagesWomanHelpingManGym2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class navigatorIcon extends StatelessWidget {
  const navigatorIcon({
    super.key,
    required this.isActive,
    required this.bottomNavigationBarEntity,
  });
  final bool isActive;
  final BottomNavigationBarEntity bottomNavigationBarEntity;
  @override
  Widget build(BuildContext context) {
    return isActive
        ? ActiveIcon(
            image: bottomNavigationBarEntity.Activeimage,
            title: bottomNavigationBarEntity.title,
          )
        : inActiveIcon(image: bottomNavigationBarEntity.Activeimage);
  }
}

class inActiveIcon extends StatelessWidget {
  const inActiveIcon({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(image);
  }
}

class ActiveIcon extends StatelessWidget {
  const ActiveIcon({super.key, required this.image, required this.title});
  final String image, title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 8),
        decoration: ShapeDecoration(
          color: const Color(0xFFEEEEEE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: ShapeDecoration(
                color: const Color(0xFF1B5E37),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Center(child: SvgPicture.asset(image)),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF1B5E37),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

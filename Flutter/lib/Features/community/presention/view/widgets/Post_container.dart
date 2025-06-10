import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class Post_container extends StatelessWidget {
  const Post_container({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1.3, color: KPacScoundColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  Assets.assetsImagesProfilePhoto,
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              const Text(
                'Madison',
                style: TextStyle(
                    color: KPacScoundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
              'Lorem ipsum dolor sit amet consectetur. Tortor aenean suspendisse pretium nunc non facilisi.'),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 50,
              ),
              SvgPicture.asset(
                Assets.assetsSvgStarSvg,
                height: 18,
              ),
              SizedBox(
                width: 50,
              ),
              SvgPicture.asset(
                Assets.assetsSvgCommentSvg,
                height: 18,
              ),
              SizedBox(
                width: 50,
              ),
              SvgPicture.asset(
                Assets.assetsSvgSeenSvg,
                height: 18,
              ),
              SizedBox(
                width: 50,
              )
            ],
          ),
        ]),
      ),
    );
  }
}

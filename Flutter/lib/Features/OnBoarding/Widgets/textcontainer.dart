import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/Size_config.dart';

class textcontainer extends StatelessWidget {
  textcontainer({super.key, required this.text, required this.svgLogo});
  String text;
  String svgLogo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(color: KPrimaryColor),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SvgPicture.asset(svgLogo),
          const SizedBox(
            height: 10,
          ),
          Text(
            textAlign: TextAlign.center,
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

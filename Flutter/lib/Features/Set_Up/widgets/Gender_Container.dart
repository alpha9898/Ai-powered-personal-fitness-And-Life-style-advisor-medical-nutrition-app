import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_ui/Features/Set_Up/Models/GenderContainer_Model.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class GenderContainer extends StatelessWidget {
  GenderContainer(
      {super.key, required this.IsActve, required this.gendercontainerModel});
  GendercontainerModel gendercontainerModel;
  bool IsActve;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 162,
          height: 162,
          decoration: BoxDecoration(
            color: IsActve
                ? KPacScoundColor
                : const Color(0xFFFFFFFF).withAlpha(9),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 1,
              color: IsActve ? KPacScoundColor : const Color(0xFFFFFFFF),
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              gendercontainerModel.Image,
              colorFilter:
                  const ColorFilter.mode(Colors.black, BlendMode.modulate),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          gendercontainerModel.gender,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

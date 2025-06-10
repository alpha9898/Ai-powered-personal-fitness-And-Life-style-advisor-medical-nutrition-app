import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_ui/Features/Home/presention/Models/Svg_Model.dart';

class SvgItem extends StatelessWidget {
  SvgItem({super.key, required this.svgModel, this.height = 7});
  SvgModel svgModel;
  double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          svgModel.image,
          colorFilter:
              const ColorFilter.mode(Color(0XFF896CFE), BlendMode.modulate),
        ),
        SizedBox(
          height: height,
        ),
        Text(
          svgModel.text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

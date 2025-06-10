import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class CommonContainer extends StatelessWidget {
  CommonContainer(
      {super.key, required this.child, this.heighht, required this.width});
  Widget child;
  double? width, heighht;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: heighht,
      decoration: const BoxDecoration(color: KDarkerPrimaryColor),
      child: child,
    );
  }
}

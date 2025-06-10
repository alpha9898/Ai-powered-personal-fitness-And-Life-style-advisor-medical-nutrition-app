import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/OnBoarding/Widgets/Text_Faild.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class PasswordFaild extends StatefulWidget {
  const PasswordFaild({super.key, this.onSaved});
  final void Function(String?)? onSaved;

  @override
  State<PasswordFaild> createState() => _PasswordFaildState();
}

class _PasswordFaildState extends State<PasswordFaild> {
  @override
  bool isHide = true;
  Widget build(BuildContext context) {
    return TextFaild(
      onSaved: widget.onSaved,
      obscureText: isHide,
      icon: GestureDetector(
        onTap: () {
          isHide = !isHide;
          setState(() {});
        },
        child: isHide
            ? Icon(Icons.remove_red_eye, color: KPrimaryColor)
            : Icon(Icons.visibility_off, color: KPrimaryColor),
      ),
    );
  }
}

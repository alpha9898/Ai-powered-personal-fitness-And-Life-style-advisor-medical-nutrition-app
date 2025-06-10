import 'package:flutter/material.dart';

class custom_Button extends StatelessWidget {
  custom_Button({super.key, required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 178,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: const Color(0XFFFFFFFF)),
          color: const Color(0XFFFFFFFF).withAlpha(14),
          borderRadius: BorderRadius.circular(100)),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )),
    );
  }
}

import 'package:flutter/material.dart';

class packground_widget extends StatelessWidget {
  const packground_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(color: Color(0xffB3A0FF)),
    );
  }
}

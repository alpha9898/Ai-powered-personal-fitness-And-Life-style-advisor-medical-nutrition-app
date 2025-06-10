import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/community/Models/continars_items.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class Continars extends StatelessWidget {
  Continars(this.it);
  item1 it;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(it.image), fit: BoxFit.fill),
      ),
      child: Text(
        it.text,
        style: TextStyle(
            fontSize: 20, color: KPacScoundColor, fontWeight: FontWeight.bold),
      ),
      width: it.width,
      height: it.hight,
    );
  }
}

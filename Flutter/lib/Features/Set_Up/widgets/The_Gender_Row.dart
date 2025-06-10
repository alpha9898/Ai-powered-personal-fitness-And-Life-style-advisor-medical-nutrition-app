import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/Set_Up/Models/GenderContainer_Model.dart';
import 'package:graduation_project_ui/Features/Set_Up/widgets/Gender_Container.dart';

class TheGenderRow extends StatefulWidget {
  final Function(String) onGenderSelected; // Callback Function
  const TheGenderRow({super.key, required this.onGenderSelected});

  @override
  State<TheGenderRow> createState() => _TheGenderRowState();
}

class _TheGenderRowState extends State<TheGenderRow> {
  int seletedIndex = 0;
  final List<GendercontainerModel> items = [
    GendercontainerModel(
      Image: 'assets/Svg/Male_Vector.svg',
      gender: 'male',
    ),
    GendercontainerModel(
      Image: 'assets/Svg/Female_Vector.svg',
      gender: 'female',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
        children: items.asMap().entries.map((e) {
      int index = e.key;
      var item = e.value;
      return GestureDetector(
        onTap: () {
          setState(
            () {
              if (seletedIndex != index) {
                seletedIndex = index;
                print(seletedIndex);
                widget.onGenderSelected(item.gender); // إرسال قيمة الجنس
                if (index == 0) {
                  print('Male');
                } else {
                  print('FeMale');
                }
              }
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: GenderContainer(
            IsActve: seletedIndex == index,
            gendercontainerModel: item,
          ),
        ),
      );
    }).toList());
  }
}

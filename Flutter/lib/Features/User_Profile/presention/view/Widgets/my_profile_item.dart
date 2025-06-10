import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_ui/Features/User_Profile/presention/Models/my_profile_item_model.dart';

class MyProfileItem extends StatelessWidget {
  const MyProfileItem(
      {super.key, required this.myProfileItemModel, this.onTap});

  final MyProfileItemModel myProfileItemModel;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(myProfileItemModel.image),
      title: Text(
        myProfileItemModel.name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: const Icon(Icons.arrow_right, color: Colors.yellow),
    );
  }
}

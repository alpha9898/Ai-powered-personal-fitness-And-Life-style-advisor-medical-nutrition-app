import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/User_Profile/presention/Models/my_profile_item_model.dart';
import 'package:graduation_project_ui/Features/User_Profile/presention/view/Widgets/my_profile_item.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: KPacScoundColor),
        backgroundColor: Colors.transparent,
        title: const Text('Setting', style: TextStyle(color: KPrimaryColor)),
      ),
      body: Column(
        children: [
          MyProfileItem(
            onTap: () {},
            myProfileItemModel: MyProfileItemModel(
              name: 'Notification Setting',
              image: Assets.assetsSvgNotificationSetting,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          MyProfileItem(
            onTap: () {},
            myProfileItemModel: MyProfileItemModel(
              name: 'Password Setting',
              image: Assets.assetsSvgPasswordSetting,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          MyProfileItem(
            onTap: () {},
            myProfileItemModel: MyProfileItemModel(
              name: 'Delete Account',
              image: Assets.assetsSvgDeletAccount,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/Features/User_Profile/presention/Models/my_profile_item_model.dart';
import 'package:graduation_project_ui/Features/User_Profile/presention/view/Widgets/my_profile_item.dart';
import 'package:graduation_project_ui/Features/User_Profile/presention/view/Widgets/packground_widget.dart';
import 'package:graduation_project_ui/Features/User_Profile/presention/view/Widgets/photo_and_name_widget.dart';
import 'package:graduation_project_ui/Features/User_Profile/presention/view/Widgets/profile_container_information.dart';
import 'package:graduation_project_ui/core/Services/Fire_Base_Auth_Service.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Id.dart';
import 'package:graduation_project_ui/core/helper/showLogoutConfirmation.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [const packground_widget(), my_prifle_items()],
    );
  }
}

class my_prifle_items extends StatelessWidget {
  my_prifle_items({super.key});

  String userid = getCurrentUserId();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_sharp,
                    color: Colors.yellow),
              ),
              const Text(
                'My Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const photo_and_name_widget(),
          const SizedBox(height: 20),
          profile_container_information(
            userId: userid,
          ),
          const SizedBox(height: 20),
          MyProfileItem(
            onTap: () {},
            myProfileItemModel: MyProfileItemModel(
              name: 'Profile',
              image: Assets.assetsSvgProfileSvg,
            ),
          ),
          const SizedBox(height: 5),
          MyProfileItem(
            onTap: () {},
            myProfileItemModel: MyProfileItemModel(
              name: 'Favorites',
              image: Assets.assetsSvgFavSvg,
            ),
          ),
          const SizedBox(height: 5),
          MyProfileItem(
            onTap: () {
              GoRouter.of(context).push('/Setting');
            },
            myProfileItemModel: MyProfileItemModel(
              name: 'Settings',
              image: Assets.assetsSvgSettingSvg,
            ),
          ),
          const SizedBox(height: 5),
          MyProfileItem(
            onTap: () {
              GoRouter.of(context).push('/HelpUser');
            },
            myProfileItemModel: MyProfileItemModel(
              name: 'Help',
              image: Assets.assetsSvgHelpSvg,
            ),
          ),
          const SizedBox(height: 5),
          MyProfileItem(
            onTap: () {},
            myProfileItemModel: MyProfileItemModel(
              name: 'Privacy Policy',
              image: Assets.assetsSvgPraivcySvg,
            ),
          ),
          const SizedBox(height: 5),
          MyProfileItem(
            onTap: () {
              showLogoutConfirmation(context);
            },
            myProfileItemModel: MyProfileItemModel(
              name: 'Log Out',
              image: Assets.assetsSvgLogOutSvg,
            ),
          ),
        ],
      ),
    );
  }
}

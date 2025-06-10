import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/Features/User_Profile/presention/Models/my_profile_item_model.dart';
import 'package:graduation_project_ui/Features/User_Profile/presention/view/Widgets/my_profile_item.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';

class HelpUser extends StatelessWidget {
  const HelpUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  'Help & FAQs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Text(
              'How can we help you?',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            MyProfileItem(
              onTap: () {},
              myProfileItemModel: MyProfileItemModel(
                  name: 'Facebook', image: Assets.assetsSvgFasebookSvg),
            ),
            const SizedBox(
              height: 16,
            ),
            MyProfileItem(
              onTap: () {},
              myProfileItemModel: MyProfileItemModel(
                  name: 'Whatsapp', image: Assets.assetsSvgWhatsappSvg),
            ),
            const SizedBox(
              height: 16,
            ),
            MyProfileItem(
              onTap: () {},
              myProfileItemModel: MyProfileItemModel(
                  name: 'Instagram', image: Assets.assetsSvgInstagramSvg),
            ),
            const SizedBox(
              height: 16,
            ),
            MyProfileItem(
              onTap: () {},
              myProfileItemModel: MyProfileItemModel(
                  name: 'Website', image: Assets.assetsSvgWebsite),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

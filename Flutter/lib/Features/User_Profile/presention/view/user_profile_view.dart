import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/User_Profile/presention/view/Widgets/user_profile_body.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserProfileBody(),
    );
  }
}

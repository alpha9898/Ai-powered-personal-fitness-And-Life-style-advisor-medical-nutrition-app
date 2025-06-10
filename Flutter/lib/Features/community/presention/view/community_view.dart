import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/community/presention/view/widgets/community_view_body.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: KPacScoundColor),
        backgroundColor: Colors.transparent,
        title: const Text('Community', style: TextStyle(color: KPrimaryColor)),
      ),
      body: SafeArea(child: CommunityViewBody()),
    );
  }
}

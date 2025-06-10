import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/community/News/View/News_body.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Health', style: TextStyle(fontSize: 30)),
            Text('Cloud', style: TextStyle(fontSize: 30, color: KPrimaryColor)),
          ],
        ),
      ),
      body: NewsBody(),
    );
  }
}

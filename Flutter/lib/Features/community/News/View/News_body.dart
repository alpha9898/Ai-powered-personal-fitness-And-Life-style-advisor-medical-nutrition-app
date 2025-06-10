import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/community/Models/News_List_Views.dart';
import 'package:graduation_project_ui/Features/community/News/View/News_Lisr_View_Builder.dart';

class NewsBody extends StatelessWidget {
  const NewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [NewWidgetListBuilder()]);
  }
}

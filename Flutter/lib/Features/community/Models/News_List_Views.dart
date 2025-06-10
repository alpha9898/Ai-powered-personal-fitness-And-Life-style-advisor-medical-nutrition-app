import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/community/Models/New_widget.dart';
import 'package:graduation_project_ui/Features/community/Models/articals_model.dart';

class NewsLisrView extends StatelessWidget {
  List<ArticalsModel> articals;
  NewsLisrView({super.key, required this.articals});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: articals.length, (
        context,
        index,
      ) {
        return NewWidget(articals[index]);
      }),
    );
  }
}

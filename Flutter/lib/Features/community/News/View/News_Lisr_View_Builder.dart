import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/community/Models/News_List_Views.dart';
import 'package:graduation_project_ui/Features/community/Models/articals_model.dart';
import 'package:graduation_project_ui/core/Services/NewsService.dart';

class NewWidgetListBuilder extends StatefulWidget {
  const NewWidgetListBuilder({super.key});
  @override
  State<NewWidgetListBuilder> createState() => _NewListViewBuilderState();
}

class _NewListViewBuilderState extends State<NewWidgetListBuilder> {
  List<ArticalsModel> articals = [];
  bool isloding = true;
  var future;
  @override
  void initState() {
    // TODO: implement initState
    future = NewsService(Dio()).getNews('Healthcare');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticalsModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return NewsLisrView(articals: snapshot.data ?? []);
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(child: Text('Oops there is problem '));
        } else {
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
    // isloding
    //     ? SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()))
    //     : NewsLisrView(
    //         articals: articals,
    //       );
  }
}

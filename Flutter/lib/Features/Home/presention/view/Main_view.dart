import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/Home_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/CustomBottomnavigatiorBar.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/Main_view_body.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/home_view_body.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentViewIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Custombottomnavigatiorbar(
        onItemTapped: (int value) {
          currentViewIndex = value;
          setState(() {});
        },
      ),
      body: SafeArea(
          child: MainViewBody(
        currentViewIndex: currentViewIndex,
      )),
    );
  }
}

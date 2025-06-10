import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/Home_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/Fav_View/fav_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/progress_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/setting_view.dart';
import 'package:graduation_project_ui/core/Utils/animation_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MainViewBody extends StatelessWidget {
  const MainViewBody({super.key, required this.currentViewIndex});
  final int currentViewIndex;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeView(),
      const ProgressView(),
      const FavView(),
      const SettingView(),
    ];

    return AnimatedSwitcher(
      duration: AnimationUtils.bottomNavDuration,
      switchInCurve: AnimationUtils.defaultCurve,
      switchOutCurve: AnimationUtils.defaultCurve,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey<int>(currentViewIndex),
        child: pages[currentViewIndex]
            .animate()
            .fadeIn(
              duration: AnimationUtils.cardAnimationDuration,
              curve: AnimationUtils.smoothCurve,
            )
            .slideX(
              begin: 0.05,
              end: 0,
              duration: AnimationUtils.cardAnimationDuration,
              curve: AnimationUtils.defaultCurve,
            ),
      ),
    );
  }
}

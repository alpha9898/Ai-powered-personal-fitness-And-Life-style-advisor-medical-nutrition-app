import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/Features/Auth/Login/ui/Login_view.dart';
import 'package:graduation_project_ui/Features/Auth/SignUp/ui/signUp_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/Home_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/Main_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/setting_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/Help_user.dart';
import 'package:graduation_project_ui/Features/Nutrition/Presention/view/Nutrition_view.dart';
import 'package:graduation_project_ui/Features/OnBoarding/onboarding_view.dart';
import 'package:graduation_project_ui/Features/Recommendation/Recommendation_View.dart';
import 'package:graduation_project_ui/Features/Set_Up/Set_Up_Page.dart';
import 'package:graduation_project_ui/Features/Set_Up/widgets/The_Gender.dart';
import 'package:graduation_project_ui/Features/Splash/SpalshView.dart';
import 'package:graduation_project_ui/Features/User_Profile/presention/view/user_profile_view.dart';
import 'package:graduation_project_ui/Features/community/News/News_view.dart';
import 'package:graduation_project_ui/Features/community/presention/view/community_view.dart';
import 'package:graduation_project_ui/Features/workout/presention/view/WorkOut_view.dart';
import 'package:graduation_project_ui/core/Utils/animation_utils.dart';
import 'package:flutter/foundation.dart';

abstract class AppRoute {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const Spalshview(),
          direction: SlideDirection.rightToLeft,
        ),
      ),
      GoRoute(
        path: '/OnBoardingView',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const OnboardingView(),
          direction: SlideDirection.rightToLeft,
        ),
      ),
      GoRoute(
        path: '/Login_view',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const LoginView(),
          direction: SlideDirection.bottomToTop,
        ),
      ),
      GoRoute(
        path: '/Sign_Up',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const SignupView(),
          direction: SlideDirection.bottomToTop,
        ),
      ),
      GoRoute(
        path: '/Set_Up',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const SetUpPage(),
          direction: SlideDirection.rightToLeft,
        ),
      ),
      GoRoute(
        path: '/The_Gander',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const TheGender(),
          direction: SlideDirection.rightToLeft,
        ),
      ),
      GoRoute(
        path: '/Main_view',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const MainView(),
          direction: SlideDirection.topToBottom,
        ),
      ),
      GoRoute(
        path: '/Home_view',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const HomeView(),
          direction: SlideDirection.rightToLeft,
        ),
      ),
      GoRoute(
        path: '/User_profile',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const UserProfileView(),
          direction: SlideDirection.bottomToTop,
        ),
      ),
      GoRoute(
        path: '/Recomendation_view',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const RecommendationView(),
          direction: SlideDirection.rightToLeft,
        ),
      ),
      GoRoute(
        path: '/WorkOut_view',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const WorkoutView(),
          direction: SlideDirection.leftToRight,
        ),
      ),
      GoRoute(
        path: '/Nutritions_view',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const NutritionView(),
          direction: SlideDirection.leftToRight,
        ),
      ),
      GoRoute(
        path: '/Community_view',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const CommunityView(),
          direction: SlideDirection.leftToRight,
        ),
      ),
      GoRoute(
        path: '/Setting',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const SettingView(),
          direction: SlideDirection.bottomToTop,
        ),
      ),
      GoRoute(
        path: '/HelpUser',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const HelpUser(),
          direction: SlideDirection.bottomToTop,
        ),
      ),
      GoRoute(
        path: '/NewsView',
        pageBuilder: (context, state) => AnimationUtils.buildPageTransition(
          key: state.pageKey,
          child: const NewsView(),
          direction: SlideDirection.rightToLeft,
        ),
      ),
    ],
  );
}

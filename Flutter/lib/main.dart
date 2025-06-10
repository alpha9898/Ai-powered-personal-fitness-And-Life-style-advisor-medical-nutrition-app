import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/core/Cubit/fav_cubit/cubit/fav_exrcies_cubit.dart';
import 'package:graduation_project_ui/core/Cubit/fav_cubit/cubit/fav_meals_cubit.dart';
import 'package:graduation_project_ui/core/Repo/Fav_Exercies_Repo_Imp.dart';
import 'package:graduation_project_ui/core/Repo/Fav_Meals_Repo_Imp.dart';
import 'package:graduation_project_ui/core/Services/Shared_Preferences_Singlton.dart';
import 'package:graduation_project_ui/core/Services/get_it_Service.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/Size_config.dart';
import 'package:graduation_project_ui/core/Utils/AppRouter.dart';
import 'package:graduation_project_ui/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://rehwmsejxrkmeyysrfnn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJlaHdtc2VqeHJrbWV5eXNyZm5uIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0MjU0MDExOCwiZXhwIjoyMDU4MTE2MTE4fQ.Y8oNA4JJ0b-LSMMuhRH8uM0s6qHdLftM53ifUgTfkF4',
  );
  setupGetIt();
  SharedPreferencesSinglton.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => FavExrciesCubit(
            favExerciesRepoImp: getIt.get<FavExerciesRepoImp>()),
      ),
      BlocProvider(
        create: (context) =>
            FavMealsCubit(favMealsRepoImp: getIt.get<FavMealsRepoImp>()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp.router(
      routerConfig: AppRoute.router,
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: KbackGroundColor),
      debugShowCheckedModeBanner: false,
    );
  }
}
// AMAR YASSER
// i want make two dropdown lists one for faverite food and the other for favorite workout the user have other pages one for food and can add favorte food from it i want when the user add any food or workout apper here in two defranet lists

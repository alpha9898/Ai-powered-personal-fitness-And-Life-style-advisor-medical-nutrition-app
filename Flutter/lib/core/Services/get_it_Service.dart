//احنا هنا بنعمل نسخه وحده من الكلاس بدل منقهد نكتب كل كلاس وجواه الحاجات الي بيحتاجها فاحنا بندمعهم هنا ويوم منحب نستدعي حاجاه فيهم بنستدعيها من نوعها زي مثال ال firebaseService

import 'package:get_it/get_it.dart';
import 'package:graduation_project_ui/Features/Auth/data/Repos_impl/Auth_Repo_Impl.dart';
import 'package:graduation_project_ui/Features/Auth/domin/Repos/Auth_Repo.dart';
import 'package:graduation_project_ui/core/Repo/Artical_repo_impl.dart';
import 'package:graduation_project_ui/core/Repo/Exercise_Repo.dart';
import 'package:graduation_project_ui/core/Repo/Exercise_Repo_impl.dart';
import 'package:graduation_project_ui/core/Repo/Fav_Exercies_Repo_Imp.dart';
import 'package:graduation_project_ui/core/Repo/Fav_Meals_Repo_Imp.dart';
import 'package:graduation_project_ui/core/Repo/MealRepo.dart';
import 'package:graduation_project_ui/core/Repo/MealRepoImpl.dart';
import 'package:graduation_project_ui/core/Services/Data_Base_Service.dart';
import 'package:graduation_project_ui/core/Services/Fire_Base_Auth_Service.dart';
import 'package:graduation_project_ui/core/Services/Fire_Base_Store_Service.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<FireBaseAuthService>(FireBaseAuthService());
  getIt.registerSingleton<DatabaseService>(FireBaseStoreService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
        firebaseAuthService: getIt<FireBaseAuthService>(),
        databaseService: getIt<DatabaseService>()),
  );
  getIt.registerSingleton<ExerciseRepo>(
      ExerciseRepoImpl(databaseService: getIt<DatabaseService>()));

  getIt.registerSingleton<Mealrepo>(
      Mealrepoimpl(databaseService: getIt<DatabaseService>()));

  getIt.registerSingleton<ArticalRepoImpl>(
      ArticalRepoImpl(databaseService: getIt<DatabaseService>()));

  getIt.registerSingleton<FavExerciesRepoImp>(
      FavExerciesRepoImp(databaseService: getIt<DatabaseService>()));

  getIt.registerSingleton<FavMealsRepoImp>(
      FavMealsRepoImp(databaseService: getIt<DatabaseService>()));
}

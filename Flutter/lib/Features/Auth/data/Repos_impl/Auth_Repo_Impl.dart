import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project_ui/Features/Auth/data/Models/User_Model.dart';
import 'package:graduation_project_ui/Features/Auth/domin/Entites/User_entity.dart';
import 'package:graduation_project_ui/Features/Auth/domin/Repos/Auth_Repo.dart';
import 'package:graduation_project_ui/constant.dart';
import 'package:graduation_project_ui/core/Errors/Exaption.dart';
import 'package:graduation_project_ui/core/Errors/failuers.dart';
import 'package:graduation_project_ui/core/Services/Data_Base_Service.dart';
import 'package:graduation_project_ui/core/Services/Fire_Base_Auth_Service.dart';
import 'package:graduation_project_ui/core/Services/Shared_Preferences_Singlton.dart';
import 'package:graduation_project_ui/core/Utils/Backend_const.dart';

class AuthRepoImpl extends AuthRepo {
  final FireBaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl(
      {required this.firebaseAuthService, required this.databaseService});
  @override
  Future<Either<Failuers, UserEntity>> createUserWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
          email, password);

      var userentity = UserEntity(id: user.uid, name: name, email: email);
      await addUserData(user: userentity);
      return Right(userentity);
    } on Custom_Exaption catch (e) {
      if (user != null) {
        await firebaseAuthService.deleteUser();
      }
      return Left(ServerFailuers(e.message));
    } catch (e) {
      if (user != null) {
        await firebaseAuthService.deleteUser();
      }
      log(
        'there is an error in firebase auth service . create user with email and password and ${e.toString()} ',
      );
      return Left(ServerFailuers('يوجد مشكله حاول مره اخري'));
    }
  }

  @override
  Future<Either<Failuers, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);
      var userentity = await getUserData(userId: user.uid);

      SaveUserData(user: userentity);
      return Right(userentity);
    } on Custom_Exaption catch (e) {
      if (user != null) {
        await firebaseAuthService.deleteUser();
      }
      return Left(ServerFailuers(e.message));
    } catch (e) {
      log(
        'there is an error in firebase auth service . Sign in user with email and password and ${e.toString()} ',
      );
      return Left(ServerFailuers('يوجد مشكله حاول مره اخري'));
    }
  }

  @override
  @override
  Future addUserData({required UserEntity user}) async {
    await databaseService.addData(
        documentId: user.id,
        path: BackendConst.adduserdata,
        data: UserModel.fromEntity(user).toMap());
  }

  @override
  Future<UserEntity> getUserData({required String userId}) async {
    var userdata = await databaseService.getData(
        path: BackendConst.getuserdata, documentId: userId);
    return UserModel.fromJson(userdata);
  }

  Future SaveUserData({required UserEntity user}) async {
    var jsondata = jsonEncode(UserModel.fromEntity(user).toMap());
    await SharedPreferencesSinglton.setString(KUserData, jsondata);
  }
}

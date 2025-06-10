import 'package:dartz/dartz.dart';
import 'package:graduation_project_ui/Features/Auth/domin/Entites/User_entity.dart';
import 'package:graduation_project_ui/core/Errors/failuers.dart';

abstract class AuthRepo {
  Future<Either<Failuers, UserEntity>> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failuers, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future addUserData({required UserEntity user});

  Future<UserEntity> getUserData({required String userId});

  Future SaveUserData({required UserEntity user});
}

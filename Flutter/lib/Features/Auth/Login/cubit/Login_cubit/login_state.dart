part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginISuccess extends LoginState {
  final UserEntity userEntity;
  LoginISuccess({required this.userEntity});
}

final class LoginFailure extends LoginState {
  final String message;
  LoginFailure({required this.message});
}

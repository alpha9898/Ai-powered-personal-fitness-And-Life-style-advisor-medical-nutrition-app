part of 'sign_up_cubit_cubit.dart';

@immutable
sealed class SignUpCubitState {}

final class SignUpCubitInitial extends SignUpCubitState {}

final class SignUpCubitLoading extends SignUpCubitState {}

final class SignUpCubitSuccess extends SignUpCubitState {
  final UserEntity userEntity;
  SignUpCubitSuccess({required this.userEntity});
}

final class SignUpCubitFailure extends SignUpCubitState {
  final String message;
  SignUpCubitFailure({required this.message});
}

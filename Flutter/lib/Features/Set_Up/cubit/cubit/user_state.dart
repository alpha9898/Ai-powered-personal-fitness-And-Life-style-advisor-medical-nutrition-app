part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserUpdated extends UserState {}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

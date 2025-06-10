part of 'meals_cubit.dart';

@immutable
sealed class MealsState {}

final class MealsInitial extends MealsState {}

final class MealsLoading extends MealsState {}

final class MealsFailure extends MealsState {
  final String message;

  MealsFailure(this.message);
}

final class MealsSuccess extends MealsState {
  final List<Mealentity> meals;

  MealsSuccess(this.meals);
}

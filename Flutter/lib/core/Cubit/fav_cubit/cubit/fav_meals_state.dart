part of 'fav_meals_cubit.dart';

@immutable
sealed class FavMealsState {}

final class FavMealsInitial extends FavMealsState {}

final class FavMealsLoading extends FavMealsState {}

final class FavMealsSuccess extends FavMealsState {
  final List<dynamic> favMeals;

  FavMealsSuccess(this.favMeals);
}

final class FavMealsFailure extends FavMealsState {
  final String message;

  FavMealsFailure(this.message);
}

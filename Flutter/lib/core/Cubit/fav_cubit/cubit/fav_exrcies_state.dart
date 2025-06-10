part of 'fav_exrcies_cubit.dart';

@immutable
sealed class FavExrciesState {}

final class FavExrciesInitial extends FavExrciesState {}

final class FavExrciesLoading extends FavExrciesState {}

final class FavExrciesSuccess extends FavExrciesState {
  final List<dynamic> Fav_exercise;

  FavExrciesSuccess(this.Fav_exercise);
}

final class FavExrciesFailure extends FavExrciesState {
  final String message;

  FavExrciesFailure(this.message);
}

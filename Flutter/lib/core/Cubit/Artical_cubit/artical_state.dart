part of 'artical_cubit.dart';

@immutable
sealed class ArticalState {}

final class ArticalInitial extends ArticalState {}

final class ArticalLoading extends ArticalState {}

final class ArticalSuccess extends ArticalState {
  final List<Articalentity> articals;
  ArticalSuccess(this.articals);
}

final class Articalfailure extends ArticalState {
  final String message;
  Articalfailure(this.message);
}

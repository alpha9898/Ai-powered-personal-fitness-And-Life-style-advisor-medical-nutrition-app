import 'package:bloc/bloc.dart';
import 'package:graduation_project_ui/core/Entity/MealEntity.dart';
import 'package:graduation_project_ui/core/Repo/MealRepo.dart';
import 'package:meta/meta.dart';

part 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  final Mealrepo Mealrepoimpl;

  MealsCubit({required this.Mealrepoimpl}) : super(MealsInitial());

  Future<void> getMeals() async {
    emit(MealsLoading());
    final result = await Mealrepoimpl.getMeals();
    result.fold((failuers) => emit(MealsFailure(failuers.Massage)),
        (meals) => emit(MealsSuccess(meals)));
  }
}

import 'package:bloc/bloc.dart';
import 'package:graduation_project_ui/Features/Auth/domin/Entites/User_entity.dart';
import 'package:graduation_project_ui/Features/Auth/domin/Repos/Auth_Repo.dart';
import 'package:meta/meta.dart';

part 'sign_up_cubit_state.dart';

class SignUpCubitCubit extends Cubit<SignUpCubitState> {
  final AuthRepo authRepo;
  SignUpCubitCubit(this.authRepo) : super(SignUpCubitInitial());

  Future<void> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpCubitLoading());
    var result = await authRepo.createUserWithEmailAndPassword(
      name: name,
      email: email,
      password: password,
    );

    result.fold((failuers) {
      emit(SignUpCubitFailure(message: failuers.Massage));
    }, (user) {
      emit(SignUpCubitSuccess(userEntity: user));
    });
  }
}

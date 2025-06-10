import 'package:bloc/bloc.dart';
import 'package:graduation_project_ui/Features/Auth/domin/Entites/User_entity.dart';
import 'package:graduation_project_ui/Features/Auth/domin/Repos/Auth_Repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthRepo authRepo;
  LoginCubit(this.authRepo) : super(LoginInitial());

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    var result = await authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.fold((failuers) {
      emit(LoginFailure(message: failuers.Massage));
    }, (user) {
      emit(LoginISuccess(userEntity: user));
    });
  }
}

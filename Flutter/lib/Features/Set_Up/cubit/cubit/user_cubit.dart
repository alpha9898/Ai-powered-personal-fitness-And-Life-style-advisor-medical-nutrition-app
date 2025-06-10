import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project_ui/core/Services/Data_Base_Service.dart';
import 'package:graduation_project_ui/core/Services/Fire_Base_Store_Service.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final DatabaseService storeService;
  UserCubit({required this.storeService}) : super(UserInitial());

  Future<void> updateBodyData({
    required int weight,
    required num height,
    required String gender,
    required int age,
  }) async {
    emit(UserLoading());

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      await storeService.addData(
        path: 'users',
        documentId: userId,
        data: {
          'weight': weight,
          'height': height,
          'gender': gender,
          'age': age,
        },
      );

      emit(UserUpdated());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}

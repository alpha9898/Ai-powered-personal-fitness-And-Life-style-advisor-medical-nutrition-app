import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project_ui/core/Errors/Exaption.dart';

class FireBaseAuthService {
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Custom_Exaption(message: ' Weak password');
      } else if (e.code == 'email-already-in-use') {
        throw Custom_Exaption(message: ' Email already in use');
      } else if (e.code == 'network-request-failed') {
        throw Custom_Exaption(message: ' No internet connection');
      } else {
        throw Custom_Exaption(message: e.message.toString());
      }
    } catch (e) {
      log(
        'there is an error in firebase auth service . create user with email and password and ${e.toString()} ',
      );
      throw Custom_Exaption(message: e.toString());
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Custom_Exaption(message: 'User not found');
      } else if (e.code == 'wrong-password') {
        throw Custom_Exaption(message: ' password is wrong');
      } else if (e.code == 'network-request-failed') {
        throw Custom_Exaption(message: ' No internet connection');
      } else {
        throw Custom_Exaption(message: e.message.toString());
      }
    } catch (e) {
      throw Custom_Exaption(message: ' There is an error try again');
    }
  }

  bool isSignedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

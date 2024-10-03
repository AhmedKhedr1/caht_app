import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  
  Future<void> login_user(
      {required String Email, required String Password}) async {
    emit(LoginLoading());

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email, password: Password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
       emit(LoginFailure(errorMassege: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errorMassege: 'wrong-password'));
      } else {
      emit(LoginFailure(errorMassege: 'Login failed'));
    } 
    } on Exception catch (e) {
      emit(LoginFailure(errorMassege: 'there was an error '));
    }
  }
  
  Future<void> Create_user(BuildContext context,
      {required String Email, required String password}) async {
    emit(RegisterLoading());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: Email, password: password);
      emit(RegisterSuccess());
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(
            ErrorMassege: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(
            ErrorMassege: 'email-already-in-use'));
      }
    } catch (e) {
      emit(
          RegisterFailure(ErrorMassege: 'there was an error please try again'));
    }
  }
}

import 'package:bloc/bloc.dart';

import 'package:chatapp/Widgets/ErrorMassege.dart';
import 'package:chatapp/screens/register_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

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

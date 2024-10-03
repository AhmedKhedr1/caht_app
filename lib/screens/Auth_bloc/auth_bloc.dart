import 'package:bloc/bloc.dart';
import 'package:chatapp/screens/register_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit)async{
      if(event is loginEvent) {

        emit(LoginLoading());

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: event.email, password: event.password);
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
      if (event is RegisterEvent){
         emit(RegisterLoading());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: event.email, password: event.password);
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
    });
  }
}

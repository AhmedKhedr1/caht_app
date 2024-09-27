import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

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
}

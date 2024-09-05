
  import 'package:firebase_auth/firebase_auth.dart';

Future<void> CreateUser(String Email,String password) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: Email!, password: password!);
  }
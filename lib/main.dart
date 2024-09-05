import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/screens/Chat_screen.dart';
import 'package:chatapp/screens/Login_Screen.dart';
import 'package:chatapp/screens/Signin_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.id: (context) =>  LoginScreen(),
        SigninScreen.id: (context) =>  SigninScreen(),
        ChatScreen.id:(context) => ChatScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}


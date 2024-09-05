import 'package:chatapp/Widgets/Custom_TextField.dart';
import 'package:chatapp/Widgets/Custom_button.dart';
import 'package:chatapp/screens/Chat_screen.dart';
import 'package:chatapp/screens/Signin_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static String id = 'LoginScreen';
  String? Email;
  String? Password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff274460),
      body: Padding(
        padding: const EdgeInsets.only(top: 85, right: 12, left: 12),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Center(
                    child: Image(
                        fit: BoxFit.fitHeight,
                        height: 120,
                        image: AssetImage('assets/images/scholar.png'))),
                const Text(
                  'Scholar Chat',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 80,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Log in',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Custom_textField(
                  hintText: 'Email',
                  oncahanged: (data) {
                    Email = data;
                  },
                ),
                const SizedBox(height: 15),
                Custom_textField(
                  obscure: true,
                  hintText: 'Password',
                  oncahanged: (data) {
                    Password = data;
                  },
                ),
                Custom_Button(
                  buttontext: 'Log in',
                  onTap: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: Email!, password: Password!);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                     Navigator.pushNamed(context, ChatScreen.id,arguments: Email);
                  }
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don\'t have account ? ',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SigninScreen.id);
                        },
                        child: const Text(
                          'Register',
                          style:
                              TextStyle(color: Color(0xffCAEEE7), fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

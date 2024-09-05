import 'package:chatapp/Widgets/Create_User.dart';
import 'package:chatapp/Widgets/Custom_TextField.dart';
import 'package:chatapp/Widgets/Custom_button.dart';
import 'package:chatapp/Widgets/ErrorMassege.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  static String id = 'LoginScreen';
  String? Email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff274460),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 85, right: 12, left: 12),
            child: Column(
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
                  padding: EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Sign in',
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                    ],
                  ),
                ),
                Custom_textField(
                  hintText: 'Email',
                  oncahanged: (data) {
                    Email = data;
                    print(Email);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Custom_textField(
                  obscure: true,
                  hintText: 'Password',
                  oncahanged: (data) {
                    password = data;
                  },
                ),
                Custom_Button(
                    buttontext: 'Sign in ',
                    onTap: () async {
                     
                      try {
                         
                        await CreateUser(Email!,password!);
                        ErrorMassege(context, 'Success');
                        Navigator.pop(context);
                      } on FirebaseException catch (e) {
                        if (e.code == 'weak-password') {
                          ErrorMassege(
                              context, 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          ErrorMassege(context,
                              'The account already exists for that email.');
                        }
                      } catch (e) {
                        ErrorMassege(context, e.toString());
                      }
                     
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have account ?',
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text('   Log in',
                            style: TextStyle(
                                color: Color(0xffCAEEE7), fontSize: 17)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  

}

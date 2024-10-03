
import 'package:chatapp/Widgets/Custom_TextField.dart';
import 'package:chatapp/Widgets/Custom_button.dart';
import 'package:chatapp/models/showSnackBar.dart';
import 'package:chatapp/screens/Auth_bloc/auth_bloc.dart';

import 'package:chatapp/screens/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class registerScreen extends StatelessWidget {
  registerScreen({super.key});
  static String id = 'registerScreen';
  String? Email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context,LoginScreen.id);
          isLoading = false;
        } else if (state is RegisterFailure) {
          showSnackBar(context,state.ErrorMassege );
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: const Color(0xff274460),
            body: Form(
              key: formKey,
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 85, right: 12, left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Center(
                            child: Image(
                                fit: BoxFit.fitHeight,
                                height: 120,
                                image:
                                    AssetImage('assets/images/scholar.png'))),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25)),
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
                          obscureText: true,
                          hintText: 'Password',
                          oncahanged: (data) {
                            password = data;
                          },
                        ),
                        Custom_Button(
                            buttontext: 'Sign in ',
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthBloc>(context).add(RegisterEvent(email: Email!, password: password!));
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have account ?',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('   Log in',
                                    style: TextStyle(
                                        color: Color(0xffCAEEE7),
                                        fontSize: 17)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Future<void> CreateUser(String Email,String password) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: Email!, password: password!);
  }
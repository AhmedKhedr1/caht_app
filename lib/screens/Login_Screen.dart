import 'package:chatapp/Widgets/Custom_TextField.dart';
import 'package:chatapp/Widgets/Custom_button.dart';
import 'package:chatapp/models/showSnackBar.dart';
import 'package:chatapp/screens/Chat_screen.dart';
import 'package:chatapp/screens/Cubits/login_cubit/login_cubit.dart';
import 'package:chatapp/screens/register_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static String id = 'LoginScreen';
  String? Email;
  String? Password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context, ChatScreen.id);
          isLoading=false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errorMassege);
          isLoading=false;
        }
      },
      builder:(context,State)=> ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: const Color(0xff274460),
          body: Padding(
            padding: const EdgeInsets.only(top: 85, right: 12, left: 12),
            child: Form(
              key: formKey,
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
                        obscureText: true,
                        hintText: 'Password',
                        oncahanged: (data) {
                          Password = data;
                        },
                      ),
                      Custom_Button(
                        buttontext: 'Log in',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context)
                                .login_user(Email: Email!, Password: Password!);
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'don\'t have account ? ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, registerScreen.id);
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                    color: Color(0xffCAEEE7), fontSize: 17),
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
          ),
        ),
      ),
    );
  }
}

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat2/custom_widgets/custom_button.dart';
import 'package:scholar_chat2/custom_widgets/custom_textfield.dart';
import 'package:scholar_chat2/screens/chat_page.dart';
import 'package:scholar_chat2/screens/register_page.dart';

import '../custom_methods.dart';

class SignInPage extends StatefulWidget {
  static String id = 'SignInPage';

  SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Scholar Chat',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pacifico',
                    fontSize: 42.0),
              ),
              SizedBox(
                height: 55.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(children: [
                  Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: CustomTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                  label: 'Enter your Email',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: CustomTextField(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                  obscure: true,
                  label: 'Enter your password',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: CustomButton(
                  callback: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await UserSignIn(email, password);
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ShowScaffold(
                              context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          ShowScaffold(context,
                              'Wrong password provided for that user.');
                        }
                      }
                    } else {}
                    isLoading = false;
                    setState(() {});
                  },
                  label: 'Login',
                ),
              ),
              GestureDetector(
                  child: Text(
                    'dosent have an account? Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => Navigator.pushNamed(context, 'SignUpPage'))
            ],
          ),
        ),
      ),
    );
  }
}

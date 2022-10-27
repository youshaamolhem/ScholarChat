import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat2/custom_widgets/custom_button.dart';
import 'package:scholar_chat2/custom_widgets/custom_textfield.dart';
import 'package:scholar_chat2/screens/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../custom_methods.dart';

class SignUpPage extends StatefulWidget {
  static String id = 'SignUpPage';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

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
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: CustomTextField(
                  hintText: 'Email',
                  label: 'Enter your Email',
                  onChanged: (data) {
                    email = data;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: CustomTextField(
                  hintText: 'Password',
                  label: 'Repeate your password',
                  onChanged: (data) {
                    password = data;
                  },
                ),
              ),
              GestureDetector(
                child: CustomButton(
                  callback: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await SignUp(
                          email!,
                          password!,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          ShowScaffold(
                              context, 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          ShowScaffold(context,
                              'The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  label: 'Sign Up',
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  'Already have an account? LogIn',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

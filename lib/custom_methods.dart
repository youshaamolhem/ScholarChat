import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<UserCredential?> UserSignIn(String? email, password) async {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email!,
    password: password!,
  );
}

Future<UserCredential?> SignUp(String? email, password) async {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email!,
    password: password!,
  );
}

void ShowScaffold(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

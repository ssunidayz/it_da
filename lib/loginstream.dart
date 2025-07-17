import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:it_da/screen/home.dart';
import 'package:it_da/screen/login.dart';

class LoginStream extends StatelessWidget {
  const LoginStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (!snapshot.hasData) {
          return const LoginPage();
        } else {
          return const HomePage();
        }
      },
    ));
  }
}

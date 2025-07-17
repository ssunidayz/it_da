import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:it_da/loginstream.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Firebase load fail"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return LoginStream();
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

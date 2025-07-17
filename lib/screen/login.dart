import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  _bodyWidget() {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        children: [
          Container(
            height: deviceHeight / 5,
          ),
          Center(
            child: Image.asset(
              'assets/login_logo.png',
            ),
          ),
          Container(
            height: deviceHeight / 7,
          ),
          Column(
            children: [
              // SizedBox(
              //   height: 50,
              //   width: 350,
              //   child: ElevatedButton(
              //     onPressed: () => Navigator.of(context).pop(),
              //     style: ButtonStyle(
              //         foregroundColor:
              //             MaterialStateProperty.all<Color>(Colors.white),
              //         backgroundColor:
              //             MaterialStateProperty.all<Color>(Colors.black),
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //             RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         ))),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Image.asset('assets/apple_logo.png'),
              //         const SizedBox(width: 15),
              //         const Text('Apple로 이어보기'),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 15),
              SizedBox(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser?.email)
                        .set({
                      "email": FirebaseAuth.instance.currentUser?.email,
                      "name": FirebaseAuth.instance.currentUser?.displayName,
                      "uid": FirebaseAuth.instance.currentUser?.uid,
                    });
                    signInWithGoogle();
                  },
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/google_logo.png',
                        width: 23.0,
                        height: 23.0,
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        'Google로 이어보기',
                        style: TextStyle(
                            fontFamily: '강원교육모두',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

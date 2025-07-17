// ignore: depend_on_referenced_packages
import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:it_da/widget/appbar.dart';
import 'package:url_launcher_ios/url_launcher_ios.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: const MyAppBar(),
        body: Column(
          children: [
            SizedBox(height: 40),
            ContactUs(
              logo: const AssetImage('assets/login_logo.png'),
              email: 'ssuni9986@handong.ac.kr',
              companyName: '너와 나를 잇다',
              tagLine: '임주환, 정소망, 황수현',
              dividerThickness: 2,
              githubUserName: 'moappitda',
              textColor: Colors.black,
              companyColor: Colors.black,
              cardColor: Color.fromARGB(255, 238, 236, 236),
              taglineColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:it_da/controller/setting_controller.dart';
import 'package:it_da/screen/set_anniversary.dart';
import 'package:it_da/widget/appbar.dart';

class SetBirthdatePage extends StatefulWidget {
  const SetBirthdatePage({super.key});

  @override
  State<SetBirthdatePage> createState() => _SetBirthdatePageState();
}

class _SetBirthdatePageState extends State<SetBirthdatePage> {
  final userInfo = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.email);

  DateTime _birthDate = DateTime(2000, 1, 1);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy. MM. dd').format(_birthDate);
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
            ),
            SettingController.progressBar(2),
            Container(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "생년월일을 입력해 주세요",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            const Text(
              "서로의 생일을 기억하고 축복해 보아요",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            Container(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextButton(
                  child: Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _birthDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _birthDate = selectedDate;
                      });
                    }
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    userInfo.update({"birthDate": _birthDate});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SetAnniversaryPage(),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

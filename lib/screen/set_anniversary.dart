import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:it_da/controller/setting_controller.dart';
import 'package:it_da/widget/appbar.dart';

class SetAnniversaryPage extends StatefulWidget {
  const SetAnniversaryPage({super.key});

  @override
  State<SetAnniversaryPage> createState() => _SetAnniversaryPageState();
}

class _SetAnniversaryPageState extends State<SetAnniversaryPage> {
  final userInfo = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.email);

  DateTime _anniversary = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy. MM. dd').format(_anniversary);
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
            ),
            SettingController.progressBar(3),
            Container(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "두 분의 기념일을 입력해 주세요",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            const Text(
              "하나님 안에서 축복받은 날은 언제인가요?",
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
                      initialDate: _anniversary,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _anniversary = selectedDate;
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
                    userInfo.update({"anniversary": _anniversary});
                    Navigator.pushNamed(context, '/my');
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

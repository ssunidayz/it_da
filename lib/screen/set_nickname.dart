import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_da/controller/setting_controller.dart';
import 'package:it_da/screen/set_birthdate.dart';
import 'package:it_da/widget/appbar.dart';

class SetNickNamePage extends StatefulWidget {
  const SetNickNamePage({super.key});

  @override
  State<SetNickNamePage> createState() => _SetNickNamePageState();
}

class _SetNickNamePageState extends State<SetNickNamePage> {
  final userInfo = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.email);

  String _nickname = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
            ),
            SettingController.progressBar(1),
            Container(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "사용할 닉네임을 입력하세요",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            const Text(
              "상대방이 불러주는 애칭도 좋아요",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            Container(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                textAlign: TextAlign.center,
                maxLength: 10,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "닉네임 입력 (최대 10자)",
                ),
                onChanged: (text) {
                  _nickname = text;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (_nickname != "") {
                      userInfo.update({"nickname": _nickname});
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SetBirthdatePage(),
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

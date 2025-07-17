import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenerateCodePage extends StatefulWidget {
  const GenerateCodePage({super.key});

  @override
  State<GenerateCodePage> createState() => _GenerateCodePageState();
}

class _GenerateCodePageState extends State<GenerateCodePage> {
  String code = '';
  String getRandomString(int length) {
    const charset = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return List.generate(
        length, (index) => charset[random.nextInt(charset.length)]).join();
  }

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "커플 코드 생성",
          style: TextStyle(
            fontFamily: '강원교육모두',
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: deviceHeight / 5,
            ),
            ElevatedButton(
              onPressed: () {
                code = getRandomString(7);
                textController.text = code;
              },
              child: const Text("코드 생성"),
            ),
            Container(
              height: deviceHeight / 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      maxLength: 7,
                      decoration: const InputDecoration(
                        hintText: "코드를 입력하세요 (7자)",
                      ),
                      onChanged: (value) {
                        code = value;
                        textController.text = code;
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.done,
                    ),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.email)
                          .update({"code": code});
                      Get.back();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

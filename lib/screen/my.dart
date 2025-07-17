import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:it_da/auth.dart';
import 'package:it_da/screen/generate_code.dart';
import 'package:it_da/screen/set_nickname.dart';
import 'package:it_da/widget/contact.dart';
import 'package:it_da/widget/profilebottom.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserData(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          var userData = snapshot.data!.data();

          String myName = userData?['nickname'] ?? '잇쉬';
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                '마이페이지',
                style: TextStyle(
                  fontFamily: '강원교육모두',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              elevation: 10,
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      Column(
                        children: [
                          const Text(
                            '사랑한지 00 일째',
                            style: TextStyle(
                              fontFamily: '강원교육모두',
                              fontWeight: FontWeight.w300,
                              fontSize: 23,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                myName,
                                style: const TextStyle(
                                  fontFamily: '강원교육모두',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.favorite,
                                size: 15,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                '잇샤',
                                style: TextStyle(
                                  fontFamily: '강원교육모두',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 160),
                      TextButton(
                          onPressed: () {
                            Get.to(const SetNickNamePage());
                          },
                          child: Text(
                            '회원정보 수정',
                            style: _myPageFontStyle(),
                          )),
                      TextButton(
                          onPressed: () {
                            Get.to(const Contact());
                          },
                          child: Text(
                            '잇다에 문의하기',
                            style: _myPageFontStyle(),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/info');
                          },
                          child: Text(
                            '나의 잇다 정보',
                            style: _myPageFontStyle(),
                          )),
                      TextButton(
                          onPressed: () {
                            Get.offAll(const Auth());
                            FirebaseAuth.instance.signOut();
                          },
                          child: Text(
                            '로그아웃',
                            style: _myPageFontStyle(),
                          )),
                      TextButton(
                          onPressed: () {
                            Get.to(const GenerateCodePage());
                          },
                          child: Text(
                            '커플 코드 생성',
                            style: _myPageFontStyle(),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: const ProfileBottomNavigator(),
          );
        });
  }

  TextStyle _myPageFontStyle() {
    return const TextStyle(
      fontFamily: '강원교육모두',
      fontWeight: FontWeight.w300,
      fontSize: 23,
      color: Colors.black,
    );
  }
}

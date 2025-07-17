import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:it_da/widget/showappbar.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ShowPage extends StatelessWidget {
  final String question;
  final String answer;

  ShowPage({required this.question, required this.answer});

  List<String> imagePaths = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
    'assets/6.png',
  ];

  List<int> moodValues = [1, 2, 3, 4, 5, 6];
  int moodValue = 0;

  Future<String?> _getUserRole() async {
    // 현재 로그인된 사용자의 ID를 가져옵니다.
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // couples 컬렉션에서 현재 사용자가 속한 문서를 가져옵니다.
    QuerySnapshot querySnapshot = await _firestore
        .collection('couples')
        .where('user1', isEqualTo: currentUserId)
        .get();
    if (querySnapshot.docs.isEmpty) {
      querySnapshot = await _firestore
          .collection('couples')
          .where('user2', isEqualTo: currentUserId)
          .get();
    }
    if (querySnapshot.docs.isEmpty) {
      print('Error: No matching document found');
      return null;
    }

    DocumentSnapshot doc = querySnapshot.docs.first;
    if (doc.get('user1') == currentUserId) {
      return 'user1';
    } else if (doc.get('user2') == currentUserId) {
      return 'user2';
    } else {
      print('Error: Current user is not in the couple');
      return null;
    }
  }

  Future<Map<String, String>> _getAnswers() async {
    String? userRole = await _getUserRole();
    if (userRole == null) {
      print('Error: User role is null');
      return {};
    }

    DocumentSnapshot doc = await _firestore
        .collection('couples')
        .doc('123456')
        .collection('question')
        .doc('1')
        .get();

    return {
      'currentUser': (doc.data() as Map<String, dynamic>)
                  ?.containsKey(userRole == 'user1' ? 'answer_1' : 'answer_2') ??
              false
          ? doc.get(userRole == 'user1' ? 'answer_1' : 'answer_2')
          : "",
      'partnerUser': (doc.data() as Map<String, dynamic>)
                  ?.containsKey(userRole == 'user1' ? 'answer_2' : 'answer_1') ??
              false
          ? doc.get(userRole == 'user1' ? 'answer_2' : 'answer_1')
          : "",
    };
  }


  Future<Map<String, String>> _getMoods() async {
    String? userRole = await _getUserRole();
    if (userRole == null) {
      print('Error: User role is null');
      return {};
    }

    DocumentSnapshot doc = await _firestore
        .collection('couples')
        .doc('123456')
        .collection('question')
        .doc('1')
        .get();

    return {
      'currentUserMood': (doc.data() as Map<String, dynamic>)
                  ?.containsKey(userRole == 'user1' ? 'mood_1' : 'mood_2') ??
              false
          ? (doc.get(userRole == 'user1' ? 'mood_1' : 'mood_2') as int).toString()
          : "",
      'partnerUserMood': (doc.data() as Map<String, dynamic>)
                  ?.containsKey(userRole == 'user1' ? 'mood_2' : 'mood_1') ??
              false
          ? (doc.get(userRole == 'user1' ? 'mood_2' : 'mood_1') as int).toString()
          : "",
    };

  }


  Future<dynamic> _showdialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: const Color.fromARGB(200, 46, 49, 46),
      builder: (BuildContext context) => AlertDialog(
        title: const Text(''),
        backgroundColor: const Color.fromARGB(255, 249, 250, 245),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        content: Container(
          width: 300,
          height: 350,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('하나님께서 주시는 말씀',
                    style: TextStyle(
                        fontFamily: '강원교육현옥샘',
                        fontWeight: FontWeight.w300,
                        fontSize: 25)),
                const SizedBox(height: 20),
                const Image(
                  image: AssetImage('assets/1.png'),
                  width: 50,
                ),
                const SizedBox(height: 40),
                Container(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: RichText(
                          maxLines: 10,
                          text: const TextSpan(
                            text:
                                '항상 기뻐하라 쉬지 말고 기도하라 범사에 감사하라 이는 그리스도 예수 안에서 너희를 향하신 하나님의 뜻이니라',
                            style: TextStyle(
                                wordSpacing: 3.0,
                                height: 1.5,
                                fontFamily: '강원교육모두',
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        )),
                      ],
                    )),
                const SizedBox(height: 20),
                const Text(
                  '데살로니가전서 5장 16~18절',
                  style: TextStyle(
                      fontFamily: '강원교육모두',
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: ShowAppBar(),
    body: Padding(
      padding: const EdgeInsets.all(25.0),
      child: FutureBuilder<List<Map<String, String>>>(
        future: Future.wait([_getAnswers(), _getMoods()]),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, String>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            Map<String, String> answers = snapshot.data![0];
            Map<String, String> moods = snapshot.data![1];
            int currentUserMood = int.tryParse(moods['currentUserMood'] ?? '0') ?? 0;
            int partnerUserMood = int.tryParse(moods['partnerUserMood'] ?? '0') ?? 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        '오늘의 이어짐',
                        style: TextStyle(
                          fontFamily: '강원교육현옥샘',
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(currentUserMood == 0 ? 'assets/mood_default.png' : imagePaths[currentUserMood - 1]),
                          const SizedBox(width: 15),
                          Image.asset(partnerUserMood == 0 ? 'assets/mood_default.png' : imagePaths[partnerUserMood - 1]),
                        ],
                      ),
                    ]),
                  
                  const SizedBox(height: 40),
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: Text(
                            question,
                            style: const TextStyle(
                              fontFamily: '강원교육모두',
                              fontSize: 23,
                            ),
                          ),
                        ),
                        const SizedBox(width: 25),
                        Column(
                          children: [
                            SizedBox(height: 40),
                            TextButton(
                              onPressed: () {
                                _showdialog(context);
                              },
                              child: const Text(
                                '말씀 다시보기',
                                style: TextStyle(
                                    fontFamily: '강원교육모두',
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 43, 135, 79)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Text(
                          '#1번째 질문',
                          style: TextStyle(
                            fontFamily: '강원교육모두',
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Apr 29, 2023',
                          style: TextStyle(
                            fontFamily: '강원교육모두',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ]),
                  const Text(
                    '잇쉬',
                    style: TextStyle(
                      fontFamily: '강원교육모두',
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${answers['currentUser'] == null || answers['currentUser'] == "" ? '아직 답변을 하지 않으셨습니다' : answers['currentUser']}',
                    style: TextStyle(
                      fontFamily: '강원교육모두',
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 60),
                  const Text(
                    '잇샤',
                    style: TextStyle(
                      fontFamily: '강원교육모두',
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${answers['partnerUser'] == null || answers['partnerUser'] == "" ? '아직 답변을 하지 않으셨습니다' : answers['partnerUser']}',
                    style: TextStyle(
                      fontFamily: '강원교육모두',
                      fontSize: 20,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}



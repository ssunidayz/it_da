import 'package:flutter/material.dart';
import 'package:it_da/widget/appbar.dart';
import 'package:it_da/widget/bottom.dart';
import 'package:it_da/screen/question.dart';
import 'package:it_da/controller/animation_controller.dart';

import 'package:it_da/questions.dart';
import 'package:it_da/couples.dart';
import 'package:rive/rive.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String> nextQuestionText = _getNextQuestion();

  static Future<String> _getNextQuestion() async {
    int couplesQuestionsCount = await getCouplesQuestionsCount();
    Questions? nextQuestion = await getQuestionAfter(couplesQuestionsCount);
    return nextQuestion?.question ?? 'No more questions.';
  }

  final controller = MyAnimationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 249, 250, 245),
        title: Image.asset(
          'assets/it_da_logo.png',
          fit: BoxFit.contain,
          height: 40,
        ),
      ),
      body: Center(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                Container(
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '잇쉬',
                              style: TextStyle(
                                fontFamily: '강원교육모두',
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.favorite,
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            Text(
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
                        SizedBox(height: 20),
                        Text(
                          '하나님 안에서 이어진 지',
                          style: TextStyle(
                            fontFamily: '강원교육모두',
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '180',
                              style: TextStyle(
                                fontFamily: '강원교육현옥샘',
                                fontWeight: FontWeight.w300,
                                fontSize: 40,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              ' 일 째',
                              style: TextStyle(
                                fontFamily: '강원교육모두',
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            )
                          ],
                        )
                      ]),
                ),
              ],
            ),
          ),
            Container(
              width: 400,
              height: 300,
              child: RiveAnimation.asset(
                'assets/tree.riv',
                //controllers: [controller],
              )

              // child: RiveAnimation.network(
              //   'https://cdn.rive.app/animations/vehicles.riv',
              // ),
            ),
          const SizedBox(height: 50),
          FutureBuilder<String>(
            future: nextQuestionText,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return TextButton(
                    onPressed: () async {
                      if (snapshot.data != 'No more questions.') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                QuestionPage(question: snapshot.data!),

                          ),
                        );
                        // TODO: 사용자의 응답 수를 가져오고, 
                        // 전체 질문 수로 나누어 진행률을 계산합니다.
                        int numberOfAnswers = 8;
                        int totalQuestions = 10;

                        double progress = numberOfAnswers / totalQuestions;
                        controller.mix = progress;
                        controller.isActive = true;
                      } else {
                        print('No more questions.');
                      }
                    },
                    child: SingleChildScrollView(
                      child: Text(
                        snapshot.data!,
                        style: const TextStyle(
                            fontFamily: '강원교육모두',
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ));
              }
            },
          ),
        ]),
      ),
      bottomNavigationBar: const MyBottomNavigator(),
    );
  }
}



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:it_da/screen/show.dart';
import 'package:it_da/widget/appbar.dart';
import 'package:it_da/widget/bottom.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class QuestionPage extends StatefulWidget {
  final String question;
  const QuestionPage({Key? key, required this.question}) : super(key: key);
  

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
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

  final _contentController = TextEditingController();
  bool _modalShown = false;
  bool _wordShown = false;

  //오늘의 날짜 받아오는 함수
  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('MM.dd.yyyy');
    var strToday = formatter.format(now);
    return strToday;
  }

  Future<String?> _getUserRole() async {
    // 현재 로그인된 사용자의 ID를 가져옵니다.
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // couples 컬렉션에서 현재 사용자가 속한 문서를 가져옵니다.
    QuerySnapshot querySnapshot = await _firestore.collection('couples')
      .where('user1', isEqualTo: currentUserId)
      .get();
    if (querySnapshot.docs.isEmpty) {
      querySnapshot = await _firestore.collection('couples')
        .where('user2', isEqualTo: currentUserId)
        .get();
    }
    if(querySnapshot.docs.isEmpty) {
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

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,  // 모달이 닫힐 때까지 뒷쪽 화면이 어둡게 됩니다.
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
          ),
          child: GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: imagePaths.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,  // 한 줄에 몇 개의 버튼이 표시될지 결정합니다.
              mainAxisSpacing: 10.0,  // 위젯 간의 수직 간격
              crossAxisSpacing: 10.0,  // 위젯 간의 수평 간격
              childAspectRatio: 1.0,  // 위젯의 가로-세로 비율
            ),
            itemBuilder: (BuildContext context, int index) {
              return IconButton(
                onPressed: () {
                  int selectedMoodValue = moodValues[index];
                  // 이제 UI를 업데이트합니다.
                  setState(() {
                    moodValue = selectedMoodValue;
                  });

                  // 모달을 닫습니다.
                  Navigator.pop(context);

                   // 그런 다음 Firestore를 업데이트합니다.
                  _getUserRole().then((userRole) {
                    if(userRole == null) {
                      return;
                    }

                    String moodField = userRole == 'user1' ? 'mood_1' : 'mood_2';
                    _firestore.collection('couples').doc('123456').collection('question').doc('1').update({moodField: moodValue});
                  });
                  
                },
                icon: Image.asset(
                  imagePaths[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        );
      },
    ).then((_) => _showdialog(context));
  }


  Future<void> _saveAnswer() async {
    String? userRole = await _getUserRole();
    if(userRole == null) {
      return;
    }

    String answerField = userRole == 'user1' ? 'answer_1' : 'answer_2';
    await _firestore.collection('couples').doc('123456').collection('question').doc('1').update({answerField: _contentController.text});
  }

  Future<int> getQuestionsNumber() async {
    QuerySnapshot querySnapshot = await _firestore.collection('couples').doc('123456').collection('question').get();
    return querySnapshot.docs.length;
  }


  Future<String?> _getVerse(String question) async {
  QuerySnapshot querySnapshot = await _firestore.collection('questions')
    .where('question', isEqualTo: question)
    .get();

  if(querySnapshot.docs.isEmpty) {
    print('Error: No matching document found');
    return null;
  }

  DocumentSnapshot doc = querySnapshot.docs.first;
  return doc.get('verse');
}


  Future<dynamic> _showdialog(BuildContext context) async {
    String? verse = await _getVerse(widget.question);
    if(verse == null) {
      print('Error: Verse is null');
      return;
    }

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
                          text: TextSpan(
                            text: verse,
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
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 46,
                width: 130,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 249, 250, 245)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 72, 162, 102))))),
                  child: const Text(
                    '돌아가기',
                    style: TextStyle(
                        fontFamily: '강원교육모두',
                        fontWeight: FontWeight.w300,
                        fontSize: 17),
                  ),
                ),
              ),
              const SizedBox(width: 18),
              SizedBox(
                height: 46,
                width: 130,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 225, 227, 222)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                  child: const Text(
                    '잇기',
                    style: TextStyle(
                        fontFamily: '강원교육모두',
                        fontWeight: FontWeight.w300,
                        fontSize: 17),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    //시작하자마자 modalPage open하는 부분
    if (!_modalShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showModalBottomSheet();
        _modalShown = true;
      });
    }

    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: const MyBottomNavigator(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
                '오늘의 기분',
                style: TextStyle(
                  fontFamily: '강원교육현옥샘',
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              if (moodValue != null)  // moodValue가 null이 아닌 경우에만 이미지를 표시합니다.
                Image.asset(moodValue == 0 ? 'assets/mood_default.png' : imagePaths[moodValue - 1]),
              ],
            ),
           
            const SizedBox(height: 37),
      
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 240,
                    child: Text(
                      widget.question,
                      style: TextStyle(
                        fontFamily: '강원교육모두',
                        fontWeight: FontWeight.w300,
                        fontSize: 20
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Text(
                        '말씀 다시보기',
                        style: TextStyle(
                          fontFamily: '강원교육모두',
                          fontWeight: FontWeight.w300,
                          fontSize: 14
                        ),
                      ),
                      onPressed: (){
                        _showdialog(context);
                      } 
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 12),
            
            Row(
              children: [
                FutureBuilder<int>(
                  future: getQuestionsNumber(),
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading...");
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return Text(
                        '#${snapshot.data}번째 질문',
                        style: TextStyle(
                          fontFamily: '강원교육모두',
                          fontWeight: FontWeight.w300,
                          fontSize: 14
                        ),      
                      );
                    }
                  },
                ),
                const SizedBox(width: 20),
                Text(
                  getToday(),
                  style: TextStyle(
                    fontFamily: '강원교육모두',
                    fontWeight: FontWeight.w300,
                    fontSize: 14
                  ),
                )
              ],
            ), // 질문 표시,

            const SizedBox(height: 40),

            TextFormField(
              controller: _contentController,
              maxLength: 100,
              decoration: const InputDecoration(
                hintText: '답변을 입력해주세요',
                hintStyle: TextStyle(
                  fontFamily: '강원교육모두',
                  fontWeight: FontWeight.w300,
                  fontSize: 18
                ),
                border: InputBorder.none,
              ),
            ),


            ElevatedButton(
              onPressed: _contentController.text.isEmpty ? null : () {
                _saveAnswer();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowPage(question: widget.question, answer: _contentController.text)),
                );
              },
              child: const Text('답변 저장'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (_contentController.text.isEmpty)
                      return Colors.grey; // 값이 없을 때의 배경색
                    return Colors.green; // 값이 있을 때의 배경색
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  
}

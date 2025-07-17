import 'package:flutter/material.dart';
import 'package:it_da/widget/profilebottom.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('나의 잇다 정보'),
        elevation: 10,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Column(
                children: [
                  Text(
                    '사랑한지 00 일째',
                    style: TextStyle(
                        fontFamily: '강원교육모두',
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              const SizedBox(height: 160),
              const Row(
                children: [
                  Text(
                    '나의 이름:',
                    style: TextStyle(
                        fontFamily: '강원교육모두',
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                  SizedBox(width: 20),
                  Text(
                    '잇쉬',
                    style: TextStyle(
                        fontFamily: '강원교육모두',
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    '두사람의 기념일',
                    style: TextStyle(
                        fontFamily: '강원교육모두',
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                  SizedBox(width: 20),
                  Text(
                    '0000년 00월 00일',
                    style: TextStyle(
                        fontFamily: '강원교육모두',
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    '상대방 이름:',
                    style: TextStyle(
                        fontFamily: '강원교육모두',
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                  SizedBox(width: 20),
                  Text(
                    '잇샤',
                    style: TextStyle(
                        fontFamily: '강원교육모두',
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'Email: ',
                    style: TextStyle(
                        fontFamily: '강원교육모두',
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                  SizedBox(width: 20),
                  Text(
                    '@gmail.com',
                    style: TextStyle(
                        fontFamily: '강원교육모두',
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  //_showdialog(context);
                },
                child: const Text('alert'),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ProfileBottomNavigator(),
    );
  }
}

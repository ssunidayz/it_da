import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:it_da/auth.dart';
import 'package:it_da/screen/calendar.dart';
import 'package:it_da/screen/home.dart';
import 'package:it_da/screen/info.dart';
import 'package:it_da/screen/list.dart';
import 'package:it_da/screen/mood.dart';
import 'package:it_da/screen/my.dart';
import 'package:it_da/screen/set_nickname.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'it_da',
      initialRoute: '/login',
      routes: {
        '/setting': (BuildContext context) => const SetNickNamePage(),
        '/login': (BuildContext context) => const Auth(),
        '/list': (BuildContext context) => const ListPage(),
        '/mood': (BuildContext context) => const MoodPage(),
        '/my': (BuildContext context) => const MyPage(),
        '/calendar': (BuildContext context) => const CalendarPage(),
        '/home': (BuildContext context) => const HomePage(),
        '/info': (BuildContext context) => const InfoPage(),
      },
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}

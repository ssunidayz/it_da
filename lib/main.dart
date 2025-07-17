import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:it_da/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter의 초기화를 보장합니다.
  await Firebase.initializeApp(); // Firebase를 초기화합니다.
  runApp(MyApp());
}


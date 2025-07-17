import 'package:flutter/material.dart';
import 'package:it_da/widget/appbar.dart';
import 'package:it_da/widget/bottom.dart';

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodState();
}

class _MoodState extends State<MoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: const MyBottomNavigator(),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:it_da/questions.dart';
import 'package:it_da/screen/question.dart';
import 'package:it_da/widget/appbar.dart';
import 'package:it_da/widget/bottom.dart';
import 'package:it_da/widget/listappbar.dart';
import 'package:it_da/widget/listbottom.dart';

import 'package:it_da/questions.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late List<Questions> _questions; // List of Question objects

  @override
  void initState() {
    super.initState();
    _questions = []; // Initialize the list
    getQuestions().then((questions) {
      setState(() {
        _questions = questions;
      });
    }); // Fetch questions from Firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ListAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView.builder(
            itemCount: _questions.length,
            itemBuilder: (context, index) {
              Questions question = _questions[index];
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '#${question.number}',
                      style: const TextStyle(
                          fontFamily: '강원교육모두',
                          fontWeight: FontWeight.w300,
                          fontSize: 23),
                    ),
                    const SizedBox(width: 25),
                    Flexible(
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontFamily: '강원교육모두',
                          fontWeight: FontWeight.w300,
                          fontSize: 22,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QuestionPage(question: question.question),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const ListBottomNavigator(),
    );
  }
}

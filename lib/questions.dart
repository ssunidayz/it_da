import 'package:cloud_firestore/cloud_firestore.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Questions {
  Questions({
    required this.number,
    required this.question,
    required this.verse,
  });

  final int number;
  final String question;
  final String verse;
}

// Function to fetch questions from Firestore
Future<List<Questions>> getQuestions() async {
  try {
    QuerySnapshot querySnapshot =
        await _firestore.collection('questions').orderBy('number').get();

    return querySnapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return Questions(
          number: data['number'] as int,
          question: data['question'] as String,
          verse: data['verse'] as String);
    }).toList();
  } catch (e) {
    print('Error fetching questions: $e');
    throw e;
  }
}

// 주어진 숫자보다 큰 'number' 필드를 가진 'questions' 컬렉션의 첫 번째 문서를 가져옵니다.
Future<Questions?> getQuestionAfter(int number) async {
  try {
    // 'number' 필드가 주어진 숫자보다 큰 문서를 찾습니다.
    QuerySnapshot querySnapshot =
        await _firestore.collection('questions').where('number', isGreaterThan: number).orderBy('number').limit(1).get();

    // 해당하는 문서가 없다면 null을 반환합니다.
    if (querySnapshot.docs.isEmpty) {
      return null;
    }

    // 첫 번째 문서의 데이터를 가져옵니다.
    var doc = querySnapshot.docs.first;
    var data = doc.data() as Map<String, dynamic>;

    // 데이터를 'Questions' 객체로 변환하여 반환합니다.
    return Questions(
      number: data['number'] as int,
      question: data['question'] as String,
      verse: data['verse'] as String
    );
  } catch (e) {
    // 에러가 발생하면 콘솔에 에러 메시지를 출력하고 에러를 다시 던집니다.
    print('Error fetching question: $e');
    throw e;
  }
}



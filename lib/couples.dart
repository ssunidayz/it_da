import 'package:cloud_firestore/cloud_firestore.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<int> getCouplesQuestionsCount() async {
  try {
    QuerySnapshot querySnapshot = await _firestore.collection('couples').get();
    int totalQuestions = 0;
    
    for (var doc in querySnapshot.docs) {
      QuerySnapshot questionSnapshot = await _firestore.collection('couples').doc(doc.id).collection('question').get();
      totalQuestions += questionSnapshot.docs.length;
    }
    return totalQuestions;
  } catch (e) {
    print('Error fetching couples questions count: $e');
    throw e;
  }
}

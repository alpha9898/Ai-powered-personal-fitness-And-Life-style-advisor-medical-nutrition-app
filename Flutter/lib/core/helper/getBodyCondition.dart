import 'package:cloud_firestore/cloud_firestore.dart';

Future<String?> getBodyCondition(String UserId) async {
  try {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(UserId).get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      return data['bodyCondition'];
    } else {
      print("User not found");
      return null;
    }
  } catch (e) {
    print("Error fetching body condition: $e");
    return null;
  }
}

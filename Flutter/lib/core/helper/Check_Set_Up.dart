import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkIfUserCompletedSetup(String userId) async {
  try {
    var userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      var userData = userDoc.data();
      if (userData != null &&
          userData.containsKey('weight') &&
          userData.containsKey('height') &&
          userData.containsKey('gender') &&
          userData.containsKey('age') &&
          userData['weight'] != null &&
          userData['height'] != null &&
          userData['gender'] != null &&
          userData['age'] != null &&
          userData['weight'] != '' &&
          userData['height'] != '' &&
          userData['gender'] != '' &&
          userData['age'] != '') {
        return true; // بيانات الجسم موجودة، يعني المستخدم دخلها قبل كده
      }
    }
  } catch (e) {
    print("خطأ أثناء تحميل بيانات المستخدم: $e");
  }
  return false; // لو مفيش بيانات، يبقى المستخدم لازم يعدي على الـ Setup
}

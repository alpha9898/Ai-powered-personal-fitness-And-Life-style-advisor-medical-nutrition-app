import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project_ui/Features/Auth/data/Models/User_Model.dart';
import 'package:graduation_project_ui/core/Models/ExerciseModel.dart';
import 'package:graduation_project_ui/core/Models/MealModel.dart';
import 'package:graduation_project_ui/core/Services/Data_Base_Service.dart';

class FireBaseStoreService extends DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId}) async {
    if (documentId != null) {
      await firestore
          .collection(path)
          .doc(documentId)
          .set(data, SetOptions(merge: true));
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future getData(
      {required String path,
      String? documentId,
      Map<String, dynamic>? query}) async {
    if (documentId != null) {
      var data = await firestore.collection(path).doc(documentId).get();

      return data.data()! as Map<String, dynamic>;
    } else {
      Query<Map<String, dynamic>> data = firestore.collection(path);
      if (query != null) {
        if (query['orderBy'] != null) {
          var orderBy = query['orderBy'];
          var descending = query['descending'] ?? false;
          data = data.orderBy(orderBy, descending: descending);
        }

        if (query['limit'] != null) {
          var limit = query['limit'];
          data = data.limit(limit);
        }
      }

      var result = await data.get();

      return result.docs.map((e) {
        return e.data();
      }).toList();
    }
  }

  @override
  Future<void> addUserData(UserModel user) async {
    await addData(
      path: 'users', // تخزين في كولكشن users
      documentId: user.id, // استخدام uid الخاص بالمستخدم كمفتاح
      data: user.toMap(),
    );
  }

  @override
  Future<void> addWorkoutToFavorites(
      String userId, Exercisemodel exercisemodel) async {
    final userDOC = FirebaseFirestore.instance.collection('users').doc(userId);

    // First check if the document exists and initialize the field if it doesn't
    final docSnapshot = await userDOC.get();
    if (!docSnapshot.exists ||
        !docSnapshot.data()!.containsKey('favoriteWorkouts')) {
      await userDOC.set({
        'favoriteWorkouts': [exercisemodel.toJson()]
      }, SetOptions(merge: true));
    } else {
      await userDOC.update({
        'favoriteWorkouts': FieldValue.arrayUnion([exercisemodel.toJson()])
      });
    }
  }

  @override
  Future<void> removeWorkoutFromFavorites(
      String userId, Exercisemodel exercisemodel) {
    final userDOC = FirebaseFirestore.instance.collection('users').doc(userId);
    return userDOC.update({
      'favoriteWorkouts': FieldValue.arrayRemove([exercisemodel.toJson()])
    });
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchFavoriteWorkouts(
      String userId) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    // If the document doesn't exist or doesn't have favoriteWorkouts field, create it
    if (!userDoc.exists || !userDoc.data()!.containsKey('favoriteWorkouts')) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({'favoriteWorkouts': []}, SetOptions(merge: true));

      // Fetch the document again after creating the field
      return FirebaseFirestore.instance.collection('users').doc(userId).get();
    }

    return userDoc;
  }

  // Meal favorites implementations
  @override
  Future<void> addMealToFavorites(String userId, Mealmodel mealmodel) async {
    final userDOC = FirebaseFirestore.instance.collection('users').doc(userId);

    // First check if the document exists and initialize the field if it doesn't
    final docSnapshot = await userDOC.get();
    if (!docSnapshot.exists ||
        !docSnapshot.data()!.containsKey('favoriteMeals')) {
      await userDOC.set({
        'favoriteMeals': [mealmodel.toJson()]
      }, SetOptions(merge: true));
    } else {
      await userDOC.update({
        'favoriteMeals': FieldValue.arrayUnion([mealmodel.toJson()])
      });
    }
  }

  @override
  Future<void> removeMealFromFavorites(
      String userId, Mealmodel mealmodel) async {
    final userDOC = FirebaseFirestore.instance.collection('users').doc(userId);
    return userDOC.update({
      'favoriteMeals': FieldValue.arrayRemove([mealmodel.toJson()])
    });
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchFavoriteMeals(
      String userId) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    // If the document doesn't exist or doesn't have favoriteMeals field, create it
    if (!userDoc.exists || !userDoc.data()!.containsKey('favoriteMeals')) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({'favoriteMeals': []}, SetOptions(merge: true));

      // Fetch the document again after creating the field
      return FirebaseFirestore.instance.collection('users').doc(userId).get();
    }

    return userDoc;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swe444/models/meals.dart';
import 'package:swe444/models/profile.dart';
import 'dart:math';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection("user");
  final CollectionReference mealCollection =
      Firestore.instance.collection("meals");
  Future insertUser(
      String uid, String full_name, String email, String password) async {
    return await userCollection.document(uid).setData(
        {'uid': uid, 'name': full_name, "email": email, "password": password});
  }

// method for insert meal info into database
  Future insertMeals(
      int category,
      String title,
      String description,
      String ingredients,
      String step,
      int duration,
      String email,
      String imageURL) async {
    Random random = new Random();
    int randomNumber = random.nextInt(1000000000);
    return await mealCollection.document("$randomNumber").setData({
      'id': "$randomNumber",
      "category": category,
      'title': title,
      'description': description,
      'ingredients': ingredients,
      'steps': step,
      'duration': duration,
      'email': email,
      'imageURL': imageURL
    });
  }

  Future removeMeal(String id) {
    mealCollection.document(id).delete();

  }

// method for display list of meals info into screen(private)
  List<Meal> _mealListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Meal(
          id: doc.data['id'] ?? '',
          title: doc.data['title'] ?? '',
          description: doc.data['description'] ?? '',
          category: doc.data['category'] ?? 0,
          ingredients: doc.data['ingredients'] ?? '',
          step: doc.data['steps'] ?? '',
          duration: doc.data['duration'] ?? 0,
          email: doc.data['email'] ?? '',
          imageURL: doc.data['imageURL'] ?? '');
    }).toList();
  }

  Stream<List<Meal>> get meals {
    return mealCollection.snapshots().map(_mealListFromSnapShot);
  }

  List<profile1> _userListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return profile1(
          uid: doc.data['uid'] ?? '',
          name: doc.data['name'] ?? '',
          email: doc.data['email'] ?? '',
          password: doc.data['password'] ?? '');
    }).toList();
  }

  Stream<List<profile1>> get users {
    return userCollection.snapshots().map(_userListFromSnapShot);
  }
}

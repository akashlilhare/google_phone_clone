import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:houzeo_sample/model/user_model.dart';

const String userCollection = "user_collection";

class DataBaseHelper {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String?> saveUser({required User user}) async {
    String id = await _db
        .collection(userCollection)
        .add(user.toJson())
        .then((value) => value.id);
    return id;
  }

  Future<List<User>?> getAllUser() async {
    List<User> userList = [];
    QuerySnapshot querySnapshot = await _db.collection(userCollection).get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      userList.add(
          User.fromFirestoreQuery(doc.data()! as Map<String, dynamic>, doc.id));
    }
    return userList;
  }

  Future<void> updateUser({required User user}) async {
    DocumentReference userDoc = _db.collection(userCollection).doc(user.userId);
    return userDoc.update(user.toJson());
  }

  Future<void> deleteUser({required User user}) async {
    DocumentReference userDoc = _db.collection(userCollection).doc(user.userId);
    await userDoc.delete();
  }

  Future<List<User>?> getFavouritesContact() async {
    List<User> userList = [];

    QuerySnapshot querySnapshot = await _db
        .collection(userCollection)
        .where("is_favourite", isEqualTo: true)
        .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      userList.add(
          User.fromFirestoreQuery(doc.data()! as Map<String, dynamic>, doc.id));
    }
    return userList;
  }
}

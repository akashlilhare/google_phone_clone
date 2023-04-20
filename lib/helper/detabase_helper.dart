import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:houzeo_sample/model/user_model.dart';

const String userCollection = "user_collection";

class DataBaseHelper {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<String?> saveUser({required User user}) async {
    try {
      String id = await _db
          .collection(userCollection)
          .add(user.toJson())
          .then((value) => value.id);
      return id;
    } catch (e) {
      return null;
    }
  }

  Future<List<User>?> getAllUser() async {
    List<User> userList = [];
    try {
      QuerySnapshot querySnapshot = await _db.collection(userCollection).get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        userList.add(User.fromFirestoreQuery(
            doc.data()! as Map<String, dynamic>, doc.id));
      }
      return userList;
    } catch (error) {
      throw ('Failed to get users: $error');
    }
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
    print("function called");
    List<User> userList = [];
    try {
      QuerySnapshot querySnapshot = await _db
          .collection(userCollection)
          .where("is_favourite", isEqualTo: true)
          .get();

      print("function called");
      print(querySnapshot.docs);

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        print(doc.data());
        userList.add(User.fromFirestoreQuery(
            doc.data()! as Map<String, dynamic>, doc.id));
      }
      return userList;
    } catch (error) {
      throw ('Failed to get users: $error');
    }
  }
}

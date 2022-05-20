import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/User.dart';

class UserDataService {
  var _userId;
  late CollectionReference _users;

  UserDataService({String? userId}) {
    _userId = userId;
    _users = FirebaseFirestore.instance.collection('UserData');
  }

  Stream<User> get userData {
    // final userID = AuthenticationService(FirebaseAuth.instance).userIdGetter();
    return _users.doc(_userId).snapshots().map((snap) {
      print("Hello snap $snap");
      return User.fromMap(snap.data() as Map<dynamic, dynamic>);
    });
  }

  Future<String?> addUser({
    required String userId,
    required String userName,
    String? userEmail,
  }) async {
    try {
      await _users.doc(_userId).set({
        'userId': userId,
        'userName': userName,
        'userEmail': userEmail,
        'userCreatedTime': DateTime.now().millisecondsSinceEpoch,
      }).then((value) => print("User Added"));
    } on FirebaseException catch (e) {
      return e.message;
    }
    return null;
  }

  Future<bool> checkUserExisted(String userId) async {
    var userExist;
    await _users.doc(userId).get().then((DocumentSnapshot docSnap) {
      if (docSnap.exists) {
        userExist = true;
      } else {
        userExist = false;
      }
    });
    return userExist;
  }
}

class User {
  late String _userId;
  late String _emailId;
  late String _displayName;

  User({required String userId, required String emailId, required String displayName}) {
    _userId = userId;
    _emailId = emailId;
    _displayName = displayName;
  }

  factory User.fromMap(Map json) {
    return User(userId: json["userId"], emailId: json["emailId"], displayName: json["displayName"]);
  }

  String get userId {
    if (_userId.isEmpty) {
      return "User Id is Empty";
    }
    return _userId;
  }

  String get emailId {
    if (_emailId.isEmpty) {
      return "Email Id is Empty";
    }
    return _emailId;
  }

  String get displayName {
    if (_displayName.isEmpty) {
      return "Display is Empty";
    }
    return _displayName;
  }
}

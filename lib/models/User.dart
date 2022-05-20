class User {
  late String _userId;
  late String _emailId;
  late String _displayName;
  late double? _userCreatedTime;

  User(
      {required String userId,
      required String emailId,
      required String displayName,
      required double? userCreatedTime}) {
    _userId = userId;
    _emailId = emailId;
    _displayName = displayName;
    _userCreatedTime = userCreatedTime;
  }

  factory User.fromMap(Map json) {
    return User(
        userId: json["userId"],
        emailId: json["emailId"],
        displayName: json["displayName"],
        userCreatedTime: json["userCreatedTime"]);
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

  double get userCreatedTime {
    if (_userCreatedTime == null) {
      return -1;
    }
    return _userCreatedTime!;
  }
}

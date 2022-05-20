import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../models/User.dart';
import '../services/UserDataService.dart';

class UserManager extends ChangeNotifier {
  /// user service instance
  late UserDataService _userService;

  /// user data object
  late User _user;

  late StreamSubscription _userDataSubscription;

  /// user Id - can only be modified by calling constructor cant be externally called
  String? _userId;

  UserManager(this._userId) {
    if (_userId != null) {
      _userService = UserDataService(userId: _userId);
      startUserDataSubscription();
    } else {
      _user = User(userId: '', displayName: '', emailId: '', userCreatedTime: null);
    }
  }

  startUserDataSubscription() {
    _userDataSubscription = _userService.userData.listen((User user) {
      _user = user;
      notifyListeners();
    });
  }

  ///Getters
  ///User
  User get user {
    return _user;
  }

  @override
  dispose() {
    super.dispose();
    _userDataSubscription.cancel();
  }
}

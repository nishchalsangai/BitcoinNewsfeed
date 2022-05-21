import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/toasts.dart';

import '../core/AppTheme.dart';
import '../services/AuthenticationService.dart';

class AuthStateManager extends ChangeNotifier {
  /// Authentication Service Instance
  late AuthenticationService _authService;

  /// A connection stream to track device connectivity Status
  late StreamSubscription _connectionSubscription;

  /// Connectivity Status will be tracked using _activeConnection where false means no connection
  bool _activeConnection = false;

  /// A firebase auth instance
  late FirebaseAuth _firebaseAuth;

  ///A Stream to track status of user auth
  ///If logged in --> User else Null
  late StreamSubscription _authStatus; // Auth object to indicate status of login

  ///UserId of logged user
  String? _userId;

  /// To check for a New User
  late bool _newUserFlag;

  /// To simulate loading in between auth changes
  late bool isLoading = false;

  ///Firebase user object
  User? _user;

  AuthStateManager() {
    _firebaseAuth = FirebaseAuth.instance;
    _activeConnection = false;
    checkConnectionStatus();
    _authService = AuthenticationService(_firebaseAuth);
    _userId = null;
    _newUserFlag = false;
    startAuthStatusSubscription();
  }

  /// Initialization of ConnectionStream
  void checkConnectionStatus() async {
    _connectionSubscription =
        Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        _activeConnection = true;
        notifyListeners();
      } else {
        _activeConnection = false;
        notifyListeners();
      }
    });
  }

  ///Initialization of Auth Stream
  void startAuthStatusSubscription() {
    _authStatus = _firebaseAuth.idTokenChanges().listen((User? user) {
      toggleIsLoading();
      if (user == null) {
        _userId = null;
      } else {
        _userId = user.uid;
      }
      toggleIsLoading();
    });
  }

  ///Get single user object to prevent late initialization error
  ///A instance of user can be provider in auth widget builder to user manager to avaoid that error.
  ///And till then a loading can be simulated with isLoading.
  /// Auth Methods
  ///
  initiateGoogleSignUp() {
    toggleIsLoading();
    _authService.signInWithGoogle().then((value) {
      toggleIsLoading();
      ShowToast(value!, AppTheme.nearlyGreen, 1);
    });
  }

  userWasWelcomed() {
    _newUserFlag = false;
    notifyListeners();
  }

  toggleIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  signOut() {
    _userId = null;
    _authService.signOut();
  }

  ///Getters
  bool get connectionStatus {
    return _activeConnection;
  }

  String? get userId {
    return _userId;
  }

  bool newUserStatusGetter() {
    return _newUserFlag;
  }

  @override
  dispose() {
    super.dispose();
    _connectionSubscription.cancel();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screens/HomeScreen.dart';
import 'package:untitled/screens/LogInScreen.dart';
import 'package:untitled/screens/NoConnectionPage.dart';

import 'managers/AuthManager.dart';
import 'managers/HomeManager.dart';
import 'managers/UserManager.dart';

class AuthWidget extends StatelessWidget {
  AuthWidget();

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthStateManager, UserManager>(
        builder: (context, authStateManager, userManager, child) {
      if (authStateManager.connectionStatus) {
        final firebaseUser = authStateManager.userId;
        if (firebaseUser != null) {
          return ChangeNotifierProvider(
              create: (_) => HomeManager(firebaseUser), child: const HomeScreen());
        } else {
          return const LogInScreen();
        }
      } else {
        return const NoConnectionPage();
      }
    });
  }
}

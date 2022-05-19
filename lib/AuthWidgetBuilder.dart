import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/screenutil_init.dart';
import 'package:provider/provider.dart';

import 'managers/AuthManager.dart';
import 'managers/UserManager.dart';

class AuthWidgetBuilder extends StatelessWidget {
  AuthWidgetBuilder({this.builder});

  final Widget Function(BuildContext)? builder;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthStateManager>(builder: (context, authStateManager, child) {
      return ChangeNotifierProvider(
        create: (_) => UserManager(authStateManager.userId),
        child: builder!(context), //, userSnap as AsyncSnapshot<User?>
      );
    });
  }
}

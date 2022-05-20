import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'AuthWidget.dart';
import 'AuthWidgetBuilder.dart';
import 'managers/AuthManager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AuthStateManager(),
        child: AuthWidgetBuilder(builder: (context) {
          //, userSnapshot
          return ScreenUtilInit(
            designSize: Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: (context, widget) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
              theme: ThemeData(
                fontFamily: GoogleFonts.montserrat().fontFamily,
                scaffoldBackgroundColor: const Color(0xFFFFFFFF),
                primarySwatch: Colors.blue,
                canvasColor: Colors.transparent,
              ),
              home: AuthWidget(),
              //userSnapshot: userSnapshot
            ),
          );
        }));
  }
}

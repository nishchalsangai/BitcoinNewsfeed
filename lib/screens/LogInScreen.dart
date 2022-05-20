import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled/managers/AuthManager.dart';

import '../core/AppTheme.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthStateManager>(builder: (context, credentialsManager, child) {
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage("assets/images/hello.png"),
                    fit: BoxFit.contain,
                    height: 300.h,
                    width: 300.w,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: /*isLoading
                            ? null
                            :*/
                          () {
                        credentialsManager.initiateGoogleSignUp();
                        /*  context
                              .read<AuthenticationService>()
                              .signInWithGoogle()
                              .then((value) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (value == "Signed in using google" ||
                                value == "Signed up using google") {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('$value'),
                                backgroundColor: AppTheme.nearlyBlue,
                              ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('$value'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('${error.message}'),
                              backgroundColor: Colors.red,
                            ));
                          });*/
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        primary: AppTheme.nearlyWhite,
                        shadowColor: AppTheme.chipBackground,
                        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
                      ),
                      child: /*isLoading
                            ? CircularProgressIndicator(
                          color: AppTheme.nearlyBlue,
                          backgroundColor: AppTheme.dark_grey,
                        )
                            :*/
                          Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 12.r,
                                backgroundImage: const AssetImage('assets/images/google_logo.jpg')),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text('Continue with Google',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17.sp,
                                    color: AppTheme.deactivatedText)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFFAFAFA);
  static const Color nearlyWhite = Color(0xFFFDFEFF);
  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyGreen = Color(0xFF4cb34c);
  static const Color nearlyRed = Color(0xFFFF0000);
  static const Color secondary = Color(0xFF5ce1e6);
  static const Color lightBlue = Color(0xFFe6f8fe);
  static const Color nearlyBlack = Color(0xFF1c1d1f);
  static const Color light_grey = Color(0xFFF9F9F9);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF26293a);

  static const Color darkText = Color(0xFF2B2B2B);
  static const Color darkerText = Color(0xFF171717);
  static const Color lightText = Color(0xFF687980);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);

  static TextStyle heading = TextStyle(
      fontSize: 20.sp, letterSpacing: .27, fontWeight: FontWeight.w600, color: AppTheme.dark_grey);

  static TextStyle paragraph = TextStyle(
    fontSize: 15.sp,
    color: grey,
  );

  static TextStyle bottom_info = TextStyle(
    color: Color(0xffA6B0BD),
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );

  static TextStyle btn_text = TextStyle(
      letterSpacing: 1.725, fontWeight: FontWeight.w600, fontSize: 18.sp, color: Colors.white);

  static ButtonStyle btn_style = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.r),
    ),
    primary: AppTheme.nearlyBlue,
    shadowColor: AppTheme.dark_grey.withOpacity(0.5),
    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
  );

  static BoxDecoration box_shadow = BoxDecoration(
      color: AppTheme.nearlyWhite,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: AppTheme.grey.withOpacity(0.2),
          blurRadius: 16.r,
        ),
      ],
      borderRadius: BorderRadius.circular(16.r));

  static BoxDecoration box_shadow_noBorder = BoxDecoration(
    color: AppTheme.nearlyWhite,
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: AppTheme.grey.withOpacity(0.2),
        blurRadius: 16,
      ),
    ],
  );

  static BoxDecoration inputContainer = BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.circular(16.r),
    ),
    boxShadow: [
      BoxShadow(
        color: AppTheme.chipBackground,
        blurRadius: 10.r,
        spreadRadius: 5.r,
      ),
    ],
  );

  static TextStyle intro_head = TextStyle(
      fontSize: 30.sp, letterSpacing: .15, fontWeight: FontWeight.w700, color: AppTheme.dark_grey);

  static TextStyle intro_para = TextStyle(
      fontSize: 18.sp, letterSpacing: .15, fontWeight: FontWeight.w400, color: AppTheme.lightText);

  static TextStyle title = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16.sp,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static TextStyle subtitle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    letterSpacing: -0.04,
    color: darkText,
  );

  static TextStyle body2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    letterSpacing: 0.2,
    color: darkText,
  );

  static TextStyle body1 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: lightText,
  );

  static TextStyle caption = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static TextStyle body3 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13.sp,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static TextStyle tag_txt = TextStyle(
      letterSpacing: .5, fontWeight: FontWeight.w500, fontSize: 10.sp, color: Colors.white);
}
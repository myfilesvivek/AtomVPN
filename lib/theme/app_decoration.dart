import 'package:flutter/material.dart';
import 'package:vpn_basic_project/theme/theme_helper.dart';
import 'package:vpn_basic_project/utils/app_exports.dart';

class AppDecoration {
// Fill decorations
  static BoxDecoration get fillIndigo => BoxDecoration(
        color: appTheme.indigo5002,
      );
  static BoxDecoration get fillIndigo5001 => BoxDecoration(
        color: appTheme.indigo5001,
      );

  static BoxDecoration get fillTeal => BoxDecoration(
        color: appTheme.teal50,
      );

// Outline decorations
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        color: appTheme.indigo50,
        border: Border.all(
          color: appTheme.blueGray70002.withOpacity(0.4),
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.gray4002b,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      );

  static BoxDecoration get outlineBluegray700991 => BoxDecoration(
        color: appTheme.blue3004c01,
        border: Border.all(
          color: appTheme.blueGray70099,
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.cyan20075,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              1,
            ),
          )
        ],
      );

  static BoxDecoration get outlineBluegray70003 => BoxDecoration(
        color: appTheme.gray5047,
        border: Border.all(
          color: appTheme.blueGray70003.withOpacity(0.35),
          width: 1.2.h,
        ),
      );

  static BoxDecoration get outlineBluegray70004 => BoxDecoration(
        color: appTheme.indigo5003,
        border: Border.all(
          color: appTheme.blueGray70004.withOpacity(0.4),
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.gray4002b,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      );

  static BoxDecoration get outlineBluegray700992 => BoxDecoration(
        color: appTheme.blue3004c01,
        border: Border.all(
          color: appTheme.blueGray70099,
          width: 1.h,
        ),
      );

  static BoxDecoration get outlineBluegray70099 => BoxDecoration(
        color: appTheme.blue3004c,
        border: Border.all(
          color: appTheme.blueGray70099,
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.blue30075,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(0, 1),
          )
        ],
      );
  static BoxDecoration get outlineTealA => BoxDecoration();
}

class BorderRadiusStyle {
// Rounded borders
  static BorderRadius get roundedBorder18 => BorderRadius.circular(
        18.h,
      );

  static BorderRadius get customBorderTL24 => BorderRadius.vertical(
        top: Radius.circular(24.h),
      );
}

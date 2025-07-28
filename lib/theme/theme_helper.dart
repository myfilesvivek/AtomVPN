
import 'package:flutter/material.dart';
import 'package:vpn_basic_project/utils/app_exports.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

class ThemeHelper {
// The current app theme
  var _appTheme = 'primary';
// A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };
// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };
  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }
    /// Returns the current theme data.
    ThemeData _getThemeData() {
      var colorScheme =
          _supportedColorScheme [_appTheme] ?? ColorSchemes.lightCodeColorScheme;
      return ThemeData(
          visualDensity: VisualDensity.standard,
          colorScheme: colorScheme,
          textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.indigo5002,
      );
      }

      LightCodeColors themeColor() => _getThemeColors();
  ThemeData themeData() => _getThemeData();
}

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(

    bodySmall: TextStyle(
      color: appTheme.blueGray70001.withOpacity(0.75),
      fontSize: 10.fSize,
      fontFamily: 'SF Pro Text',
      fontWeight: FontWeight.w400,

    ),

    displayMedium: TextStyle(
    color: appTheme.blueGray70001,
    fontSize: 48.fSize,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,

  ),

  titleMedium: TextStyle(
  color: appTheme.blueGray70001,
  fontSize: 16.fSize,
  fontFamily: 'SF Pro Text',
  fontWeight: FontWeight.w600,

  ),

  titleSmall: TextStyle(
  color: appTheme.blueGray70004,
  fontSize: 14.fSize,
  fontFamily: 'SF Pro Text',
  fontWeight: FontWeight.w600,

  ),

  );
}


class ColorSchemes{
  static final lightCodeColorScheme = ColorScheme.light();
}

class LightCodeColors {
// Bluec
  Color get blue3004c => Color.fromRGBO(108, 160, 234, 0.3);
  Color get blue3004c01 => Color (0X4C6CB3EA);
// Blue
  Color get blue30075 => Color.fromRGBO(108, 160, 234, 0.1);
  Color get blue50 => Color(0XFFDDF0FD);
  Color get blue700 => Color (0XFF296DC8);
  Color get blue70001 => Color (0XFF286DC8);
  Color get blue70026 => Color (0X262975C8);
  Color get blue800 => Color (0XFF2963C8);
  Color get blue80001 => Color (0XFF0060B9);
  Color get blue80002 => Color (0XFF295BC8);
// BlueGray
  Color get blueGray50 => Color(0XFFEDF3F7);
  Color get blueGray700 => Color(0XFF3A4D66);
  Color get blueGray70001 => Color(0XFF3A4C66);
  Color get blueGray70002 => Color(0XFF3A4B66);
  Color get blueGray70003 => Color(0XFF3A4A66);
  Color get blueGray70004 => Color(0XFF3A5066);
  Color get blueGray70099 => Color(0X993A5266);
  Color get blueGray700A3 => Color(0XA33A4F66);
// Gray
  Color get gray4002b => Color (0X2BCC1C0);
  Color get gray100 => Color (0XFFEDF7F4);
  Color get gray5047 => Color(0X47F7FAF8);
  // Cyan
  Color get cyan20075 => Color(0X756ECDEB);
// Indigo
  Color get indigo100 => Color (0XFFC3D2EE);
  Color get indigo50 => Color(0XFFE7EFF7);
  Color get indigo5001 => Color (0XFFDEE6F5);
  Color get indigo5002 => Color (0XFFDEE7F5);
  Color get indigo5003 => Color (0XFFDEE8F5);
// LightBlue
  Color get lightBlueA700 => Color(0XFF0096FF);
// Orange
  Color get orangeA200 => Color (0XFFFCAC35);
// Teal
  Color get teal50 => Color.fromRGBO(222, 233, 245, 1);
  Color get tealA400 => Color(0XFF2CFFCC);
// White
  Color get whiteA700 => Color (0XFFFFFFFF);
// Yellow
  Color get yellow400 => Color (0XFFFDDC67);
  Color get yellowA700 => Color (0XFFE9DE0D);
}
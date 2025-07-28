import 'package:flutter/material.dart';
import 'package:vpn_basic_project/theme/theme_helper.dart';
import 'package:vpn_basic_project/utils/app_exports.dart';

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get sFProText {
    return copyWith(
      fontFamily: 'SF Pro Text',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
// Body text style
  static get bodySmallBluegray700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray700.withOpacity(0.75),
      );
  static get bodySmallBluegray70001 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray70001.withOpacity(0.6),
        fontSize: 8.fSize,
      );

  static get bodySmallBluegray70004 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray70004.withOpacity(0.75),
      );

  static get bodySmallBluegray700a3 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray700A3,
      );
// Title text style
  static get titleMediumBluegray700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray700,
      );
  static get titleMediumInterBlue8000l =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.blue80001,
      );

  static get titleMediumInterBluegray700 =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.blueGray700,
      );

  static get titleSmallInterBluegray70001 =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: appTheme.blueGray70001.withOpacity(0.8),
      );

  static get titleSmallInterBluegray70004 =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: appTheme.blueGray70004.withOpacity(0.8),
      );

  static get titleMediumInterBlue80001 =>
      theme. textTheme.titleMedium!.inter.copyWith(
          color: appTheme.blue80001,
      );

  static get titleMediumInterYellow =>
      theme. textTheme.titleMedium!.inter.copyWith(
        color: Colors.amber,
      );

  static get bodySmallBluegray700048 => theme.textTheme.bodySmall!.copyWith(
    color: appTheme.blueGray70004.withOpacity (0.6),
    fontSize: 8.fSize,
  );


}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

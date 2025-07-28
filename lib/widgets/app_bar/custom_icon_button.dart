import 'package:flutter/material.dart';
import 'package:vpn_basic_project/utils/app_exports.dart';

import '../../theme/theme_helper.dart';




extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get gradientYellowToOrangeA => BoxDecoration(
    borderRadius: BorderRadius.circular(12.h),
    gradient: LinearGradient(
      begin: Alignment(0.29, 0),
      end: Alignment(0.77, 0),
      colors: [appTheme.yellow400, appTheme.orangeA200],
    ),
  );
}

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {Key? key,
        this.alignment,
        this.height,
        this.width,
        this.decoration,
        this.padding,
        this.onTap,
        this.child})
      : super (
    key: key,
  );
  final Alignment? alignment;
  final double? height;
  final double? width;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Widget? child;


  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
        alignment: alignment ?? Alignment.center, child: iconButtonWidget)
        : iconButtonWidget;
  }
  Widget get iconButtonWidget => SizedBox(
    height: height ?? 0,
    width: width ?? 0,
    child: DecoratedBox(
      decoration: decoration ??
          BoxDecoration(
            color: appTheme.blue70026,
            borderRadius: BorderRadius.circular(12.h),
          ),
      child: IconButton(
        padding: padding ?? EdgeInsets.zero,
        onPressed: onTap,
        icon: child ?? Container(),
      ),
    ),
  );
}
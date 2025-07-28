import 'package:flutter/material.dart';
import 'package:vpn_basic_project/utils/app_exports.dart';

import '../custom_image_view.dart';
import 'custom_icon_button.dart';


class AppbarLeadingIconbutton extends StatelessWidget {
  AppbarLeadingIconbutton({Key? key, this.imagePath, this.margin, this.onTap})
      : super(
    key: key,
  );
  final String? imagePath;
  final EdgeInsetsGeometry? margin;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
    padding: margin ?? EdgeInsets.zero,
      child: CustomIconButton(
        height: 40.h,
        width: 40.h,
        padding: EdgeInsets.all(8.h),
        child: CustomImageView(
          imagePath: 'assets/svg/menu_icon.svg',
        ),
      ),
    ),
    );
  }
}
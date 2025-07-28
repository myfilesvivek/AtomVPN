import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controllers/home_controller.dart';
import 'package:vpn_basic_project/helpers/prefs.dart';
import 'package:vpn_basic_project/models/vpn.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';
import 'package:vpn_basic_project/utils/app_exports.dart';
import '../theme/app_decoration.dart';
import '../theme/theme_helper.dart';
import 'custom_image_view.dart';

class VpnServerListItemWidget extends StatelessWidget {
  final Vpn vpnModel;
  Function(String)? changedRadioButton;
  VpnServerListItemWidget(this.vpnModel, {super.key, this.changedRadioButton});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return InkWell(
      onTap: () {
        controller.selectedVpn.value = vpnModel;
        Pref.setVpn = vpnModel;

        Get.back();
       // MyDialogs.success(msg: 'Connecting VPN Location...');
        if(controller.vpnState.value == VpnEngine.vpnConnected) {
          VpnEngine.stopVpn();
          Future.delayed(
              Duration(seconds: 2), () => controller.connectToVpn());
        }else{
          controller.connectToVpn();
        }
      },
      child: Container(
        padding: EdgeInsets.all(12.h),
        decoration: AppDecoration.outlineBluegray70099.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder18,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 18.h,
              minRadius: 18.h,
              child: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/flags/${vpnModel.countryShort.toLowerCase()}.png'),
                maxRadius: 16.h,
                minRadius: 16.h,

                // radius: BorderRadius.circular(30),
                // border: Border.all(color: Colors.white,width: 2),
              ),
            ),
            SizedBox(width: 16.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(vpnModel.countryLong, style: theme.textTheme.titleSmall),
                  SizedBox(height: 4.h),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Text(
                          vpnModel.ip,
                          style: theme.textTheme.bodySmall,
                        ),
                        Container(
                          height: 4.h,
                          width: 4.h,
                          margin: EdgeInsets.only(left: 6.h),
                          decoration: BoxDecoration(
                            color: appTheme.blueGray700.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(
                              2.h,
                            ),
                          ),
                        ),
                        CustomImageView(
                          imagePath: controller.getSpeedNetworkImage(vpnModel.speed),
                          height: 8.h,
                          width: 10.h,
                          margin: EdgeInsets.only(left: 6.h),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.h),
                          child: Text(
                            formatBytes(vpnModel.speed, 0),
                            style: theme.textTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: 16.h),
            // CustomRadioButton(
            //   value: "" ?? "",
            //   groupValue: optimalserverslistItemModelObj.radioGroup!,
            //   onChange: (value) {
            //     changeRadioButton!(value);
            //   },
            // )
          ],
        ),
      ),
    );
  }


}

 String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ['Bps', "Kbps", "Mbps", "Gbps", "Tbps"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

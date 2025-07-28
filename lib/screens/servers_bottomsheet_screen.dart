import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/controllers/vpn_servers_controller.dart';
import 'package:vpn_basic_project/models/vpn.dart';
import 'package:vpn_basic_project/utils/app_exports.dart';
import 'package:vpn_basic_project/widgets/vpn_serverlist_item_widget.dart';
import '../theme/app_decoration.dart';
import '../theme/custom_text_style.dart';

class ServersBottomsheetScreen extends StatelessWidget {
  ServersBottomsheetScreen({super.key});
  final _vpnServerController = VpnServersController();

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("MMM d, h:mm a");
    if (_vpnServerController.vpnList.isEmpty) _vpnServerController.getVPNData();

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: SizeUtils.height * 0.84),
      child: Obx(() => _vpnServerController.isLoading.value
          ? _loadingWidget()
          : _vpnServerController.vpnList.isEmpty
              ? _noVPNFound()
              : _vpnData(context)),
    );
  }

  /// Section Widget
  Widget _buildGlobeSection(BuildContext context) {
    return _noVPNFound();
  }

  _vpnData(context) => SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            decoration: AppDecoration.fillTeal.copyWith(
              borderRadius: BorderRadiusStyle.customBorderTL24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 6.h),
                SizedBox(
                  width: 328.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${_vpnServerController.vpnList.length} Servers",
                                style: CustomTextStyles
                                    .titleMediumInterBluegray700,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                  "Last Updated : ${_vpnServerController.updateDateTime == null ? '--/--/----' : DateFormat("MMM d, h:mm a").format(_vpnServerController.updateDateTime!)}",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey.shade600),
                                ),

                            ],
                          ),
                          IconButton(
                              onPressed: () =>
                                  _vpnServerController.getVPNData(),
                              icon: Icon(CupertinoIcons.refresh))
                        ],
                      ),
                      SizedBox(height: 12.h),
                      _buildOptimalServersList(context),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  /// Section Widget
  Widget _buildOptimalServersList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 14.h,
        );
      },
      itemCount: _vpnServerController.vpnList.length,
      itemBuilder: (context, index) {
        Vpn vpnModel = _vpnServerController.vpnList[index];
        return VpnServerListItemWidget(
          vpnModel,
          changedRadioButton: (value) {
            // provider.changeRadioButton(index, value);
          },
        );
      },
    );
  }

  // ListView.builder(
  _loadingWidget() => SizedBox(
        width: SizeUtils.width,
        height: SizeUtils.height,
        child: LottieBuilder.asset(
          'assets/lottie/loading_hand.json',
          width: 24.h,
        ),
      );

  _noVPNFound() => Center(
        child: Text(
          "No VPN Server Found! 😔",
          style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 18.fSize),
        ),
      );
}

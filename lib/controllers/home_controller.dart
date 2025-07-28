import 'dart:convert';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vpn_basic_project/helpers/my_dialogs.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';

import '../helpers/prefs.dart';
import '../models/vpn.dart';
import '../models/vpn_config.dart';

class HomeController extends GetxController {


  final Rx<Vpn> selectedVpn = Pref.vpn.obs;

  final vpnState = VpnEngine.vpnDisconnected.obs;

  Future<void> connectToVpn() async {
    ///Stop right here if user not select a vpn
    if (selectedVpn.value.openVPNConfigDataBase64.isEmpty) {
      MyDialogs.info(msg: 'Select a Location by clicking \'Optional Location\'');
      return;
    };

    if (vpnState.value == VpnEngine.vpnDisconnected) {

      final data =
          Base64Decoder().convert(selectedVpn.value.openVPNConfigDataBase64);

      final config = Utf8Decoder().convert(data);

      final vpnConfig = VpnConfig(
          country: selectedVpn.value.countryLong,
          username: 'vpn',
          password: 'vpn',
          config: config);

      ///Start if stage is disconnected
      VpnEngine.startVpn(vpnConfig);

    } else {
      ///Stop if stage is "not" disconnected

      VpnEngine.stopVpn();
    }
  }
  Future<void> requestNotificationPermissions() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      // Notification permissions granted
    } else if (status.isDenied) {
      // Notification permissions denied
    } else if (status.isPermanentlyDenied) {
      // Notification permissions permanently denied, open app settings
      await openAppSettings();
    }
  }

  String get getButtonImage {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return 'assets/images/disconnected_button.png';

      case VpnEngine.vpnConnected:
        return 'assets/images/connected_button.png';

      case VpnEngine.vpnConnecting ||
            VpnEngine.vpnAuthenticating ||
            VpnEngine.vpnWaitConnection || VpnEngine.vpnReconnect:
        return 'assets/images/connecting_button.png';

      default:
        return 'assets/images/disconnected_button.png';
    }
  }


  String  getSpeedNetworkImage(int bytes) {

   // var i = (log(bytes) / log(1024)).floor();
    double sp = bytes / (1024 * 1024);
    // double sp = (bytes / pow(1024, i));
    // print("BYTES ${bytes} I $i sp $sp mb $mb");

        if(sp >= 400) {
          return 'assets/svg/green_network.svg';
        }else if(sp < 400 && sp >= 200){
          return 'assets/svg/orange_network.svg';
        }
        else if(sp < 200 && sp>=100){
          return 'assets/svg/yellow_network.svg';
        }else{
          return 'assets/svg/red_network.svg';
        }


    }
  }



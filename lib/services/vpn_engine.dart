import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import '../models/vpn_status.dart';
import '../models/vpn_config.dart';

class VpnEngine {
  ///Channel to native
  static final String _eventChannelVpnStage = "vpnStage";
  static final String _eventChannelVpnStatus = "vpnStatus";
  static final String _methodChannelVpnControl = "vpnControl";

  static  MethodChannel _vpnControlChannel = MethodChannel(_methodChannelVpnControl);

  // Method to get VPN status on app launch
  static Future<String> checkVpnStatusOnLaunch() async {
    try {
      final String status = await _vpnControlChannel.invokeMethod('check_vpn_status_on_launch');
      return status;
    } on PlatformException {
      return 'error';  // Handle the error as needed
    }
  }

  ///Snapshot of VPN Connection Stage
  static Stream<String> vpnStageSnapshot() =>
      EventChannel(_eventChannelVpnStage).receiveBroadcastStream().cast();

  ///Snapshot of VPN Connection Status
  static Stream<VpnStatus?> vpnStatusSnapshot() =>
      EventChannel(_eventChannelVpnStatus)
          .receiveBroadcastStream()
          .map((event) => VpnStatus.fromJson(jsonDecode(event)))
          .cast();

  ///Start VPN easily
  static Future<void> startVpn(VpnConfig vpnConfig) async {
    return MethodChannel(_methodChannelVpnControl).invokeMethod(
      "start",
      {
        "config": vpnConfig.config,
        "country": vpnConfig.country,
        "username": vpnConfig.username,
        "password": vpnConfig.password,
      },
    );
  }

  ///Stop vpn
  static Future<void> stopVpn() =>
      MethodChannel(_methodChannelVpnControl).invokeMethod("stop");

  ///Open VPN Settings
  static Future<void> openKillSwitch() =>
      MethodChannel(_methodChannelVpnControl).invokeMethod("kill_switch");

  ///Trigger native to get stage connection
  static Future<void> refreshStage() =>
      MethodChannel(_methodChannelVpnControl).invokeMethod("refresh");

  ///Get latest stage
  static Future<String?> stage() =>
      MethodChannel(_methodChannelVpnControl).invokeMethod("stage");

  ///Check if vpn is connected
  static Future<bool> isConnected() =>
      stage().then((value) => value?.toLowerCase() == "connected");

  ///All Stages of connection
  static const String vpnConnected = "connected";
  static const String vpnDisconnected = "disconnected";
  static const String vpnWaitConnection = "wait_connection";
  static const String vpnAuthenticating = "authenticating";
  static const String vpnReconnect = "reconnect";
  static const String vpnNoConnection = "no_connection";
  static const String vpnConnecting = "connecting";
  static const String vpnPrepare = "prepare";
  static const String vpnDenied = "denied";
}

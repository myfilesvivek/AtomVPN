import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../models/vpn.dart';

class Pref {
  static late Box _vpnBox;

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    _vpnBox = await Hive.openBox('vpn_server_data');

  }

  static Vpn get vpn => Vpn.fromJson(jsonDecode(_vpnBox.get('vpn') ?? '{}'));

  static DateTime? get vpnUpdatedDate => _vpnBox.get('updated_on') ?? null;

  static set setVpn(Vpn v) => _vpnBox.put('vpn', jsonEncode(v)).then((_)=> print("SAVED ${v.hostName}")).catchError((val)=> print('ERROR => ${val}'));

  static set setUpdatedData(DateTime date) => _vpnBox.put('updated_on', date).then((_)=> print("SAVED Data}")).catchError((val)=> print('ERROR => ${val}'));


  //for storing vpn servers details
  static List<Vpn> get vpnList {
    List<Vpn> temp = [];
    final data = jsonDecode(_vpnBox.get('vpnList') ?? '[]');

    for (var i in data) temp.add(Vpn.fromJson(i));

    return temp;
  }



  static set vpnList(List<Vpn> v) => _vpnBox.put('vpnList', jsonEncode(v));

}

import 'package:get/get.dart';
import 'package:vpn_basic_project/helpers/prefs.dart';
import 'package:vpn_basic_project/models/vpn.dart';

import '../apis/apis.dart';

class VpnServersController extends GetxController {

  List<Vpn> vpnList = Pref.vpnList;

  DateTime? updateDateTime = Pref.vpnUpdatedDate;

  final RxBool isLoading  = false.obs;

  Future<void> getVPNData() async{
    isLoading.value = true;
    vpnList.clear();
    vpnList = await  APIs.getVPNServers();
    updateDateTime = Pref.vpnUpdatedDate;
    isLoading.value = false;
  }


}
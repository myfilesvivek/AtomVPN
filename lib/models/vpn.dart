class Vpn {

  late final String hostName;
  late final String ip;
  // late final int score;
  late final String ping;
  late final int speed;
  late final String countryLong;
  late final String countryShort;
  late final int numVpnSessions;
  // late final int uptime;
  // late final int totalUsers;
  // late final int totalTraffic;
  // late final String logType;
  // late final String operator;
  // late final String message;
  late final String openVPNConfigDataBase64;


  Vpn({
    required this.hostName,
    required this.ip,
    // required this.score,
    required this.ping,
    required this.speed,
    required this.countryLong,
    required this.countryShort,
    required this.numVpnSessions,
    // required this.uptime,
    // required this.totalUsers,
    // required this.totalTraffic,
    // required this.logType,
    // required this.operator,
    // required this.message,
    required this.openVPNConfigDataBase64,
  });


  Vpn.fromJson(Map<String, dynamic> json) {
    hostName = json['HostName'] ?? '';
    ip = json['IP'] ?? '';
    //  score = json['Score'] ?? 0;
    ping = json['Ping'].toString();
    speed = json['Speed'] ?? 0;
    countryLong = json['CountryLong'] ?? '';
    countryShort = json['CountryShort'] ?? '';
    numVpnSessions = json['NumVpnSessions'] ?? 0;
    // uptime = json['Uptime']  ?? '';
    // totalUsers = json['TotalUsers'] ?? '';
    // totalTraffic = json['TotalTraffic'] ?? '';
    // logType = json['LogType'] ?? '';
    // operator = json['Operator'] ?? '';
    // message = json['Message'] ?? '';
    openVPNConfigDataBase64 = json['OpenVPN_ConfigData_Base64'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['HostName'] = hostName;
    data['IP'] = ip;
    // _data['Score'] = score;
    data['Ping'] = ping;
    data['Speed'] = speed;
    data['CountryLong'] = countryLong;
    data['CountryShort'] = countryShort;
    data['NumVpnSessions'] = numVpnSessions;
    // _data['Uptime'] = uptime;
    // _data['TotalUsers'] = totalUsers;
    // _data['TotalTraffic'] = totalTraffic;
    // _data['LogType'] = logType;
    // _data['Operator'] = operator;
    // _data['Message'] = message;
    data['OpenVPN_ConfigData_Base64'] = openVPNConfigDataBase64;
    return data;
  }
}

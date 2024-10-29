class AutoGenerate {
  AutoGenerate({
    this.HostName,
    this.IP,
    this.Ping,
    this.Speed,
    this.CountryLong,
     this.CountryShort,
     this.NumVpnSessions,
     this.OpenVPNConfigDataBase64, // uncoded data
  });
  late final String? HostName;
  late final String? IP;
  late final int? Ping;
  late final int? Speed;
  late final String? CountryLong;
  late final String? CountryShort;
  late final int? NumVpnSessions;
  late final String?OpenVPNConfigDataBase64;
  
  AutoGenerate.fromJson(Map<String, dynamic> json){
    HostName = json['HostName'] ?? "";
    IP = json['IP'] ?? "";
    Ping = json['Ping'] ?? 0;
    Speed = json['Speed'] ?? 0;
    CountryLong = json['CountryLong'] ?? "";
    CountryShort = json['CountryShort'] ?? "";
    NumVpnSessions = json['NumVpnSessions'] ?? "";
    OpenVPNConfigDataBase64 = json['OpenVPN_ConfigData_Base64'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['HostName'] = HostName;
    _data['IP'] = IP;
    _data['Ping'] = Ping;
    _data['Speed'] = Speed;
    _data['CountryLong'] = CountryLong;
    _data['CountryShort'] = CountryShort;
    _data['NumVpnSessions'] = NumVpnSessions;
    _data['OpenVPN_ConfigData_Base64'] = OpenVPNConfigDataBase64;
    return _data;
  }
}
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vpn_app/Controller/services/Helper/Pref.dart';
import 'package:vpn_app/Controller/services/vpn_engine.dart';
import 'package:vpn_app/Models/vpn.dart';
import 'package:vpn_app/Models/vpn_Configuration.dart';
import 'package:vpn_app/Views/Constant.dart';

enum VpnState {disconnected, connected,connecting}

class HomeProvider extends ChangeNotifier{
  AutoGenerate vpn = Pref.vpn;
  var vpnState = VpnEngine.vpnDisconnected;
//  late  AutoGenerate vpn;

  //   HomeProvider() {
  //   vpn = AutoGenerate(); // Initialize the vpn object
  // }
  connectToVPN(context) async{
    if(vpn.OpenVPNConfigDataBase64!.isEmpty){
      return  ;
    }
    else if (vpnState == VpnEngine.vpnDisconnected){
      final data = Base64Decoder().convert(vpn.OpenVPNConfigDataBase64!);
      final config = Utf8Decoder().convert(data);
      final vpnConfig = VpnConfig(
        country: vpn.CountryLong!, 
        username: "vpn", 
        password: "vpn", 
        config: config
        );

    await VpnEngine.startVpn(vpnConfig);
    notifyListeners();
    }
    else{
      VpnEngine.stopVpn();
      notifyListeners();
    }
  } 

  

  void changevpnState(vpnV){
    vpnState = vpnV;
    notifyListeners();
    
  }

  String get getButtonText{
    switch(vpnState){
      case VpnEngine.vpnDisconnected:
      return 'Tap to Connect';
      case VpnEngine.vpnConnected:
      return '  Disconnected  ';
      default:
      return '  Connecting...';
      
    }
    
  }

  List<Color> get getButtonColor{
    switch(vpnState){
      case VpnEngine.vpnDisconnected:
       return [
        blue,
        gradientBlue,
       ];

      case VpnEngine.vpnConnected:
      return [
        green,
        gradientgreen,
        gradientgreen,
      ];
      default:
      return [

        Colors.yellow,
        gradientyellow,
          gradientyellow,
      ];
    }

  }


  /// for getting Box shadow color  
Color get getBoxShadowColor {  
    switch (vpnState) {  
        case VpnEngine.vpnDisconnected:  
            return lightGradientBlue.withOpacity(0.08);  

        case VpnEngine.vpnConnected:  
            return green;  

        default:  
            return Colors.yellow;  
    }  
}

List<Color> get getGradientWhiteColor{
  switch(vpnState){
    case VpnEngine.vpnDisconnected:
    return [

      lightBlue.withOpacity(0.08),
      lightGradientBlue.withOpacity(0.08),
    ];
    case VpnEngine.vpnConnected:
    return [

      gradientgreen.withOpacity(0.08),
      gradientgreen.withOpacity(0.08)
    ];
    default:
    return [
      Colors.yellow,
      gradientyellow,
      gradientyellow,
    ];
  }
}
}
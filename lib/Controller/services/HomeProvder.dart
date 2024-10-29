import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vpn_app/Controller/services/vpn_engine.dart';
import 'package:vpn_app/Models/vpn.dart';
import 'package:vpn_app/Views/Constant.dart';

class HomeProvider extends ChangeNotifier{
  var vpnState = VpnEngine.vpnDisconnected;
  late AutoGenerate vpn;

  
  HomeProvider() {
    vpn = AutoGenerate(); // Initialize the vpn object
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
            return blue;  

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
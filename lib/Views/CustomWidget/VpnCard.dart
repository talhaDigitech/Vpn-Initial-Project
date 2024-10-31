import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpn_app/Controller/services/Helper/Pref.dart';
import 'package:vpn_app/Controller/services/HomeProvder.dart';
import 'package:vpn_app/Controller/services/vpn_engine.dart';
import 'package:vpn_app/Models/vpn.dart';
import 'package:vpn_app/Views/Constant.dart';

class VpnCard extends StatelessWidget {
  final AutoGenerate vpn;
  const VpnCard({super.key, required this.vpn});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return  InkWell(
      onTap: () {
        homeProvider.vpn= vpn;
        Pref.vpn = vpn;
        Navigator.pop(context);
        if(homeProvider.vpnState == VpnEngine.vpnConnected){
          VpnEngine.stopVpn();
          Future.delayed(const Duration(seconds: 2), () => homeProvider.connectToVPN(context));
        } else{
          homeProvider.connectToVPN(context);
        }
      },
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: ListTile(
          title: Text(vpn.CountryLong!,
          style: boldStyle.copyWith(
            color: Colors.white,
            fontSize: 15,
          )
          ),
      
          subtitle: Row(
            children: [
              Text(_formatBytes(vpn.Speed!,1),
              style: mediumStyle.copyWith(
                color: Colors.grey,
              ),
              ),
              SizedBox(width: 5,),
              Icon(Icons.speed,color: iconBlueColor,size: 20,)
            ],
          ),
          leading: Container(
            height: 30,
            width: 38,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/flags/${vpn.CountryShort!.toLowerCase()}.png"),
                fit: BoxFit.fill
                )
            ),
          ),
        )
      ),
    );
  }

  String _formatBytes(int bytes, int decimal){
    if(bytes <= 0) return "0 B";
    const suffixes = ['Bps','Kbps',"Mbps", "Gbps","Tbps"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimal)} ${suffixes[i]}';
  }
}
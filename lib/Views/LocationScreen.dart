import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vpn_app/Controller/services/Api/api.dart';
import 'package:vpn_app/Controller/services/LocationProvider.dart';
import 'package:vpn_app/Models/vpn.dart';
import 'package:vpn_app/Views/Constant.dart';
import 'package:vpn_app/Views/CustomWidget/LocationCart.dart';
import 'package:vpn_app/Views/CustomWidget/VpnCard.dart';
import 'package:vpn_app/Views/CustomWidget/alertBox.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LocationProvider locationProvider = LocationProvider();

  List<String> flags = [];
  List<String> countries = [];
  List<AutoGenerate> servers = [];
  String? selectedCountry;
  String? expandedCountry;

  //     List<AutoGenerate> _vpnList = [];
  //    bool _isLoading = false;

  //   List<AutoGenerate> get vpnList => _vpnList;
  //   bool  get isLoading => _isLoading;

  //   List<String> _countrylist = [];
  //   List<String> _flaglist = [];

  //   List<String> get countrylist => _countrylist;
  //   List<String> get flaglist => _flaglist;

  //   Future<void> getContriesData() async{
  //     print("Calling*****************");
  //     _isLoading = true;
  //     _countrylist.clear();
  //     _flaglist.clear();
  //     countries = await Api.getContries();
  //     flags = await Api.getCountriesFlags();
  //     _isLoading = false;
  //     setState(() {});
  //   }

  gettingServers() async {
    await locationProvider.getContriesData();
    await locationProvider.getVpnServer();

    if (mounted) {
      setState(() {
        countries = locationProvider.countrylist;
        print(countries);
        flags = locationProvider.flaglist;
        servers = locationProvider.vpnList;
      });
    }
  }

  @override
  void initState() {
    // _loadVpnServers();
    // print(Api.getVpnServers());
    gettingServers();
    super.initState();
    // gettingServers();
  }

  // void gettingServers() async{
  //   final locationprovider = Provider.of<LocationProvider>(context);
  //   await locationprovider.getContriesData();

  //   if(mounted){
  //     setState(() {
  //       countries = locationprovider.countrylist;
  //       flags = locationprovider.flaglist;
  //     });
  //   }
  // }

//   Future<void> _loadVpnServers() async {
//   try {
//     await Api.getVpnServers();
//   } on SocketException catch (e) {
//     print('Socket Exception: $e');

//   } catch (e) {
//     print('General Exception: $e');

//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          "VPN Serves",
          style: boldStyle,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white)),
        elevation: 0,
      ),
      body: locationProvider.isLoading
          ? LoadingWidget()
          // : locationProvider.vpnList.isEmpty
          // ? VPNNotFound()
          : ServerData(),
    );
  }

  LoadingWidget() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/animation/loading.json",
            width: 200,
            height: 200,
          ),
          Text(
            "Loading VPN...",
            style: boldStyle,
          )
        ],
      ),
    );
  }

  // For Showing Server Data

  ServerData() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return
            // Text(
            //   locationProvider.countrylist[index],
            //   style: TextStyle(color: Colors.white),
            // );
            LocationCart(
          countryName: locationProvider.countrylist[index],
          flag: locationProvider.flaglist[index],
          isExpanded: locationProvider.countrylist[index] == expandedCountry ,
          serves: locationProvider.vpnList.isEmpty 
          ? [CircularProgressIndicator()]
          : servers.asMap().entries.map((MapEntry<int,AutoGenerate> entry){

            return VpnCard(vpn: entry.value,);
          }).toList(),
          tap: (istap){
            setState(() {
              if(expandedCountry == locationProvider.countrylist[index]){
                expandedCountry = null;
                istap = false;
                servers = locationProvider.vpnList;
              }

              else{
                expandedCountry = locationProvider.countrylist[index];
                istap = true;
                servers = serversForSelectedCountries(locationProvider.countrylist[index]);
              }
            });
          },
        );
      },
      itemCount: countries.length,
      shrinkWrap: true,
    );
  }

  VPNNotFound() {
    return Alertbox(
      text: 'Sorry, VPN Not Found! 😔',
    );
  }

  List<AutoGenerate> serversForSelectedCountries(String country){
    List<AutoGenerate> data = locationProvider.vpnList;
    List<AutoGenerate> myserver = data.where((servers)=> servers.CountryLong!.toLowerCase() == country.toLowerCase()).toList( );
    return myserver;
  }
}

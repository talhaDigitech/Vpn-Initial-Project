
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
  LocationProvider locationController = LocationProvider();

  List<String> flags = [];
  List<String> countries = [];
  List<AutoGenerate> servers = [];
  String? selectedCountry;
  String? expandedCountry;



  

  void gettingServers() async {
    // final locationController = Provider.of<LocationProvider>(context, listen: false);

    
  // Load cached data instantly
    setState(() {
      servers = locationController.vpnList;
      countries = locationController.countrylist;
      flags = locationController.flaglist;
    });

    // Fetch updated data in the background if lists are empty
    if (servers.isEmpty || countries.isEmpty || flags.isEmpty) {
      await Future.wait([
        locationController.getContriesData(),
        locationController.getVpnServer(),
      ]);

      if (mounted) {
        setState(() {
          servers = locationController.vpnList;
          countries = locationController.countrylist;
          flags = locationController.flaglist;
        });
      }
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
      body: locationController.isLoading
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
          countryName: locationController.countrylist[index],
          flag: locationController.flaglist[index],
          isExpanded: locationController.countrylist[index] == expandedCountry ,
          serves: locationController.vpnList.isEmpty 
          ? [CircularProgressIndicator()]
          : servers.asMap().entries.map((MapEntry<int,AutoGenerate> entry){

            return VpnCard(vpn: entry.value,);
          }).toList(),
          tap: (istap){
            setState(() {
              if(expandedCountry == locationController.countrylist[index]){
                expandedCountry = null;
                istap = false;
                servers = locationController.vpnList;
              }

              else{
                expandedCountry = locationController.countrylist[index];
                istap = true;
                servers = serversForSelectedCountries(locationController.countrylist[index]);
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
    List<AutoGenerate> data = locationController.vpnList;
    List<AutoGenerate> myserver = data.where((servers)=> servers.CountryLong!.toLowerCase() == country.toLowerCase()).toList( );
    return myserver;
  }
}

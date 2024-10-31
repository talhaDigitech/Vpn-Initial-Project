import 'package:flutter/cupertino.dart';
import 'package:vpn_app/Controller/services/Api/api.dart';
import 'package:vpn_app/Controller/services/Helper/Pref.dart';
import 'package:vpn_app/Models/vpn.dart';
 class LocationProvider with ChangeNotifier {
    List<AutoGenerate> _vpnList = Pref.vpnList;
     bool _isLoading = false;

    List<AutoGenerate> get vpnList => _vpnList;
    bool  get isLoading => _isLoading;

    List<String> _countrylist = Pref.getStoredCountries();
    List<String> _flaglist = Pref.getStoredCountryFlags();

    List<String> get countrylist => _countrylist; 
    List<String> get flaglist => _flaglist; 

    // Vpn Servers
    Future<void> getVpnServer() async{
      _isLoading = true;
      _vpnList.clear();
      _vpnList = await  Api.getVpnServers();
      _isLoading = false;
      notifyListeners();
    }

    Future<void> getContriesData() async{
      print("Calling*****************");
      _isLoading = true;
      _countrylist.clear();
      _flaglist.clear();
      _countrylist = await Api.getContries();
      _flaglist = await Api.getCountriesFlags();
       // Store countries and flags in Hive
    await Pref.storeCountries(_countrylist);
    await Pref.storeCountryFlags(_flaglist);
      _isLoading = false;
      notifyListeners();
    }
}
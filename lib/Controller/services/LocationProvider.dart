import 'package:flutter/cupertino.dart';
import 'package:vpn_app/Controller/services/Api/api.dart';
import 'package:vpn_app/Models/vpn.dart';
 class LocationProvider with ChangeNotifier {
    List<AutoGenerate> _vpnList = [];
     bool _isLoading = false;

    List<AutoGenerate> get vpnList => _vpnList;
    bool  get isLoading => _isLoading;

    List<String> _countrylist = [];
    List<String> _flaglist = [];

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
      _isLoading = false;
      notifyListeners();
    }
}
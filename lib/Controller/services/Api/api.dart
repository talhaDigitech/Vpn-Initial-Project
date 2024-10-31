
// import 'dart:math';
import 'dart:convert';
import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:http/http.dart';
import 'package:vpn_app/Controller/services/Helper/Pref.dart';
import 'package:vpn_app/Models/vpn.dart';

class Api{

  static Future<List<AutoGenerate>> getVpnServers() async{
    final List<AutoGenerate> vpnList = [];
    try{
       final response = await get(Uri.parse("https://www.vpngate.net/api/iphone/",
       ));
    final csvString = response.body.split("#")[1].replaceAll("*", "");
    List<List<dynamic>> csvlist = const CsvToListConverter().convert(csvString);
    log(response.body);
    final header = csvlist[0];
  Map<String,dynamic> tempJson = {};
    for(int i = 1; i< header.length;++i){
      for(int j = 0; j< header.length;++j){
      tempJson.addAll({(header[j]).toString():(csvlist[i][j])});
      }
      vpnList.add(AutoGenerate.fromJson(tempJson));
    }
    // log(vpnList.first.HostName);

    }
    catch(e){
      print(e.toString());
    }
   
      // log(tempJson.toString());
      // log(jsonEncode(tempJson));
    vpnList.shuffle();

    if(vpnList.isNotEmpty){
      Pref.vpnList = vpnList;
    }
      
     return vpnList;
  }

  static Future<List<String>> getContries() async{
    List<String> contries = [];
    try{
      final response = await get(Uri.parse("https://www.vpngate.net/api/iphone/"));

      if(response.statusCode == 200){

        // Parse the response as needed (it is in CSV format)

        List<String> lines = response.body.split("\n");
        print(lines);

        // Extract unique countries with flag
        Set<String> uniqueContries = {};
        for(int i = 2; i < lines.length; i++){
          List<String> serverInfo = lines[i].split(",");

          if(serverInfo.length > 7){
            uniqueContries.add(serverInfo[5]);
          }
        }

        // Convert country name to CountryData  with flag
        contries = uniqueContries.toList();
        await Pref.storeCountries(contries);
        print(contries);

      }else{
        print("ERROR: Unable to fetch data. Status code. ${response}");
      }
    } catch(e){
      print("Error: $e");
    }

    return contries;

  }



  static Future<List<String>> getCountriesFlags() async{
    List<String> flags = [];
    try{
      final response = await get(Uri.parse("https://www.vpngate.net/api/iphone/"));

      if(response.statusCode == 200){

        // Parse the response as needed (it is in CSV format)

        List<String> lines = response.body.split("\n");
        print(lines);

        // Extract unique countries with flag
        Set<String> uniqueContries = {};
        for(int i = 2; i < lines.length; i++){
          List<String> serverInfo = lines[i].split(",");

          if(serverInfo.length > 6){
            uniqueContries.add(serverInfo[6]);
          }
        }

        // Convert country name to CountryData  with flag
        flags = uniqueContries.toList();
        await Pref.storeCountryFlags(flags);
        print(flags);

      }else{
        print("ERROR: Unable to fetch data. Status code. ${response}");
      }
    } catch(e){
      print("Error: $e");
    }

    return flags;

  }

}

  

//*** CSV Data ***  
// Name, Country, Ping  
// Test1, JP, 12  
// Test2, US, 112  
// Test3, IN, 7  

//*** List Data ***  
// [ [Name, Country, Ping], [Test1, JP, 12], [Test2, US, 112], [Test3, IN, 7] ]  

//*** Json Data ***  
// { "Name": "Test1", "Country": "JP", "Ping": 12 }
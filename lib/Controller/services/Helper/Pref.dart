import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vpn_app/Models/vpn.dart';

class Pref{
  static late Box box;
  static Future<void>InitializeHive() async{
    await Hive.initFlutter();
    box = await Hive.openBox("data"); 
  }

    // For storing single selected vpn detail
  static AutoGenerate get vpn =>  AutoGenerate.fromJson(jsonDecode(box.get('vpn')?? "{}"));
  static set vpn(AutoGenerate v) => box.put('vpn', jsonEncode(v));

    // / for storing vpn servers details   
static set vpnList(List<AutoGenerate> v) => box.put('vpnList', jsonEncode(v));  
static List<AutoGenerate> get vpnList {  
    List<AutoGenerate> temp = [];  
    final data = jsonDecode(box.get('vpnList') ?? '[]');  
    for (var i in data) temp.add(AutoGenerate.fromJson(i));  
    return temp;  
}

  static Future<void> storeCountryFlags(List<String> flags) async {  
    await InitializeHive(); // Ensure Hive is initialized  
    await box.put('countryFlags', jsonEncode(flags));  
}  

static List<String> getStoredCountryFlags() {  
    final data = box.get('countryFlags');  
    return data != null ? List<String>.from(jsonDecode(data)) : [];  
}  

static Future<void> storeCountries(List<String> countries) async {  
    await InitializeHive(); // Ensure Hive is initialized  
    await box.put('countries', jsonEncode(countries));  
}  

static List<String> getStoredCountries() {  
    final data = box.get('countries');  
    return data != null ? List<String>.from(jsonDecode(data)) : [];  
}

}


//   /// for storing vpn servers details  
// static set vpnList(List<AutoGenerate> v) => box.put('vpnList', jsonEncode(v));  
// static List<AutoGenerate> get vpnList {  
//     List<AutoGenerate> temp = [];  
//     final data = jsonDecode(box.get('vpnList') ?? '[]');  
//     for (var i in data) temp.add(AutoGenerate.fromJson(i));  
//     return temp;  
// }

//   static Future<void> storeCountryFlags(List<String> flags) async {  
//     await InitializeHive(); // Ensure Hive is initialized  
//     await box.put('countryFlags', jsonEncode(flags));  
// }  

// static List<String> getStoredCountryFlags() {  
//     final data = box.get('countryFlags');  
//     return data != null ? List<String>.from(jsonDecode(data)) : [];  
// }  

// static Future<void> storeCountries(List<String> countries) async {  
//     await InitializeHive(); // Ensure Hive is initialized  
//     await box.put('countries', jsonEncode(countries));  
// }  

// static List<String> getStoredCountries() {  
//     final data = box.get('countries');  
//     return data != null ? List<String>.from(jsonDecode(data)) : [];  
// }



// }
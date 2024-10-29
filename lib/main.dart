import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_app/Controller/services/HomeProvder.dart';
import 'package:vpn_app/Controller/services/LocationProvider.dart';
import 'package:vpn_app/Views/Constant.dart';
import 'package:vpn_app/Views/HomeScreen.dart';
import 'package:vpn_app/Views/OnBoardingScreen.dart';
import 'package:vpn_app/Views/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_){
    runApp(const MyApp());
  });
  
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool newUser = false;

  // Checking for new user
  WherToGo() async{
    var sharedpreference = await SharedPreferences.getInstance();
    var user = sharedpreference.getBool("newUser");
    if(user != null){
      if(user){
        setState(() {
          newUser = true;
        });
      }else{
        setState(() {
          newUser = false;

        });
      }
    }else{
      setState(() {
          newUser = true;

        });
    }
  }

  @override
  void initState() {
    super.initState();
    WherToGo();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create:(context) => HomeProvider() ),
        ChangeNotifierProvider<LocationProvider>(create:(context) => LocationProvider() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: newUser ? OnBoardingScreen() : SplachScreen(),
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: primaryColor, 
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: primaryColor, systemNavigationBarColor: primaryColor)
          ),
        ),
      ),
    );
  }
}

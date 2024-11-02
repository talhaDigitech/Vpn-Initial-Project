import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn_app/Views/Constant.dart';
import 'package:vpn_app/Views/HomeScreen.dart';
import 'package:vpn_app/Views/OnBoardingScreen.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), (){
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              "assets/images/logo.svg",
              height: 150,
              width: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("VPN APP",style: boldStyle,),
          )

        ],
      ),
    );
  }
}
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vpn_app/Views/Constant.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  const MyButton({super.key,
  required this.text, 
  required this.ontap,
  });
  


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 9),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [blue, gradientBlue],
            ),
             
            ),
            child: Center(
              child: Text(text,
              style: btnStyle,
              ),
            ) ,
      ),
    );
  }
}

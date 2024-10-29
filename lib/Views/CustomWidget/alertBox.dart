import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vpn_app/Views/Constant.dart';

class Alertbox extends StatelessWidget {
  final String text;
  const Alertbox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 170,
            width: 280,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10,30,10,8),
              child: Column(
                children: [
                  Expanded(child: Text("Alert",style: boldStyle.copyWith(color: Colors.black),)),
                  Expanded(child: Text(text,style: mediumStyle.copyWith(color: Colors.black),)),
              
                  Expanded(
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      color: lightGradientBlue ,
                      child: Text("Okay",style: TextStyle(color: Colors.white),),
                      ),
                  )
                ],
              ),
            ),
          ),
        
        Positioned(
          top: -20,
          child: CircleAvatar(
            backgroundColor: lightGradientBlue ,
            radius: 25,
            child: Icon(Icons.check, color: Colors.white, size: 25,),
          ),
        )
        ],
      ),
    );
  }
}
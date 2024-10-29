import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vpn_app/Views/Constant.dart';

class HomeCard extends StatelessWidget {
  final String? title;
  final String subtitle;
  final IconData icon;
  final image;
  const HomeCard({super.key,  this.title, required this.subtitle, required this.icon, this.image = null});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        children: [
          // Icon
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              height: 50,
              width: 50,
               decoration: image != null ?
                BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: FractionalOffset.topRight,
                  end: FractionalOffset.bottomLeft,
                  colors: [
                    blue,
                    gradientBlue,
                 ]),
             image:  DecorationImage(image: AssetImage(image), fit: BoxFit.fill)
            )
            :  BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: FractionalOffset.topRight,
                  end: FractionalOffset.bottomLeft,
                  colors: [
                    lightBlue,
                    lightGradientBlue,
                 ]),
             
            ),
            child: Icon(icon,size: 26, color: Colors.white,),
            ),
          ),
          // title
          Text(title!,style: btnStyle.copyWith(fontSize: 14,color: Colors.white ),),
          SizedBox(height: 2,),
          // suntitle
          Text(subtitle,style: greyStyle.copyWith(color: greytext),)
        ],
      ),
    );
  }
}
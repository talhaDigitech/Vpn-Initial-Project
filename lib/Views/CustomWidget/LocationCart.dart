import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vpn_app/Views/Constant.dart';

class LocationCart extends StatelessWidget {
  final String countryName,flag;
  final Function(bool value)? tap;
  final bool isExpanded;
  final List<Widget> serves;
  const LocationCart({super.key, required this.countryName, required this.flag, this.tap, required this.isExpanded, required this.serves});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
              onExpansionChanged: tap,
              leading: Container(
                width: 48,
                height: 38,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/flags/${flag.toLowerCase()}.png",
                    ),
                    fit: BoxFit.fill ,
                    )
                ),
              ),
              title: Text(countryName,style: boldStyle.copyWith(fontSize: 16),),
              trailing: Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,),
              children: isExpanded ? serves : [],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
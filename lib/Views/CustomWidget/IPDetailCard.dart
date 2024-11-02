import 'package:flutter/material.dart';
import 'package:vpn_app/Views/Constant.dart';

class IpDetailCard extends StatelessWidget {
  final title, subtitle;
  final IconData icon;
  const IpDetailCard({super.key, required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1)
          )
        ]
      ),
      child: Card(
        elevation: 5,
        color: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        child: ListTile(
          leading: Icon(
            icon,size: 22,color: Colors.white,
          ),
          title: Text(title,style: boldStyle.copyWith(fontSize: 16),),
          subtitle: Text(subtitle,style: mediumStyle.copyWith(color: MediumGray,fontSize: 13),),
        ),
      ),
    );
  }
}
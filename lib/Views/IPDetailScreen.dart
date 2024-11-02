import 'package:flutter/material.dart';
import 'package:vpn_app/Controller/services/Api/api.dart';
import 'package:vpn_app/Models/NetworkDetailModel.dart';
import 'package:vpn_app/Views/Constant.dart';
import 'package:vpn_app/Views/CustomWidget/IPDetailCard.dart';

class IpdetailScreen extends StatefulWidget {
  const IpdetailScreen({super.key});

  @override
  State<IpdetailScreen> createState() => _IpdetailScreenState();
}

class _IpdetailScreenState extends State<IpdetailScreen> {
  var data;
  @override
  void initState() {
    getData();
    super.initState();
  }

  // Getting IP Details
  getData() async {
    var ipData = NetworkDetail.fromJson({});
    var detail = await Api.getIPDetails(ipData: ipData);
    data = detail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          "IP Address Detail",
          style: boldStyle,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: 15,
          bottom: 5,
          left: 12,
          right: 12,
        ), // EdgeInsets.only
        children: [
          //IP
          IpDetailCard(
            title: "IP Address",
            subtitle: data?.query ?? "Loading...",
            icon: Icons.lock_outline,
          ),

          //isIP
          IpDetailCard(
            title: "Internet",
            subtitle: data?.isp ?? "Loading...",
            icon: Icons.satellite_alt_sharp,
          ),

          // location

          IpDetailCard(
            title: "Location",
            subtitle: (data != null &&
                    data.country != null &&
                    data.country.isNotEmpty)
                ? '${data.city}, ${data.regionName}, ${data.country}'
                : 'Fetching ...',
            icon: Icons.location_on,
          ),

          //pin code
          IpDetailCard(
            title: "Pin-code",
            subtitle: data?.zip ?? "Loading...",
            icon: Icons.lock_outline,
          ),

          //timezone code
          IpDetailCard(
            title: "Timezone",
            subtitle: data?.timezone ?? "Loading...",
            icon: Icons.access_time,
          ),
        ],
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}

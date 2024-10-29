import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpn_app/Controller/services/HomeProvder.dart';
import 'package:vpn_app/Controller/services/vpn_engine.dart';
import 'package:vpn_app/Models/vpn_status.dart';
import 'package:vpn_app/Views/Constant.dart';
import 'package:vpn_app/Views/CustomWidget/CountDownTimer.dart';
import 'package:vpn_app/Views/CustomWidget/HomeCard.dart';
import 'package:vpn_app/Views/LocationScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // HomeProvider homeProvider = HomeProvider();
  @override
  Widget build(BuildContext context) {
      final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          "VPN APP",
          style: logoStyle,
        ),
        elevation: 0,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: 26,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>LocationScreen()));
              },
              icon: Icon(
                CupertinoIcons.globe,
                color: Colors.white,
                size: 28,
              )),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          // Connection button
          Expanded(
            flex: 5,
            child: Center(child: VpnConnectionButton())),
            // Status button
          Expanded(
            flex: 1,
            child: ConnectionStatusLabel()),
            // timer
            Expanded(
              flex: 1,
              child: CountDownTimer(startTimer: homeProvider.vpnState == VpnEngine.vpnConnected )),
              // VPN detail
          Expanded(
            flex: 5,
            child: ConnectionVpnDetails())
        ],
      ),
    );
  }

  // VPN Connection button    
  Widget VpnConnectionButton() {
    final homeProvider = Provider.of<HomeProvider>(context);
    return InkWell(
      onTap: (){
        homeProvider.changevpnState(VpnEngine.vpnConnected);
      },
      borderRadius: BorderRadius.circular(100),
      child: Container(
         padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: FractionalOffset.topRight,
                end: FractionalOffset.bottomLeft,
                colors: [
                  lightBlue.withOpacity(0.08),
                  lightGradientBlue.withOpacity(0.08),
                ]),
            boxShadow: [
              BoxShadow(
                color: lightGradientBlue.withOpacity(0.08),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ), // BoxShadow
            ], //
          ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: FractionalOffset.topRight,
                end: FractionalOffset.bottomLeft,
                colors: [
                  lightBlue.withOpacity(0.08),
                  lightGradientBlue.withOpacity(0.08),
                ]),
            boxShadow: [
              BoxShadow(
                color: lightGradientBlue.withOpacity(0.08),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ), // BoxShadow
            ], //
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    blue,
                    gradientBlue,
                  ],
                  begin: FractionalOffset.topRight,
                  end: FractionalOffset.bottomLeft,
                ),
                boxShadow: [
                  BoxShadow(
                    color: blue.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ]),
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // power icon
                  Icon(
                    Icons.power_settings_new,
                    size: 28,
                    color: iconBlueColor,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Tap to Connect",
                    style: greyStyle,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// Connection Status Button
  Widget ConnectionStatusLabel(){

    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 70),
      decoration: BoxDecoration(
        color: lightGradientBlue ,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(child: Text("Disconnect",style: boldStyle,)),
    );
  }

// Connection VPN Details
Widget ConnectionVpnDetails(){
  return Column(
    children: [
      
      SizedBox(height: 20,),
      Expanded(
        child: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
             return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
                    // country flag
                    Expanded(
                      child: HomeCard(
                                  title: homeProvider.vpn.CountryLong == null ? "Country" 
                                  : homeProvider.vpn.CountryLong , 
                                  subtitle: "Free", 
                                  icon: (homeProvider.vpn.CountryLong == null) ? Icons.vpn_lock_rounded : Icons.abc , 
                                  image: homeProvider.vpn.CountryLong == null ?  null
                                  : "assets/flags/${homeProvider.vpn.CountryShort!.toLowerCase()}.png"
                                  ,
                                  ),
                    ),
                    Expanded(
                      child: HomeCard(
                                  title: homeProvider.vpn.CountryLong == null ? "100 ms"
                                  : '${homeProvider.vpn.Ping} ms', 
                                  subtitle: "Ping", 
                                  icon: CupertinoIcons.chart_bar_alt_fill
                                  ),
                    ),
            ],
                    );
          }
          
        ),
      ),
      SizedBox(height: 20,),
      Expanded(
        child: StreamBuilder<VpnStatus?>( 
          initialData: VpnStatus() ,
          stream: VpnEngine.vpnStatusSnapshot() ,
          builder: (context,snapshot){
            final byteIn = (snapshot.data?.byteIn) ?? 0;
            final byteOut = (snapshot.data?.byteOut) ?? 0;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
          // country flag
          Expanded(
            child: HomeCard(
              title: byteIn == 0 ? "0 kbps" : '$byteIn kbp', 
              subtitle: "Download", 
              icon: Icons.arrow_downward_rounded
              ),
          ),
          Expanded(
            child: HomeCard(
              title: byteOut == 0 ? "0 kbps" : '$byteOut kbps',
              subtitle: "Upload", 
              icon: Icons.arrow_upward_rounded
              ),
          ),
            ],
          );
          }
        ),
      ),
   
    ],
  );
}
}

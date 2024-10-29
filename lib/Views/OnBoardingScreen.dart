import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_app/Models/SplashScreenContent.dart';
import 'package:vpn_app/Views/Constant.dart';
import 'package:vpn_app/Views/CustomWidget/MyButton.dart';
import 'package:vpn_app/Views/SplashScreen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: PageView.builder(
                itemCount: contents.length,
                controller: _pageController, 
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: SvgPicture.asset(
                            contents[index].image,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              contents[index].title,
                              style: boldStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            contents[index].description,
                            style: mediumStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                })),
          ),
          // Dot
          Expanded(
              flex: 1,
              child: Container(
                height: 8,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (index) => buildDot(index, context),
                  ),
                ),
              )),
          // Botton
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 4),
                      child: MyButton(
                        text: "Next",
                        ontap: () async {
                          if (currentIndex == contents.length - 1) {
                            var sharedpreference = await SharedPreferences.getInstance();
                              sharedpreference.setBool('newUser', true);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SplachScreen()));
                          }
                          _pageController?.nextPage(
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.bounceInOut);
                        },
                      ),
                    ),
                  )
                ],
              )),

          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20,top: 5),
              child: InkWell(
                onTap: () async {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SplachScreen()));
                },
                child: Text("Skip",
                style: btnStyle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

// Dot for showing current Widget
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: FractionalOffset.topRight,
          end: FractionalOffset.bottomLeft,
          colors: currentIndex == index
              ? [
                  blue,
                  gradientBlue,
                ]
              : [Colors.white, Colors.white],
        ), // LinearGradient
      ),
    );
  }
}
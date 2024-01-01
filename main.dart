import 'package:ai3on/Mysearches.dart';
import 'package:ai3on/NewSplashScreen.dart';
import 'package:ai3on/SplashScreen.dart';
import 'package:ai3on/menusample.dart';
import 'package:ai3on/models/DealsDetailsModel.dart';
import 'package:ai3on/models/HomePageModel.dart';
import 'package:ai3on/models/ViewRentListModel.dart';
import 'package:ai3on/notifications%20page.dart';
import 'package:ai3on/property%20for%20sale%20view%20page.dart';
import 'package:ai3on/screens/ChatScreen/ChatList.dart';
import 'package:ai3on/screens/MenuList/About.dart';
import 'package:ai3on/screens/MenuList/MyAds.dart';
import 'package:ai3on/screens/MenuList/MyAdsList.dart';
import 'package:ai3on/screens/MenuList/TermsandConditions.dart';
import 'package:ai3on/screens/MenuList/WishList.dart';
import 'package:ai3on/screens/MyCard.dart';
import 'package:ai3on/screens/NewScreen/SigninScreen.dart';
import 'package:ai3on/screens/ViewAllScreen/FilterPage.dart';
import 'package:ai3on/screens/ViewAllScreen/SaleandRentViewPage.dart';
import 'package:ai3on/screens/details/DealsDetailScreen.dart';
import 'package:ai3on/screens/details/MotorDetails.dart';
import 'package:ai3on/screens/details/RentDetails.dart';
import 'package:ai3on/screens/homescreens/Add.dart';
import 'package:ai3on/screens/homescreens/DealsPage.dart';
import 'package:ai3on/screens/homescreens/HomePage.dart';
import 'package:ai3on/screens/homescreens/Mainpage.dart';
import 'package:ai3on/screens/homescreens/NewClass.dart';
import 'package:ai3on/screens/homescreens/SearchPage.dart';
import 'package:ai3on/screens/plans/PaymentPlan.dart';
import 'package:ai3on/signingmyads.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'models/MenuModel.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/bgim.png"), context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
       home:SplashScreen(),
    );
  }
}



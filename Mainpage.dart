import 'package:ai3on/MyColors.dart';
import 'package:ai3on/screens/MenuList/MyAds.dart';
import 'package:ai3on/screens/MyCard.dart';
import 'package:ai3on/screens/NewScreen/SigninScreen.dart';
import 'package:ai3on/screens/homescreens/ClassiFiScreen.dart';
import 'package:ai3on/screens/homescreens/NewClass.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../menusample.dart';
import 'Add.dart';
import 'Classifieds.dart';
import 'DealsPage.dart';
import 'HomePage.dart';
import 'Menu.dart';


class Mainpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainpageState();
  }
}

class _MainpageState extends State<Mainpage> {
  List<BottomNavigationBarItem> itemss = [
    BottomNavigationBarItem(icon: Icon(Icons.home,size: 30,),label: "Home",),
    BottomNavigationBarItem(icon: Icon(Icons.search,size: 30,),label: "Classifieds"),
    BottomNavigationBarItem(icon: Icon(Icons.add_circle,size: 30,),label: "Add"),
    BottomNavigationBarItem(icon: Icon(Icons.bookmark_add,size: 30,),label: "Deals"),
    BottomNavigationBarItem(icon: Icon(Icons.menu,size: 30,),label: "Menu")
  ];

  int myindex = 0;

  List<Widget> screens = [
    HomePage(),
   // MyAds(),
   // MyCard(),
    NewClass(),
    Add(),
    DealsPage(),
    Menusample(),
  ];

  bool islogin = false;

  get() async {
    var sharedpref  = await SharedPreferences.getInstance();
    islogin = sharedpref.getBool("islogin")!;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get!();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Mainpage"),
      // ),
      body: screens[myindex],
      bottomNavigationBar: Container(width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/footer.jpg'), fit: BoxFit.cover),
        ),
        child: BottomNavigationBar(
          selectedItemColor:  MyColors.yellow,
          // Color(0xfffec50e),
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 11),
          currentIndex: myindex,
          items: itemss,
          onTap: (index){
            setState(() {
              if(index == 2){
                if(!islogin){
                  showTopSnackBar(context,
                    CustomSnackBar.error(
                      message:
                      "Please Login to Continue to Post your Ad",
                    ),
                  );
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SigninScreen()));
                }else{
                  myindex = index;

                }
              }else{
                myindex = index;
              }
            });
          },
        ),
      ),
    );
  }
}

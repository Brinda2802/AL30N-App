import 'package:ai3on/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../menusample.dart';
import '../NewScreen/SigninScreen.dart';
import '../homescreens/Add.dart';
import '../homescreens/DealsPage.dart';
import '../homescreens/HomePage.dart';
import '../homescreens/NewClass.dart';

class About extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AboutState();
  }
}

class _AboutState extends State<About> {
  bool islogin = false;

  get() async {
    var sharedpref  = await SharedPreferences.getInstance();
    islogin = sharedpref.getBool("islogin")!;
  }
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
  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration:
            BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/footer.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 2,
          centerTitle: true,
          title: Text("All About Al3on",style: TextStyle(
            fontWeight: FontWeight.bold,
          ),),
          actions: [],
        ),
        body:
        SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height:700,
                  width:330,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 10,
                        color: Colors.white),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
                        child: Text("Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries."
                            " The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, "
                            "Home needs and many others.Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries. "
                            "The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, Home needs and many others."
                            "Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries. "
                            "The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, Home needs and many others.",
                          maxLines: 6,textAlign: TextAlign.center,style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,height: 1.7),),
                      ),
                      SizedBox(height: 10,),
                      Text("Motors",style: TextStyle(color: MyColors.navy,fontSize: 17,fontWeight: FontWeight.w500),),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        child: Text("Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries."
                            " The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, "
                            "Home needs and many others.Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries. "
                            "The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, Home needs and many others."
                            "Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries. "
                            "The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, Home needs and many others.",
                          maxLines: 6,textAlign: TextAlign.center,style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,height: 1.7),),
                      ),
                      SizedBox(height: 10,),
                      Text("Classifieds",style: TextStyle(color: MyColors.navy,fontSize: 17,fontWeight: FontWeight.w500),),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        child: Text("Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries."
                            " The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, "
                            "Home needs and many others.Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries. "
                            "The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, Home needs and many others."
                            "Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries. "
                            "The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, Home needs and many others.",
                          maxLines: 6,textAlign: TextAlign.center,style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,height: 1.7),),
                      ),
                    ],
                  ),
                ),
              ),
            ],

          ),
        ),
        bottomNavigationBar: Container(width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/footer.jpg'), fit: BoxFit.cover),
          ),child:
          BottomNavigationBar(
            selectedItemColor:  MyColors.yellow,
            // Color(0xfffec50e),
            unselectedItemColor: Colors.white,
            showUnselectedLabels: true,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(fontSize: 12),
            unselectedLabelStyle: TextStyle(fontSize: 11),
            // ... (existing properties)
            onTap: (index) {
              setState(() {
                // Update the currentIndex
                myindex = index;
              });

              // Navigate to the selected page using Navigator
              switch (index) {
                case 0: // HomePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                  break;
                case 1: // NewClass
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewClass()),
                  );
                  break;
                case 2: // Add
                // Check if the user is logged in before navigating
                  if (!islogin) {
                    showTopSnackBar(
                      context,
                      CustomSnackBar.error(
                        message: "Please Login to Continue to Post your Ad",
                      ),
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SigninScreen()),
                    );
                  } else {
                    // Navigate to the Add page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Add()),
                    );
                  }
                  break;
                case 3: // DealsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DealsPage()),
                  );
                  break;
                case 4: // Menusample
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menusample()),
                  );
                  break;
                default:
                // You can handle additional cases or leave this empty if not needed
                  break;
              }
            }, items: [
            BottomNavigationBarItem(icon: Icon(Icons.home,size: 30,),label: "Home",),
            BottomNavigationBarItem(icon: Icon(Icons.search,size: 30,),label: "Classifieds"),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle,size: 30,),label: "Add"),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark_add,size: 30,),label: "Deals"),
            BottomNavigationBarItem(icon: Icon(Icons.menu,size: 30,),label: "Menu")
          ],
          ),
        ),
    );
      /*Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration:
              BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/footer.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 2,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom: height/50.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                      child: Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,)),
                ),
                Padding(
                  padding:  EdgeInsets.only(bottom: height/50.0,right: width/4),
                  child: Text("All About AI3ON",style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ],
            ),
            actions: [],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
                child: Text("Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries."
                    " The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, "
                    "Home needs and many others.Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries. "
                    "The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, Home needs and many others."
                    "Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries. "
                    "The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, Home needs and many others.",
                  maxLines: 6,style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,height: 1.7),),
              ),
              SizedBox(height: 10,),
              Text("Motors",style: TextStyle(color: MyColors.navy,fontSize: 17,fontWeight: FontWeight.w500),),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                child: Text("Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries."
                    " The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, "
                    "Home needs and many others.Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries. "
                    "The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, Home needs and many others."
                    "Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries. "
                    "The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, Home needs and many others.",
                  maxLines: 6,style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,height: 1.7),),
              ),
              SizedBox(height: 10,),
              Text("Classifieds",style: TextStyle(color: MyColors.navy,fontSize: 17,fontWeight: FontWeight.w500),),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                child: Text("Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries."
                    " The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, "
                    "Home needs and many others.Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries. "
                    "The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, Home needs and many others."
                    "Al3on Company is a Dubai based company focusing on humanitarian community quality support which is offering characteristic discounts in different industries. "
                    "The objective is to enable Al3on users to reduce their financial expenses all over the UAE in all categories such as health care, Food and Beverage, Automotive, Home needs and many others.",
                  maxLines: 6,style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,height: 1.7),),
              ),
            ],
          )
      );*/
  }
}

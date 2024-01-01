import 'package:ai3on/screens/NewScreen/SigninScreen.dart';
import 'package:ai3on/screens/homescreens/Add.dart';
import 'package:ai3on/screens/homescreens/DealsPage.dart';
import 'package:ai3on/screens/homescreens/HomePage.dart';
import 'package:ai3on/screens/homescreens/NewClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'MyColors.dart';
import 'menusample.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop(
                          );
                      },
                    child: Icon(CupertinoIcons.chevron_back,color: MyColors.navy,size: 20,)),
                Padding(
                  padding: const EdgeInsets.only(right: 100.0),
                  child: Text("My Notifications",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: MyColors.navy,
                  ),),
                ),
                // Icon(CupertinoIcons.delete_solid,color: MyColors.navy,size: 20,),
              ],
            )
            // Row(
            //   children: [
            //     Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,color: MyColors.navy)),
            //     SizedBox(width: 5,),
            //     // Text(username.isEmpty ? "" : username,style: TextStyle(fontSize:17,color: MyColors.navy),),
            //   ],
            // ),

            // Row(mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Icon(Icons.location_on,color: MyColors.mainorange,size: 16,),
            //     SizedBox(width: 2,),
            //     Text("Dubai",style: TextStyle(color: MyColors.mainorange,fontSize: 12),),
            //   ],
            // ),
          ],
        ),
        // actions: [
        //
        //   SizedBox(width: 5,),
        //   Icon(Icons.notifications_active,color: MyColors.mainorange,size: 25,),
        //   SizedBox(width: 5,),
        //   Icon(Icons.chat,color: MyColors.mainorange,size: 25,),
        //   SizedBox(width: 5,),
        // ],
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
Column(
  children: [

    Container(
      height: 112,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Color(0XFFE0E0E0)
          ,)
      ),

      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                    height:70,
                    width: 50,
                    child: Image.asset("assets/building.jpg",fit: BoxFit.cover,)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("80585 new ads for your saved search",style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: MyColors.navy,
                ),),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text("Check out these Apartment/Flat ads"
                    ,style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Text("4 days ago"
                    ,style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: MyColors.mainorange,
                    ),),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    Container(
      height: 112,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0XFFE0E0E0)
            ,)
      ),

      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                    height:70,
                    width: 50,
                    child: Image.asset("assets/building.jpg",fit: BoxFit.cover,)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("80585 new ads for your saved search",style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: MyColors.navy,
                ),),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text("Check out these Apartment/Flat ads"
                    ,style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Text("4 days ago"
                    ,style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: MyColors.mainorange,
                    ),),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    Container(
      height: 112,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0XFFE0E0E0)
            ,)
      ),

      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                    height:70,
                    width: 50,
                    child: Image.asset("assets/building.jpg",fit: BoxFit.cover,)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("80585 new ads for your saved search",style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: MyColors.navy,
                ),),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text("Check out these Apartment/Flat ads"
                    ,style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Text("4 days ago"
                    ,style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: MyColors.mainorange,
                    ),),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    Container(
      height: 112,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0XFFE0E0E0)
            ,)
      ),

      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                    height:70,
                    width: 50,
                    child: Image.asset("assets/building.jpg",fit: BoxFit.cover,)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("80585 new ads for your saved search",style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: MyColors.navy,
                ),),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text("Check out these Apartment/Flat ads"
                    ,style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Text("4 days ago"
                    ,style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: MyColors.mainorange,
                    ),),
                ),
              ],
            ),
          ],
        ),
      ),
    ),

  ],
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
  }
}

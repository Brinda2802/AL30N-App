import 'package:ai3on/screens/NewScreen/SigninScreen.dart';
import 'package:ai3on/screens/homescreens/Add.dart';
import 'package:ai3on/screens/homescreens/DealsPage.dart';
import 'package:ai3on/screens/homescreens/HomePage.dart';
import 'package:ai3on/screens/homescreens/NewClass.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:lottie/lottie.dart';
import 'MyColors.dart';
import 'menusample.dart';

class Mysearches extends StatefulWidget {
  const Mysearches({super.key});

  @override
  State<Mysearches> createState() => _MysearchesState();
}

class _MysearchesState extends State<Mysearches> {
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
  int a = 0;
  int b=0;
  int c=0;
  int d=0;
  int e=0;
  int f=0;
  int g=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      
      appBar: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0.20,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios,size: 15,color:MyColors.navy)),
          Padding(
            padding: const EdgeInsets.only(right: 180.0),
            child: Text("My Searches",style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    ),
      body: 
      SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                a=1;
                                b=0;
                                c=0;
                                d=0;
                                e=0;
                                f=0;
                                g=0;
                              });

                            },
                            child:a==1? Text("All",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: MyColors.mainorange,

                            ),):Text("All",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: MyColors.navy,

                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                a=0;
                                b=1;
                                c=0;
                                d=0;
                                e=0;
                                f=0;
                                g=0;
                              });

                            },
                            child: b==1?Text("Motors",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: MyColors.mainorange,

                            ),):Text("Motors",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: MyColors.navy,

                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                a=0;
                                b=0;
                                c=1;
                                d=0;
                                e=0;
                                f=0;
                                g=0;
                              });
                            },
                            child: c==1?Text("Property For Rent",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: MyColors.mainorange,

                            ),):Text("Property For Rent",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: MyColors.navy,
                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                setState(() {
                                  a=0;
                                  b=0;
                                  c=0;
                                  d=1;
                                  e=0;
                                  f=0;
                                  g=0;
                                });

                              });
                            },
                            child: d==1?Text("Property For Sale",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: MyColors.mainorange,

                            ),):Text("Property For Sale",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: MyColors.navy,

                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                setState(() {
                                  a=0;
                                  b=0;
                                  c=0;
                                  d=0;
                                  e=1;
                                  f=0;
                                  g=0;
                                });

                              });
                            },
                            child: e==1?Text("Classifieds",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: MyColors.mainorange,

                            ),): Text("Classifieds",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: MyColors.navy,

                          ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                a=0;
                                b=0;
                                c=0;
                                d=0;
                                e=0;
                                f=1;
                                g=0;

                              });
                            },
                            child: f==1?Text("Jobs",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: MyColors.mainorange,

                            ),):Text("Jobs",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: MyColors.navy,

                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                a=0;
                                b=0;
                                c=0;
                                d=0;
                                e=0;
                                f=0;
                                g=1;

                              });
                            },

                            child: g==1?Text("Community",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: MyColors.mainorange,

                            ),):Text("Community",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: MyColors.navy,

                            ),),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
                  a==1?
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          height: 210,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:Border.all(color: Color(0xffE0E0E0))
                          ),

                          child: Stack(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 90.0,left: 280),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        // Choose the width of the border

                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Image.asset(
                                        "assets/scootors.jpg",
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center, // Choose the alignment for the image within the container
                                      ),
                                    ),
                                  )
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: Text("property for Rent",style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.grey1,
                                          fontSize: 13,
                                        ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0,),
                                        child: Text(".",style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.grey1,
                                          fontSize: 40,
                                        ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 130.0),
                                        child: Text("All Residential",style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.grey1,
                                          fontSize: 13,
                                        ),),
                                      ),



                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("My Residential Units for Rent...(976...",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.navy,
                                      fontSize: 15,
                                    ),),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0,top: 20,),
                                        child: Container(
                                          height: 30,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                          ),

                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("ABU DHABI",style: TextStyle(
                                                fontSize: 13,
                                                color: MyColors.navy,
                                                fontWeight: FontWeight.w600,

                                              ),),
                                              Icon(Icons.location_on_outlined,size: 15,color: MyColors.mainorange,),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0,top: 20),
                                    child: Text("Saved on : December 21",style: TextStyle(
                                      fontSize: 12,
                                      color: MyColors.grey1,
                                      fontWeight: FontWeight.w400,

                                    ),),
                                  ),
                                ],
                              ),
                            ],

                          ),
                        ),
                        Container(
                          height: 210,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:Border.all(color: Color(0xffE0E0E0))
                          ),

                          child: Stack(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 90.0,left: 280),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        // Choose the width of the border

                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Image.asset(
                                        "assets/scootors.jpg",
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center, // Choose the alignment for the image within the container
                                      ),
                                    ),
                                  )
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: Text("property for Rent",style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.grey1,
                                          fontSize: 13,
                                        ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0,),
                                        child: Text(".",style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.grey1,
                                          fontSize: 40,
                                        ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 130.0),
                                        child: Text("All Residential",style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.grey1,
                                          fontSize: 13,
                                        ),),
                                      ),



                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("My Residential Units for Rent...(976...",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.navy,
                                      fontSize: 15,
                                    ),),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0,top: 20,),
                                        child: Container(
                                          height: 30,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                          ),

                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("ABU DHABI",style: TextStyle(
                                                fontSize: 13,
                                                color: MyColors.navy,
                                                fontWeight: FontWeight.w600,

                                              ),),
                                              Icon(Icons.location_on_outlined,size: 15,color: MyColors.mainorange,),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0,top: 20),
                                    child: Text("Saved on : December 21",style: TextStyle(
                                      fontSize: 12,
                                      color: MyColors.grey1,
                                      fontWeight: FontWeight.w400,

                                    ),),
                                  ),
                                ],
                              ),
                            ],

                          ),
                        ),
                        Container(
                          height: 210,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:Border.all(color: Color(0xffE0E0E0))
                          ),

                          child: Stack(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 90.0,left: 280),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        // Choose the width of the border

                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Image.asset(
                                        "assets/scootors.jpg",
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center, // Choose the alignment for the image within the container
                                      ),
                                    ),
                                  )
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: Text("property for Rent",style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.grey1,
                                          fontSize: 13,
                                        ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0,),
                                        child: Text(".",style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.grey1,
                                          fontSize: 40,
                                        ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 130.0),
                                        child: Text("All Residential",style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.grey1,
                                          fontSize: 13,
                                        ),),
                                      ),



                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("My Residential Units for Rent...(976...",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.navy,
                                      fontSize: 15,
                                    ),),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0,top: 20,),
                                        child: Container(
                                          height: 30,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                          ),

                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("ABU DHABI",style: TextStyle(
                                                fontSize: 13,
                                                color: MyColors.navy,
                                                fontWeight: FontWeight.w600,

                                              ),),
                                              Icon(Icons.location_on_outlined,size: 15,color: MyColors.mainorange,),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0,top: 20),
                                    child: Text("Saved on : December 21",style: TextStyle(
                                      fontSize: 12,
                                      color: MyColors.grey1,
                                      fontWeight: FontWeight.w400,

                                    ),),
                                  ),
                                ],
                              ),
                            ],

                          ),
                        ),





                      ],
                    ),
                  ):Container(),
                  b==1?
                  Column(
                    children: [
Lottie.asset("assets/share.json"),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0,top: 20),
                        child: Text("You have no saved searches yet in\nMotors",textAlign:TextAlign.center,style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: MyColors.navy,
                          fontSize: 15,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0,top: 20),
                        child: Text("Saving a search helps you find your item faster",textAlign:TextAlign.center,style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: MyColors.navy,
                          fontSize: 13,
                        ),),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(40.0),
                      //   child: Container(
                      //     height: 40,
                      //     width: 140,decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     border: Border.all(color: MyColors.grey1)
                      //   ),child: Center(
                      //     child: Text("Start Searching",style: TextStyle(
                      //       fontSize: 15,
                      //       color: MyColors.navy,
                      //       fontWeight: FontWeight.w500,
                      //     ),),
                      //   ),
                      //   ),
                      // )
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text("Start Searching",style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          color: MyColors.mainorange,
                          fontWeight: FontWeight.w800,
                        ),),
                      ),
                    ],
                  ):Container(),
                  c==1?
                  Column(
                    children: [
                      Lottie.asset("assets/share.json"),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0,top: 20),
                        child: Text("You have no saved searches yet in\nProperty For Rent",textAlign:TextAlign.center,style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: MyColors.navy,
                          fontSize: 15,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0,top: 20),
                        child: Text("Saving a search helps you find your item faster",textAlign:TextAlign.center,style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: MyColors.navy,
                          fontSize: 13,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text("Start Searching",style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          color: MyColors.mainorange,
                          fontWeight: FontWeight.w800,
                        ),),
                      ),
                    ],
                  ):Container(),
                  d==1?
                  Column(
                    children: [
                      Lottie.asset("assets/share.json"),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0,top: 20),
                        child: Text("You have no saved searches yet in\nProperty For Sale",textAlign:TextAlign.center,style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: MyColors.navy,
                          fontSize: 15,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0,top: 20),
                        child: Text("Saving a search helps you find your item faster",textAlign:TextAlign.center,style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: MyColors.navy,
                          fontSize: 13,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text("Start Searching",style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          color: MyColors.mainorange,
                          fontWeight: FontWeight.w800,
                        ),),
                      ),
                    ],
                  ):Container(),
                  e==1?
                  Column(
                    children: [
                      Lottie.asset("assets/share.json"),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0,top: 20),
                        child: Text("You have no saved searches yet in\nClassifieds",textAlign:TextAlign.center,style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: MyColors.navy,
                          fontSize: 15,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0,top: 20),
                        child: Text("Saving a search helps you find your item faster",textAlign:TextAlign.center,style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: MyColors.navy,
                          fontSize: 13,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text("Start Searching",style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          color: MyColors.mainorange,
                          fontWeight: FontWeight.w800,
                        ),),
                      ),
                    ],
                  ):Container(),
                  f==1?
                  Column(
                    children: [
                      Lottie.asset("assets/share.json"),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0,top: 20),
                        child: Text("You have no saved searches yet in\nJobs",textAlign:TextAlign.center,style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: MyColors.navy,
                          fontSize: 15,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0,top: 20),
                        child: Text("Saving a search helps you find your item faster",textAlign:TextAlign.center,style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: MyColors.navy,
                          fontSize: 13,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text("Start Searching",style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          color: MyColors.mainorange,
                          fontWeight: FontWeight.w800,
                        ),),
                      ),
                    ],
                  ):Container(),
                  g==1?Column(
                    children: [
                      Lottie.asset("assets/share.json"),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0,top: 20),
                        child: Text("You have no saved searches yet in\nCommunity",textAlign:TextAlign.center,style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: MyColors.navy,
                          fontSize: 15,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0,top: 20),
                        child: Text("Saving a search helps you find your item faster",textAlign:TextAlign.center,style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: MyColors.navy,
                          fontSize: 13,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text("Start Searching",style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          color: MyColors.mainorange,
                          fontWeight: FontWeight.w800,
                        ),),
                      ),
                    ],
                  ):Container(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

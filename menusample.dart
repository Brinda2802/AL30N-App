import 'dart:async';

import 'package:ai3on/chatssigninpage.dart';
import 'package:ai3on/company%20register%20signin%20page.dart';
import 'package:ai3on/main.dart';
import 'package:ai3on/screens/ChatScreen/ChatList.dart';
import 'package:ai3on/screens/MenuList/About.dart';
import 'package:ai3on/screens/MenuList/AddCompany.dart';
import 'package:ai3on/screens/MenuList/Contact.dart';
import 'package:ai3on/screens/MenuList/EditProfile.dart';
import 'package:ai3on/screens/MenuList/MyAds.dart';
import 'package:ai3on/screens/MenuList/MyAdsList.dart';
import 'package:ai3on/screens/MenuList/Support.dart';
import 'package:ai3on/screens/MenuList/TermsandConditions.dart';
import 'package:ai3on/screens/MenuList/WishList.dart';
import 'package:ai3on/screens/NewScreen/SigninScreen.dart';
import 'package:ai3on/screens/NewScreen/SignupScreen.dart';
import 'package:ai3on/screens/homescreens/Add.dart';
import 'package:ai3on/screens/homescreens/DealsPage.dart';
import 'package:ai3on/screens/homescreens/HomePage.dart';
import 'package:ai3on/screens/homescreens/Mainpage.dart';
import 'package:ai3on/screens/homescreens/NewClass.dart';
import 'package:ai3on/signingmyads.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../ApiUtils.dart';
import '../../MyColors.dart';
import '../../models/ProfileModel.dart';
import 'mysearchloginpage.dart';

class Menusample extends StatefulWidget {
  const Menusample({super.key});

  @override
  State<Menusample> createState() => _MenusampleState();
}

class _MenusampleState extends State<Menusample> {
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

  List<String> namess = ["All in Used Car for Sale","Abarth","Audi","BMW","Bugatti","Cadillac",
    "Dodge","Ferrari","Ford","GMC","Honda"];

  ApiUtils apiUtils = ApiUtils();


  bool isLoading = false;


  String mobile = "";
  String username = "";
  String useremail = "";
  String usertype = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();

  }

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: isLoading,
      blurEffectIntensity: 1,
      progressIndicator:LoadingAnimationWidget.halfTriangleDot(color: MyColors.navy, size: 100) ,
      dismissible: false,
      opacity: 0.1,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0.2,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                    child: Icon(Icons.arrow_back_ios,size: 15,color:MyColors.navy)),
                Padding(
                  padding: const EdgeInsets.only(right: 230.0),
                  child: Text("Profile",style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.bold),),
                ),
              ],
            ),
           ),
          // appBar: AppBar(
          //   flexibleSpace: Container(
          //     decoration:
          //     BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage('assets/images/footer.jpg'),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   backgroundColor: Colors.transparent,
          //   elevation: 2,
          //   centerTitle: true,
          //   title: Text("Profile"),
          //   actions: [
          //     // Image.asset("assets/images/brandlogo.png",height: 20,)
          //   ],
          // ),
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                 SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: isLoading ? const SizedBox(): Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!islogin) Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Please Login to Continue to Fetch Profile",style: TextStyle(color: MyColors.navy,fontSize: 14),),
                      )) else Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xffe8f6fd),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
                                child: Row(
                                  children: [
                                    Text("Profile",style: TextStyle(color: Color(0xfff06924),fontWeight: FontWeight.bold),),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfile()));
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          // border: Border.all(color: Color(0xfff06924),width: 1.5),
                                          // borderRadius: BorderRadius.circular(4),
                                          // color: Colors.white
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Edit",style: TextStyle(color: Color(0xfff06924),fontWeight: FontWeight.bold,fontSize: 15),),
                                            SizedBox(width: 5,),
                                            Icon(Icons.edit,color: Color(0xfff06924),size: 17,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,bottom: 20,top: 20,),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        // CircleAvatar(
                                        //   radius: 33,
                                        //   backgroundColor: Colors.transparent,
                                        //   backgroundImage: AssetImage("assets/images/logo.jpg"),
                                        // ),
                                        Center (
                                          child: Container(
                                            width: 100,
                                            height: 80,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage("assets/images/logo.jpg",),fit: BoxFit.fill
                                                )
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text("Joined in June 2023",style: TextStyle(color: MyColors.navy,fontSize: 10),)
                                      ],
                                    ),
                                    SizedBox(width: 20),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.account_circle_outlined,color: MyColors.navy,),
                                              SizedBox(width: 10,),
                                              Flexible(child: Text(username,overflow: TextOverflow.fade,style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.w600),))
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Icon(Icons.mail_outline,color: MyColors.navy,),
                                              SizedBox(width: 10),
                                              Flexible(
                                                child: Text(useremail,overflow: TextOverflow.fade,style: TextStyle(color: MyColors.navy,
                                                    fontSize: 11,fontWeight: FontWeight.w400),),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Icon(Icons.phone_android,color: MyColors.navy,),
                                              SizedBox(width: 10,),
                                              Text(mobile,style: TextStyle(color: MyColors.navy,fontSize: 14,fontWeight: FontWeight.w400),)
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 10),
                        child: Text("My Account",style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => signinmyads()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.add_circle,color: Color(0xfff06924),),
                              SizedBox(width: 10,),
                              Text("My Ads",style: TextStyle(color: MyColors.navy),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 15),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => WishList()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.favorite,color: Color(0xfff06924),),
                              SizedBox(width: 10,),
                              Text("Wish List",style: TextStyle(color: MyColors.navy),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 15),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>Mysearchsigninpage())
                            );
                          },
                          child: Row(
                            children: [
                              Icon(Icons.table_chart_outlined,color: Color(0xfff06924),),
                              SizedBox(width: 10,),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>Mysearchsigninpage())
                                    );
                                  },
                                  child: Text("My Searches",style: TextStyle(color: MyColors.navy),))
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 15,bottom: 10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatList()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.chat,color: Color(0xfff06924),),
                              SizedBox(width: 10,),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>chatsignin())
                                    );
                                  },
                                  child: Text("Chats",style: TextStyle(color: MyColors.navy),))
                            ],
                          ),
                        ),
                      ),
                      Divider(height: 2,thickness: 1.5,color: Color(0xffebf7fd),endIndent: 15,indent: 15,),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 10),
                        child: Text("settings"
                          ,style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 10),
                        child: GestureDetector(
                          onTap: (){
                            _showCustomPopup(context);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.location_city,color: Color(0xfff06924),),
                              SizedBox(width: 10,),
                              Text("City",style: TextStyle(color: MyColors.navy),)
                            ],

                        ),
                      ),),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 15),
                        child: GestureDetector(
                          onTap: (){
                            // _showCustomPopup0(context);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.edit_note_sharp,color: Color(0xfff06924),),
                              SizedBox(width: 10,),
                              Text( "عربي",style: TextStyle(color: MyColors.navy,fontSize: 15,fontWeight: FontWeight.w500),)
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top
                            :8.0),
                        child: Divider(height: 2,thickness: 1.5,color: Color(0xffebf7fd),endIndent: 15,indent: 15,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 10),
                        child: Text("Company"
                          ,style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => About()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.account_box_outlined,color: Color(0xfff06924),),
                              SizedBox(width: 10,),
                              Text("About Us",style: TextStyle(color: MyColors.navy),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 15),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.message_sharp,color: Color(0xfff06924),),
                              SizedBox(width: 10,),
                              Text("Contact Us",style: TextStyle(color: MyColors.navy),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 15),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Support()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.phone,color: Color(0xfff06924),),
                              SizedBox(width: 10,),
                              Text("Support",style: TextStyle(color: MyColors.navy),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 15),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => TermsandConditions()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.check_rounded,color: Color(0xfff06924),),
                              SizedBox(width: 10,),
                              Text("Terms & Conditions",style: TextStyle(color: MyColors.navy),)
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 15,top: 15),
                      //   child: Row(
                      //     children: [
                      //       Icon(Icons.message_sharp,color: Color(0xfff06924),),
                      //       SizedBox(width: 10,),
                      //       Text("Advertise With Us",style: TextStyle(color: MyColors.navy),)
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 15,bottom: 10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => companyregistersignin()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.check_box_rounded,color: Color(0xfff06924),),
                              SizedBox(width: 10,),
                              Text("Company Registration",style: TextStyle(color: MyColors.navy),)
                            ],
                          ),
                        ),
                      ),
                      Divider(height: 2,thickness: 1.5,color: Color(0xffebf7fd),endIndent: 15,indent: 15,),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 15,),
                        child: GestureDetector(
                          onTap: (){
                            if(islogin){
                              clear();
                            }else{
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) =>  SigninScreen()));
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.login_outlined,color: Color(0xfff06924),),
                              SizedBox(width: 10,),
                              Text(islogin ? "Logout":"Login",style: TextStyle(color: MyColors.navy),)
                            ],
                          ),
                        ),
                      ),
                    ],
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
      ),
    );
  }
  void _showCustomPopup0(BuildContext context) {
    String selectedLocation = 'Dubai';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.25, // Adjust the height as needed
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Column(
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Languages",
                      style: TextStyle(
                        color: MyColors.navy,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.cancel,size: 20,color: Colors.grey,),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Add your logic for "Oldest first"
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "English",
                      style: TextStyle(
                        color: MyColors.navy,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Add your logic for "Oldest first"
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              ),
              ListTile(
                leading: selectedLocation == "Abu Dhabi" ? Icon(Icons.check,color: MyColors.mainorange,) : null,
                title: Text(
                  "عربي",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Amiri",
                    color: MyColors.navy,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedLocation = "Abu Dhabi"; // Update the selected location
                  });
                  Navigator.pop(context);
                  // Add your logic for "Abu Dhabi"
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              ),

              //   padding: const EdgeInsets.only(left: 20.0,right: 20),
              //   child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              // ),


            ],
          ),
        );
      },
    );
  }
  void _showCustomPopup(BuildContext context) {
    String selectedLocation = 'Dubai';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.54, // Adjust the height as needed
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Column(
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select City",
                      style: TextStyle(
                        color: MyColors.navy,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.cancel,size: 20,color: Colors.grey,),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Add your logic for "Oldest first"
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              ),
              ListTile(
                leading: selectedLocation == "Abu Dhabi" ? Icon(Icons.check,color: MyColors.mainorange,) : null,
                title: Text(
                  "Abu Dhabi",
                  style: TextStyle(
                    fontSize: 15,
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedLocation = "Abu Dhabi"; // Update the selected location
                  });
                  Navigator.pop(context);
                  // Add your logic for "Abu Dhabi"
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              ),
              ListTile(
                title: Text(
                  "Sharjah",
                  style: TextStyle(
                    fontSize: 15,
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Add your logic for "Oldest first"
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              ),
              ListTile(
                title: Text(
                  "Ajman",
                  style: TextStyle(
                    fontSize: 15,
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Add your logic for "Oldest first"
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              ),
              ListTile(
                title: Text(
                  "Ras al Khaimah",
                  style: TextStyle(
                    fontSize: 15,
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Add your logic for "Oldest first"
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              ),
              ListTile(
                title: Text(
                  "Arabic",
                  style: TextStyle(
                    fontSize: 15,
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Add your logic for "Oldest first"
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              ),
              ListTile(
                title: Text(
                  "Dubai",
                  style: TextStyle(
                    fontSize: 15,
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Add your logic for "Oldest first"
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0,right: 20),
              //   child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              // ),


            ],
          ),
        );
      },
    );
  }
  Future<void> clear() async {
    SharedPreferences  preferences  = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>  Mainpage(),
            maintainState: true),
            (Route<dynamic> route) => false);
  }
}

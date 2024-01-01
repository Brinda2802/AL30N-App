import 'dart:async';

import 'package:ai3on/screens/NewScreen/SigninScreen.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ApiUtils.dart';
import '../../MyColors.dart';
import '../../models/ProfileModel.dart';

import '../MenuList/AddCompany.dart';
import '../MenuList/Contact.dart';
import '../MenuList/EditProfile.dart';
import '../MenuList/Support.dart';
import '../plans/PaymentPlan.dart';
import 'Mainpage.dart';

class Classifieds extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClassifiedsState();
  }
}

class _ClassifiedsState extends State<Classifieds> {

  ApiUtils apiUtils = ApiUtils();


  bool isLoading = false;

    bool islogin = false;
    String mobile = "";
    String username = "";
    String useremail = "";
    String usertype = "";

  get() async {
    var sharedpref  = await SharedPreferences.getInstance();
    setState(() {
      islogin = sharedpref.getBool("islogin")!;
      try{
        username =  sharedpref.getString("username")!;
        useremail =  sharedpref.getString("useremail")!;
        usertype =  sharedpref.getString("usertype")!;
        mobile =  sharedpref.getString("mobile")!;

      }catch(e){

      }
    });


  }
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
            backgroundColor: Colors.white,
            elevation: 1,
            title: Text("ProfileScreen",style: TextStyle(color: Colors.black),),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: isLoading ? const SizedBox(): Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               !islogin ?
               Center(child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text("Please Login to Continue to Fetch Profile"),
               )):
               Padding(
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
                                Container(
                                  height: 20,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xfff06924),width: 1.5),
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.white
                                  ),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfile()));
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Edit",style: TextStyle(color: Color(0xfff06924)),),
                                        SizedBox(width: 5,),
                                        Icon(Icons.edit,color: Color(0xfff06924),size: 15,)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,bottom: 20,top: 20,right: 15),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.account_circle_outlined,color: MyColors.navy,),
                                        SizedBox(width: 10,),
                                        Text(username,style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.w600),)
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.mail_outline,color: MyColors.navy,),
                                        SizedBox(width: 10),
                                        Text(useremail,maxLines: 2,style: TextStyle(color: MyColors.navy,
                                            fontSize: 11,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,)
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
                    child: Text("My Account",style: TextStyle(color: Color(0xffc4c4ca),fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10),
                    child: Row(
                      children: [
                        Icon(Icons.add_circle,color: Color(0xfff06924),),
                        SizedBox(width: 10,),
                        Text("My Ads",style: TextStyle(color: MyColors.navy),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 15),
                    child: Row(
                      children: [
                        Icon(Icons.favorite,color: Color(0xfff06924),),
                        SizedBox(width: 10,),
                        Text("Wish List",style: TextStyle(color: MyColors.navy),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 15),
                    child: Row(
                      children: [
                        Icon(Icons.table_chart_outlined,color: Color(0xfff06924),),
                        SizedBox(width: 10,),
                        Text("My Searches",style: TextStyle(color: MyColors.navy),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 15,bottom: 10),
                    child: Row(
                      children: [
                        Icon(Icons.chat,color: Color(0xfff06924),),
                        SizedBox(width: 10,),
                        Text("Chats",style: TextStyle(color: MyColors.navy),)
                      ],
                    ),
                  ),
                  Divider(height: 2,thickness: 1.5,color: Color(0xffebf7fd),endIndent: 15,indent: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10),
                    child: Text("Settings",style: TextStyle(color: Color(0xffc4c4ca ),fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentPlan()));

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
                    child: Row(
                      children: [
                        Icon(Icons.check_rounded,color: Color(0xfff06924),),
                        SizedBox(width: 10,),
                        Text("Terms & Conditions",style: TextStyle(color: MyColors.navy),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 15),
                    child: Row(
                      children: [
                        Icon(Icons.message_sharp,color: Color(0xfff06924),),
                        SizedBox(width: 10,),
                        Text("Advertise With Us",style: TextStyle(color: MyColors.navy),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 15,bottom: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCompany()));
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
          )
      ),
    );
    // return BlurryModalProgressHUD(
    //   inAsyncCall: isLoading,
    //   blurEffectIntensity: 1,
    //   progressIndicator:LoadingAnimationWidget.halfTriangleDot(color: MyColors.bule1, size: 100) ,
    //   dismissible: false,
    //   opacity: 0.1,
    //   child: Scaffold(
    //     body: SafeArea(
    //       child: SingleChildScrollView(
    //         physics: const BouncingScrollPhysics(),
    //         child: isLoading ? const SizedBox():Column(
    //           children: [
    //             Container(
    //               height: 230,
    //               width: double.infinity,
    //               color: const Color(0xfff7f8fa),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                  Center (
    //                   child: Container(
    //                     width: 150,
    //                     height: 120,
    //                     decoration: const BoxDecoration(
    //                       shape: BoxShape.circle,
    //                       image: DecorationImage(
    //                         image: AssetImage("assets/images/logo.jpg",),fit: BoxFit.fill
    //                       )
    //                     ),
    //                   ),
    //                 ),
    //                   const SizedBox(height: 15,),
    //                   // Text(myProfile.userId,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
    //                   // SizedBox(height: 10,),
    //                   Text("Member ID" +myProfile.userId,style: const TextStyle(color: Color(0xffb4b3bb),fontSize: 15,fontWeight: FontWeight.bold),),
    //                   Text(myProfile.userName!,style: const TextStyle(color: Color(0xffb4b3bb),fontSize: 15,fontWeight: FontWeight.bold),),
    //                   Text(myProfile.userEmail!,style: const TextStyle(color: Color(0xffb4b3bb),fontSize: 15,fontWeight: FontWeight.bold),),
    //                   Text(myProfile.phone!,style: const TextStyle(color: Color(0xffb4b3bb),fontSize: 15,fontWeight: FontWeight.bold),),
    //                   // Text("Member ID" +myProfile.userId,style: TextStyle(color: Color(0xffb4b3bb),fontSize: 15,fontWeight: FontWeight.bold),),
    //
    //                 ],
    //               ),
    //             ),
    //             const SizedBox(height: 5,),
    //             Image.asset("assets/images/barcodee.png",height: 80),
    //             // SizedBox(height: 10,),
    //             const Text("167431307561",style: TextStyle(fontWeight: FontWeight.bold),),
    //             const SizedBox(height: 10,),
    //             const Divider(height: 2,thickness: 1.5,),
    //             const Padding(
    //               padding: EdgeInsets.only(left: 20,top: 15,bottom: 12),
    //               child: Row(
    //                 children: [
    //                   Text("My Card",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
    //                   Spacer(),
    //                   Padding(
    //                     padding: EdgeInsets.only(right: 20),
    //                     child: Icon(Icons.arrow_forward_ios,size: 20,),
    //                   )
    //                 ],
    //               ),
    //             ),
    //             const Divider(height: 2,thickness: 1.5,),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 20,top: 15,bottom: 12),
    //               child: GestureDetector(
    //                 onTap: (){
    //                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfile()));
    //                 },
    //                 child: const Row(
    //                   children: [
    //                     Text("Edit Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
    //                     Spacer(),
    //                     Padding(
    //                       padding: EdgeInsets.only(right: 20),
    //                       child: Icon(Icons.arrow_forward_ios,size: 20,),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             const Divider(height: 2,thickness: 1.5,),
    //             const Padding(
    //               padding: EdgeInsets.only(left: 20,top: 15,bottom: 12),
    //               child: Row(
    //                 children: [
    //                   Text("My Listings",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
    //                   Spacer(),
    //                   Padding(
    //                     padding: EdgeInsets.only(right: 20),
    //                     child: Icon(Icons.arrow_forward_ios,size: 20,),
    //                   )
    //                 ],
    //               ),
    //             ),
    //             const Divider(height: 2,thickness: 1.5,),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 20,top: 15,bottom: 12),
    //               child: InkWell(
    //                 onTap: (){
    //                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Support()));
    //                 },
    //                 child: const Row(
    //                   children: [
    //                     Text("Support",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
    //                     Spacer(),
    //                     Padding(
    //                       padding: EdgeInsets.only(right: 20),
    //                       child: Icon(Icons.arrow_forward_ios,size: 20,),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             const Divider(height: 2,thickness: 1.5,),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 20,top: 15,bottom: 12),
    //               child: GestureDetector(
    //                 onTap: (){
    //                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact()));
    //                 },
    //                 child: const Row(
    //                   children: [
    //                     Text("Contact",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
    //                     Spacer(),
    //                     Padding(
    //                       padding: EdgeInsets.only(right: 20),
    //                       child: Icon(Icons.arrow_forward_ios,size: 20,),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             const Divider(height: 2,thickness: 1.5,),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 20,top: 15,bottom: 12),
    //               child: GestureDetector(
    //                 onTap: (){
    //                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCompany()));
    //                 },
    //                 child: const Row(
    //                   children: [
    //                     Text("Add Company",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
    //                     Spacer(),
    //                     Padding(
    //                       padding: EdgeInsets.only(right: 20),
    //                       child: Icon(Icons.arrow_forward_ios,size: 20,),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             const Divider(height: 2,thickness: 1.5,),
    //             const Padding(
    //               padding: EdgeInsets.only(left: 20,top: 15,bottom: 12),
    //               child: Row(
    //                 children: [
    //                   Text("Settings",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
    //                   Spacer(),
    //                   Padding(
    //                     padding: EdgeInsets.only(right: 20),
    //                     child: Icon(Icons.arrow_forward_ios,size: 20,),
    //                   )
    //                 ],
    //               ),
    //             ),
    //             const Divider(height: 2,thickness: 1.5,),
    //              Padding(
    //               padding: EdgeInsets.only(left: 20,top: 15,bottom: 12),
    //               child: GestureDetector(
    //                 onTap: (){
    //                 if(islogin){
    //
    //                 }else{
    //                   Navigator.of(context).pushReplacement(
    //                       MaterialPageRoute(builder: (context) =>  LoginPage()));
    //                 }
    //               },
    //                 child: Row(
    //                   children: [
    //                     Text(islogin ? "Logout":"Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
    //                     Spacer(),
    //                     Padding(
    //                       padding: EdgeInsets.only(right: 20),
    //                       child: Icon(Icons.arrow_forward_ios,size: 20,),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             const Divider(height: 2,thickness: 1.5,),
    //           ],
    //         ),
    //       ),
    //     )
    //   ),
    // );
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

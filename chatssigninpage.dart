import 'package:ai3on/screens/ChatScreen/ChatList.dart';
import 'package:ai3on/screens/NewScreen/SigninScreen.dart';
import 'package:ai3on/screens/NewScreen/SignupScreen.dart';
import 'package:ai3on/screens/homescreens/Add.dart';
import 'package:ai3on/screens/homescreens/DealsPage.dart';
import 'package:ai3on/screens/homescreens/HomePage.dart';
import 'package:ai3on/screens/homescreens/NewClass.dart';
import 'package:ai3on/shared%20preferences%20util.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'ApiUtils.dart';
import 'MyColors.dart';
import 'menusample.dart';
import 'models/LoginModel.dart';
import 'models/ProfileModel.dart';

class chatsignin extends StatefulWidget {
  const chatsignin({super.key});

  @override
  State<chatsignin> createState() => _chatsigninState();
}

class _chatsigninState extends State<chatsignin>
{
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
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  ApiUtils apiUtils = ApiUtils();
  bool _isPasswordVisible = false;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();


    checkLoggedInStatus().then((isLoggedIn) {
      if (isLoggedIn) {
        // User is already logged in, navigate to the respective page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>ChatList()),
        );
      }
    });
  }
  Widget build(BuildContext context) {
    return  BlurryModalProgressHUD(
      inAsyncCall: isLoading,
      blurEffectIntensity: 1,
      progressIndicator: LoadingAnimationWidget.threeArchedCircle(color: Colors.blue, size: 100),
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.cyan,
        //   elevation: 0,
        //   iconTheme: IconThemeData(
        //       color: Colors.white,
        //     size: 30
        //   ),
        // //   title: Text("RegisterPage"),
        // ),
        body: SafeArea(
         child: Stack(
           children: [
             Container(
               width: double.maxFinite,
               height: double.maxFinite,
               decoration: const BoxDecoration(
                 // color: Colors.cyan
                   image: DecorationImage(
                       image: AssetImage("assets/bg.jpeg",),fit: BoxFit.cover
                   )
               ),
               child: SingleChildScrollView(
                 physics: BouncingScrollPhysics(),
                 child: Form(
                   key: _formKey,
                   child: Column(
                     children: [
                       const Padding(padding: EdgeInsets.only(top: 120)),
                       Image.asset("assets/images/whitelogo.png",height: 150,),
                       Padding(
                         padding: const EdgeInsets.only(left: 25,right: 25,top: 15),
                         child: TextFormField(
                             controller: email,
                             style: TextStyle(color: MyColors.navy),
                             decoration: InputDecoration(
                               filled: true,
                               fillColor: Colors.white,
                               contentPadding: const EdgeInsets.only(left: 12,bottom: 12, top: 13),
                               border: InputBorder.none,
                               focusedBorder: OutlineInputBorder(
                                 borderSide: const BorderSide(color: Colors.white),
                                 borderRadius: BorderRadius.circular(12),
                               ),
                               enabledBorder: UnderlineInputBorder(
                                 borderSide: const BorderSide(color: Colors.white),
                                 borderRadius: BorderRadius.circular(12),
                               ),
                               prefixIcon: Icon(Icons.mail,color: Color(0xfff6c649),),
                               hintText: "E-mail",
                               hintStyle:  TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w400),
                               // label: Text("First Name",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),)
                             ),
                             validator: (value) {
                               if (value!.isEmpty) {
                                 return 'Enter your Email address';
                               }
                               if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)) {
                                 return 'Enter a Valid Email address';
                               }
                               return null;
                             }
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
                         child: TextFormField(
                           controller: password,
                           obscureText: !_isPasswordVisible, // Toggle visibility based on the flag
                           style: TextStyle(color: MyColors.navy),
                           decoration: InputDecoration(
                             filled: true,
                             fillColor: Colors.white,
                             contentPadding:
                             const EdgeInsets.only(left: 12, bottom: 12, top: 12),
                             border: InputBorder.none,
                             focusedBorder: OutlineInputBorder(
                               borderSide: const BorderSide(color: Colors.white),
                               borderRadius: BorderRadius.circular(12),
                             ),
                             enabledBorder: UnderlineInputBorder(
                               borderSide: const BorderSide(color: Colors.white),
                               borderRadius: BorderRadius.circular(12),
                             ),
                             prefixIcon: Icon(Icons.lock, color: Color(0xfff6c649)),
                             suffixIcon: IconButton(
                               icon: Icon(
                                 _isPasswordVisible
                                     ? Icons.visibility
                                     : Icons.visibility_off,
                                 color: Colors.grey,
                               ),
                               onPressed: () {
                                 setState(() {
                                   _isPasswordVisible = !_isPasswordVisible;
                                 });
                               },
                             ),
                             hintText: "Password",
                             hintStyle: TextStyle(
                                 color: MyColors.grey1, fontWeight: FontWeight.w400),
                           ),
                           validator: (value) {
                             if (value!.isEmpty) {
                               return 'Enter a valid password!';
                             }
                             return null;
                           },
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(right: 30,top: 10),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Text("Forgot Password?", style: TextStyle(
                                 decoration: TextDecoration.underline,color: Colors.white,fontWeight: FontWeight.w500,
                                 fontSize: 12
                             ),),
                           ],
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(left: 25,right: 25,top: 10),
                         child: GestureDetector(
                           onTap: (){
                             final isValid = _formKey.currentState!.validate();
                             if(!isValid){
                               return;
                             }else{
                               setState(() {
                                 isLoading = true;
                               });
                               apiUtils.login(email.text, password.text).then((value) {
                                 if(value.status == 0){
                                   setState(() {
                                     isLoading = false;
                                   });
                                   showTopSnackBar(context,
                                     CustomSnackBar.error(
                                       message:
                                       value.msg!,
                                     ),
                                   );
                                 }else{
                                   email.text = "";
                                   password.text = "";
                                   apiUtils.fetchProfile(value.userDetails!.userId!).then((value1){
                                     setState(() {
                                       isLoading = false;
                                       SaveSession(value.userDetails!,value1.myProfile!);
                                     });
                                   });
                                   showTopSnackBar(context,
                                     CustomSnackBar.success(
                                       message:
                                       value.msg!,
                                     ),
                                   );

                                 }
                                 print(value.status);
                               });
                             }
                             // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Mainpage()));
                           },
                           child: Container(
                             height: 45,
                             width: double.infinity,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Color(0xfff6c649)
                             ),
                             child: Align(alignment: Alignment.center,
                                 child: Text("Sign in",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),)),
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(right: 30,top: 10),
                         child: InkWell(
                           onTap: (){
                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen()));
                           },
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               Text("Create Account", style: TextStyle(
                                   decoration: TextDecoration.underline,color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12
                               ),),
                             ],
                           ),
                         ),
                       ),
                     ],
                   ),
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
      ),
    );
  }
  SaveSession(UserDetails userDetails, MyProfile myProfile ) async {
    SharedPreferences  preferences  = await SharedPreferences.getInstance();
    preferences.setBool("islogin", true);
    preferences.setString("user_id", userDetails.userId!);
    try{
      preferences.setString("username", myProfile.userName!);
      preferences.setString("useremail", myProfile.userEmail!);
      preferences.setString("usertype", myProfile.userType!);
      preferences.setString("mobile", myProfile.phone!);

    }catch(e){

    }

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>  ChatList(),
            maintainState: true),
            (Route<dynamic> route) => false);
  }
}

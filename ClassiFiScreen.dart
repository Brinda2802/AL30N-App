import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../ApiUtils.dart';
import '../../MyColors.dart';
import '../../menusample.dart';
import '../../models/ClassifiedsModel.dart';
import '../NewScreen/SigninScreen.dart';
import '../details/ClassifieeDetails.dart';
import 'Add.dart';
import 'DealsPage.dart';
import 'HomePage.dart';
import 'Mainpage.dart';
import 'NewClass.dart';

class ClassiFiScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ClassiFiScreenState();
  }
}
// Classifieds
class _ClassiFiScreenState extends State<ClassiFiScreen> with TickerProviderStateMixin{
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
  ApiUtils apiUtils = ApiUtils();

  List<ClassList> dealslist = [];

  bool isLoading = true;
  late FlutterGifController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = FlutterGifController(vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    apiUtils.getclassifields().then((value) {
      setState(() {
        dealslist = value.classList!;
        isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: isLoading,
      blurEffectIntensity: 1,
      progressIndicator:  GifImage(
        controller: controller,
        image: AssetImage("assets/images/loader.gif"),
      ) ,
      dismissible: false,
      opacity: 0.1,
      child: Scaffold(
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child: Text(
                          "Classifieds",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: MyColors.navy),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 20, right: 15, bottom: 15),
                        child: TextFormField(
                          style: TextStyle(color: MyColors.navy),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: MyColors.lightblue,
                              contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: "Search",
                              hintStyle: TextStyle(
                                  color: MyColors.blue,fontSize: 12),
                              // label: Text("Search",style: TextStyle(fontWeight: FontWeight.bold),),
                              suffixIcon: Icon(Icons.search, color: MyColors.blue,size: 22,)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          "Explore Classifieds",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: MyColors.navy),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                            itemCount: dealslist.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              String image = "";

                              try {
                                image = dealslist[index].image!.split(",")[0];
                              } catch (e) {
                                image = dealslist[index].image!;
                              }
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Card(
                                      elevation: 5,
                                      color: Color(0xfff8f8f8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: GestureDetector(
                                        onTap:(){
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context)=>ClassifieeDetails(dealslist[index].classId!)));


                                        },

                                        child: Column(
                                          children: [
                                            Container(
                                              height: 170,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(10)),
                                                image: DecorationImage(
                                                    image: NetworkImage(image),
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center ,
                                              children: [
                                                // Padding(
                                                //   padding: const EdgeInsets.only(left: 5.0,right: 5,bottom: 5),
                                                //   child: Container(
                                                //     height: 170,
                                                //     decoration: BoxDecoration(
                                                //         borderRadius: BorderRadius.only(
                                                //             topRight: Radius.circular(10),
                                                //             topLeft: Radius.circular(10)),
                                                //         image: DecorationImage(
                                                //             image: NetworkImage(
                                                //                 dealslist[index].image!),
                                                //             fit: BoxFit.cover)),
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5),
                                                  child: Text(
                                                    dealslist[index].title!,
                                                    style: TextStyle(
                                                        color: Color(0xff30618c),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18
                                                    ),
                                                  ),
                                                ),   Padding(
                                                  padding: const EdgeInsets.all(5),
                                                  child: Text(
                                                    dealslist[index].describe!,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13
                                                    ),
                                                  ),
                                                ),
                                                // SizedBox(height: 15,),
                                                Container(
                                                  height: 5,
                                                  width: double.infinity,
                                                  color: MyColors.yellow,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 5, right: 5, top: 5,bottom: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on_outlined,
                                                        size: 20,
                                                        color: MyColors.grey1,
                                                      ),
                                                      Text(
                                                        dealslist[index].city!.isNotEmpty
                                                            ? dealslist[index].city!
                                                            : "",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: MyColors.grey1),
                                                      ),
                                                      Spacer(),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(left:20,top:20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.white54,borderRadius: BorderRadius.circular(15)
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.check_circle_outline,color: MyColors.navy,size: 15,),
                                            SizedBox(width: 5,),
                                            Text("verifed user",style: TextStyle(fontSize: 14),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
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
}

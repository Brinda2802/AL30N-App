import 'package:ai3on/screens/details/ClassifiedPage/ClassifiedSubmen.dart';
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
import '../../models/GetMenuModel.dart';
import '../../models/MenuModel.dart';
import '../NewScreen/SigninScreen.dart';
import 'Add.dart';
import 'DealsPage.dart';
import 'HomePage.dart';

class NewClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewClassState();
  }
}

class _NewClassState extends State<NewClass> with TickerProviderStateMixin{
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
  late FlutterGifController controller;

  bool isLoading = true;
  List<SubMenu> menulist = [];
  List<Menu> productlist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // apiUtils.getAllClassifieldsMenu().then((value) {
    //   setState(() {
    //     isLoading = false;
    //     menulist = value.subMenu!;
    //   });
    // });
    controller = FlutterGifController(vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    controller.repeat(
      min: 0,
      max: 203,
      period: const Duration(milliseconds: 500),
    );
    apiUtils.getmenu().then((value){
      setState(() {
        productlist = value.menu!;
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
                       padding:  EdgeInsets.only(left: 10,right: 10,top: 10),
                       child: SizedBox(
                         height: 40,
                         child: TextFormField(
                           // controller: category,
                           style: TextStyle(color: MyColors.navy),
                           decoration: InputDecoration(
                               filled: true,
                               fillColor: MyColors.lightblue ,
                               contentPadding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(8),
                                 borderSide: const BorderSide(
                                   width: 0,
                                   style: BorderStyle.none,
                                 ),
                               ),
                               hintText: "Search",
                               hintStyle: TextStyle(fontSize: 12,color: MyColors.blue),
                               // label: Text("Search",style: TextStyle(fontWeight: FontWeight.bold),),
                               suffixIcon:  Icon(Icons.search,color: MyColors.blue,size: 22,)
                           ),
                           onTap: (){
                             // _showChoiceDialog(context);
                           },
                         ),
                       ),
                     ),
                     // Padding(
                     //   padding: const EdgeInsets.only(
                     //       left: 15, top: 20, right: 15, bottom: 15),
                     //   child: TextFormField(
                     //     decoration: InputDecoration(
                     //         filled: true,
                     //         fillColor: MyColors.lightblue,
                     //         contentPadding: EdgeInsets.fromLTRB(
                     //             20.0, 5.0, 20.0, 5.0),
                     //         border: OutlineInputBorder(
                     //           borderRadius: BorderRadius.circular(8),
                     //           borderSide: BorderSide(
                     //             width: 0,
                     //             style: BorderStyle.none,
                     //           ),
                     //         ),
                     //         hintText: "Search",
                     //         hintStyle: TextStyle(
                     //             color: Color(0xffc4c7cf),
                     //             fontWeight: FontWeight.bold),
                     //         // label: Text("Search",style: TextStyle(fontWeight: FontWeight.bold),),
                     //         suffixIcon: Icon(
                     //           Icons.search,
                     //           color: Color(0xffc4c7cf),
                     //           size: 30,
                     //         )),
                     //   ),
                     // ),
                     Padding(
                       padding: const EdgeInsets.only(left: 15, top: 15),
                       child: Text(
                         "Explore Classifieds",
                         style: TextStyle(color: MyColors.navy,fontSize: 15),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(15),
                       child: GridView.count(
                           crossAxisCount: 3,
                           childAspectRatio: (1/1),
                           crossAxisSpacing: 10,
                           mainAxisSpacing: 10,
                           shrinkWrap: true,
                           physics: const NeverScrollableScrollPhysics(),
                           children: List.generate(productlist.length, (index) {
                             return GestureDetector(
                               onTap: (){
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClassifiedSubmen(productlist[index].id)));
                               },
                               child: Card(
                                 elevation: 5,
                                 color: Color(0xfff8f8f8),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(12),
                                 ),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Image.network(productlist[index].image!,height: 45,width: 45,),
                                     SizedBox(height: 8,),
                                     Text(productlist[index].menu!,style: TextStyle(fontSize: 15,color: MyColors.navy),),
                                   ],
                                 ),
                               ),
                             );
                           })
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 15,),
                       child: Text(
                         "Advertisements",
                         style: TextStyle(color: MyColors.navy,fontSize: 15),
                       ),
                     ),
                     SingleChildScrollView(
                       scrollDirection: Axis.horizontal,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [

                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                                 height: 250,
                                 width: 300,
                                 child: Image.asset("assets/cars.jpg",fit: BoxFit.cover,)),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                                 height: 250,
                                 width: 300,
                                 child: Image.asset("assets/scootors.jpg",fit: BoxFit.cover,)),
                           ),
                         ],
                       ),
                     ),
                     // SizedBox(
                     //   width: double.infinity,
                     //   child: ListView.builder(
                     //     physics: NeverScrollableScrollPhysics(),
                     //     itemCount: menulist.length,
                     //     shrinkWrap: true,
                     //     itemBuilder: (BuildContext context, int index) {
                     //       return Column(
                     //         crossAxisAlignment: CrossAxisAlignment.start,
                     //         children: [
                     //           Padding(
                     //             padding: const EdgeInsets.all(15),
                     //             child: Row(
                     //               children: [
                     //                 Text(menulist[index].subMenu!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                     //                 Spacer(),
                     //                 Padding(
                     //                   padding: const EdgeInsets.only(right: 8.0),
                     //                   child: Icon(Icons.arrow_forward_ios,size: 20,),
                     //                 ),
                     //
                     //               ],
                     //             ),
                     //           ),
                     //           Divider(height: 2,thickness: 1.5,),
                     //         ],
                     //       );
                     //     },
                     //   ),
                     // ),
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
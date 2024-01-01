import 'package:ai3on/screens/details/ClassifiedPage/ClassifiedChildMenu.dart';
import 'package:ai3on/screens/details/ClassifiedPage/ClassifieldsRentPage.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../ApiUtils.dart';
import '../../../MyColors.dart';
import '../../../menusample.dart';
import '../../../models/GetMenuModel.dart';
import '../../NewScreen/SigninScreen.dart';
import '../../homescreens/Add.dart';
import '../../homescreens/DealsPage.dart';
import '../../homescreens/HomePage.dart';
import '../../homescreens/NewClass.dart';

class ClassifiedSubmen extends StatefulWidget {
  String? id = "";
  ClassifiedSubmen(this.id);

  @override
  State<StatefulWidget> createState() {
    return _ClassifiedSubmenState(id!);
  }
}

class _ClassifiedSubmenState extends State<ClassifiedSubmen> with TickerProviderStateMixin {
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

  bool isLoading = true;
  List<SubMenu> menulist = [];

  String id;
  _ClassifiedSubmenState(this.id);
  late FlutterGifController controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = FlutterGifController(vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    controller.repeat(
      min: 0,
      max: 203,
      period: const Duration(milliseconds: 500),
    );
    apiUtils.getAllClassifieldsMenu(id).then((value) {
      setState(() {
        isLoading = false;
        menulist = value.subMenu!;
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1.5,
            centerTitle: true,
            title: Text("Classifieds List",style: TextStyle(color: MyColors.navy),),
            iconTheme: IconThemeData(
                color: MyColors.navy
            ),
            actions: [
              // Image.asset("assets/images/brandlogo.png",height: 20,)
            ],
          ),
          body: SafeArea(
           child: Stack(
             fit: StackFit.expand,
             children: [
               SingleChildScrollView(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     SizedBox(
                       width: double.infinity,
                       child: ListView.builder(
                         physics: const NeverScrollableScrollPhysics(),
                         itemCount: menulist.length,
                         shrinkWrap: true,
                         itemBuilder: (BuildContext context, int index) {
                           return GestureDetector(

                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(1),
                                   child: OutlinedButton(
                                     onPressed:  (){
                                       if(id == "1" || id == "5") {
                                         Navigator.of(context).push(MaterialPageRoute(
                                             builder: (context) =>
                                                 ClassifiedChildMenu(
                                                   id, // Provide the value for mainid
                                                   menulist[index].id!,menulist[index].subMenu!,// Provide the value for id
                                                   // Provide the value for title
                                                 )));
                                       }else if(id == "4" ){
                                         Navigator.of(context).push(MaterialPageRoute(
                                             builder: (context) =>
                                                 ClassifieldsRentPage(menulist[index].id!,menulist[index].subMenu!,1)));
                                       }else if(id == "3"){
                                         Navigator.of(context).push(MaterialPageRoute(
                                             builder: (context) =>
                                                 ClassifieldsRentPage(menulist[index].id!,menulist[index].subMenu!,2)));
                                       }
                                     },
                                     style: OutlinedButton.styleFrom(
                                       side: BorderSide(color: Colors.white), // Change the color here
                                     ),

                                     child: Row(
                                       children: [
                                         Text(menulist[index].subMenu!,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: MyColors.navy),),
                                         Spacer(),
                                         Padding(
                                           padding: const EdgeInsets.only(right: 8.0),
                                           child: Icon(Icons.arrow_forward_ios,size: 15,color: MyColors.navy,),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ),
                                 Divider(height: 2,thickness: 1.5,color: Colors.grey[400],),
                               ],
                             ),
                           );
                         },
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           ),
          )),
    );
  }
}


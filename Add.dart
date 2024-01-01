import 'package:ai3on/screens/PostYourAd/AddSubMenu.dart';
import 'package:ai3on/screens/homescreens/Mainpage.dart';
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
import '../../models/MenuModel.dart';
import '../../models/SubMenuModel.dart';
import '../NewScreen/SigninScreen.dart';
import 'DealsPage.dart';
import 'HomePage.dart';
import 'NewClass.dart';

class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddState();
  }
}

class _AddState extends State<Add> with TickerProviderStateMixin{
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

  int selectedindex = 1;

  bool isLoading = true;

  ApiUtils apiUtils = ApiUtils();

  List<Menu> productlist = [];
  // List<SubMenu> submenulist = [];
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
    apiUtils.getmenu().then((value){
      setState(() {
        productlist = value.menu!;
        isLoading = false;
      });
    });
  }

  // getmenu(String id){
  //   apiUtils.submenu(id).then((value){
  //     setState(() {
  //       submenulist = value.subMenu!;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: isLoading,
      blurEffectIntensity: 1,
      progressIndicator:  GifImage(
        controller: controller,
        image: AssetImage("assets/images/loader.gif"),
      ) ,      dismissible: false,
      opacity: 0.1,
      child: Scaffold(
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
          title: Text("Post Your Ad"),
          actions: [
            // Image.asset("assets/images/brandlogo.png",height: 20,)
          ],
        ),
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
               SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: (1/1),
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(productlist.length, (index) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddSubMenu(productlist[index].id)));
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
                                    Image.network(productlist[index].image!,height: 55,width: 55,),
                                    SizedBox(height: 8,),
                                    Text(productlist[index].menu!,style: TextStyle(fontSize: 18,color: MyColors.navy,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                            );
                          })
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
}

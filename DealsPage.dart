import 'dart:convert';

import 'package:ai3on/screens/details/DealsDetailScreen.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../ApiUtils.dart';
import '../../MyColors.dart';
import '../../menusample.dart';
import '../../models/DealsModel.dart';
import '../NewScreen/SigninScreen.dart';
import 'Add.dart';
import 'HomePage.dart';
import 'NewClass.dart';

class DealsPage extends StatefulWidget {
  const DealsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DealsPageState();
  }
}

class _DealsPageState extends State<DealsPage> with TickerProviderStateMixin {
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

  List<Delas> dealslist = [];
  List filterSearchData = [];
  TextEditingController filterCtrl = TextEditingController();

  bool isLoading = true;
  late FlutterGifController controller;

  Future<void> filterSearch(val) async {
    var response = await http.post(
      Uri.parse("https://sanishsoft.co.in/demo/al3on/al3on.ae/deals_search"),
      body: {"key": val},
    );
    var responseBody = jsonDecode(response.body);
    List searchList = responseBody['search_data'] as List;
    print(responseBody);
    filterSearchData.clear();
    filterSearchData.addAll(searchList.map((data) {
      return data;
    }));

    // Filter dealslist based on the entered value
    if (val.isNotEmpty) {
      dealslist = dealslist.where((deal) {
        return deal.city!.toLowerCase().contains(val.toLowerCase());
      }).toList();
    }

    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = FlutterGifController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    controller.repeat(
      min: 0,
      max: 203,
      period: const Duration(milliseconds: 500),
    );
    apiUtils.getdeal().then((value) {
      setState(() {
        dealslist = value.delas!;
        isLoading = false;
      });
    });
  }

  // List<String> namess = ["All in Motors","Used Cars for Sale","Motorcycles","Heavy Vehicles","Boats","Auto Accessories & Parts","Number Plates"];

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: isLoading,
      blurEffectIntensity: 1,
      progressIndicator: GifImage(
        controller: controller,
        image: const AssetImage("assets/images/loader.gif"),
      ),
      dismissible: false,
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
            title: Text("Deals",style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
            actions: [
              // Image.asset("assets/images/brandlogo.png",height: 20,)
            ],
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
          body:
          SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 15, top: 20),
                      //   child: Text(
                      //     "Deals",
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 18,
                      //         color: MyColors.navy),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 20, right: 15, bottom: 15),
                        child: SizedBox(
                          height:40 ,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Center(
                              child: TextFormField(
                                controller: filterCtrl,
                                onChanged: (value) async {
                                  await filterSearch(value);
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: MyColors.lightblue,
                                  contentPadding:
                                  const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  hintText: "Search offer,company name,city...",
                                  hintStyle: TextStyle(
                                      color: MyColors.navy, fontWeight: FontWeight.w400,fontSize: 14),
                                  // label: Text("Search",style: TextStyle(fontWeight: FontWeight.bold),),

                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
                      //   child: Container(
                      //     width: double.infinity,
                      //     height: 40,
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         color: MyColors.lightblue),
                      //     child: const Align(
                      //       alignment: Alignment.center,
                      //       child: Text("Search offer,company name,city..."),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.lightblue),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text("Sort by"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          "Explore Deals",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: MyColors.navy),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: (2 / 2.4),
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 8,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(dealslist.length, (index) {
                              return Card(
                                elevation: 5,
                                color: const Color(0xfff8f8f8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    if (kDebugMode) {
                                      print(dealslist[index].id!);
                                    }
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            DealsDetailScreen(dealslist[index].id!)));
                                  },
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 105,
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                topLeft: Radius.circular(10)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    dealslist[index].image!),
                                                fit: BoxFit.fill)),
                                      ),
                                      // SizedBox(
                                      //   height: 12,
                                      // ),
                                      Container(
                                          height: 25,
                                          width: double.infinity,
                                          decoration:
                                          BoxDecoration(color: MyColors.darkblue),
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                dealslist[index].title!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: MyColors.navy,
                                                    fontSize: 14),
                                                overflow: TextOverflow.ellipsis,
                                              ))),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(left: 10),
                                      //   child: Text(
                                      //     dealslist[index].title!,
                                      //     style: TextStyle(
                                      //         color: Color(0xff30618c),
                                      //         fontWeight: FontWeight.bold),
                                      //   ),
                                      // ),
                                      // SizedBox(height: 15,),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 7, top: 5, bottom: 6),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              size: 15,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              dealslist[index].city!.isNotEmpty
                                                  ? dealslist[index].city!
                                                  : "",
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            // Spacer(),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8,
                                        ),
                                        child: Container(
                                            height: 1.5,
                                            width: 160,
                                            color: MyColors.yellow),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 7, right: 7),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Discount",
                                              style: TextStyle(
                                                  color: Color(0xffff6347),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(dealslist[index].discount!,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(
                                                      0xffff6347,
                                                    ))),
                                            const Text(" %",
                                                style: TextStyle(
                                                    color: Color(0xffff6347),
                                                    fontWeight: FontWeight.bold)),
                                            const Spacer(),
                                            FavoriteButton(
                                              iconSize: 30,
                                              isFavorite: true,
                                              // iconDisabledColor: Colors.white,
                                              valueChanged: (isFavorite) {},
                                            ),
                                            // Icon(Icons.favorite,color: MyColors.mainorange,size: 20,),
                                            // SizedBox(
                                            //   width: 10,
                                            // ),
                                            // Text("OFF",
                                            //     style:
                                            //         TextStyle(color: Color(0xffff6347)))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

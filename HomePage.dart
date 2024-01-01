import 'package:ai3on/models/CategoryModel.dart';
import 'package:ai3on/models/CitiesModel.dart' as kk;
import 'package:ai3on/models/ClassifiedsModel.dart';
import 'package:ai3on/models/SaleListModel.dart' as aa;
import 'package:ai3on/notifications%20page.dart';
import 'package:ai3on/screens/ChatScreen/ChatList.dart';
import 'package:ai3on/screens/ListScreens/MotorPage.dart';
import 'package:ai3on/screens/ListScreens/RentPage.dart';
import 'package:ai3on/screens/ListScreens/SalePage.dart';
import 'package:ai3on/screens/MenuList/WishList.dart';
import 'package:ai3on/screens/MyCard.dart';
import 'package:ai3on/screens/ViewAllScreen/MotorViewPage.dart';
import 'package:ai3on/screens/ViewAllScreen/SaleandRentViewPage.dart';
import 'package:ai3on/screens/details/ClassifieeDetails.dart';
import 'package:ai3on/screens/details/RentDetails.dart';
import 'package:ai3on/screens/homescreens/ClassiFiScreen.dart';
import 'package:ai3on/screens/homescreens/DealsPage.dart';
import 'package:ai3on/screens/homescreens/SearchPage.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../ApiUtils.dart';
import '../../MyColors.dart';
import '../../menusample.dart';
import '../../models/HomePageModel.dart';
import '../../models/MenuModel.dart';
import '../../models/SearchModel.dart';
import '../../models/SubMenuModel.dart';
import '../NewScreen/SigninScreen.dart';
import '../details/DealsDetailScreen.dart';
import '../details/MotorDetails.dart';
import '../details/SalesDetails.dart';
import 'Add.dart';
import 'NewClass.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
  String formatPrice(String originalPrice) {
    String priceValue = originalPrice.replaceAll(RegExp(r'[^0-9]'), '');
    int priceNumber = int.tryParse(priceValue) ?? 0;
    String formattedPrice = priceNumber.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
    );
    return formattedPrice;
  }


  int selectedindex = 1;
  TextEditingController search = TextEditingController();
  late String mycities;

  ApiUtils apiUtils = ApiUtils();
  late FlutterGifController controller;

  List<Menu> productlist = [];
  List<SubMenu> submenulist = [];
  List<kk.Cites> citylist = [];
  List<Categorys> categorylist = [];
  List<RentsList> renttList = [];
  List<SaleList> salessList = [];
  List<MotorsList> motorlist = [];
  List<Delas> dealslist = [];
  List<Banners> banners = [];
  List<ClassList> classList = [];
  List<SearchData> searchData = [];


  bool isLoading = true;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  String username = "";



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
    // search.addListener(() {
    //   String text = search.text;
    //   _searchResult.clear();
    //   if (text.isEmpty) {
    //     setState(() {});
    //     return;
    //   }
    //
    //   _userDetails.forEach((userDetail) {
    //     if (userDetail.firstName.contains(text) || userDetail.lastName.contains(text))
    //       _searchResult.add(userDetail);
    //   });
    //
    //   setState(() {});
    // });

    get();
    apiUtils.getmenu().then((value){
      setState(() {
        productlist = value.menu!;
      });
    });

    apiUtils.getcity().then((value) {
      setState(() {
        citylist = value.cites!;
      });
    });

    apiUtils.getcategory().then((value) {
      setState(() {
        categorylist = value.categorys!;
      });
    });
    getHome("");
  }
  void getHome(String id) {
    print(id);
    setState(() {
      isLoading = true;
    });

    apiUtils.gethomelist(id).then((value) {
      setState(() {
        renttList = value.rent!.rentsList!;
        salessList = value.sales!.saleList!;
        motorlist = value.motors!.motorsList!;
        dealslist = value.dealsData!.delas!;
        banners = value.banners!;
      });

      return apiUtils.getclassifields();
    }).then((value) {
      setState(() {
        classList = value.classList!;
      });

      return apiUtils.getSearchData();
    }).then((value) {
      setState(() {
        searchData = value.searchData!;
        isLoading = false; // Set isLoading to false after all data retrieval
      });
    }).catchError((error) {
      // Handle errors if needed
      print('Error: $error');
      setState(() {
        isLoading = false; // Ensure isLoading is set to false in case of an error
      });
    });
  }


//  getmenu(String id){
//   apiUtils.submenu(id).then((value){
//     setState(() {
//       submenulist = value.subMenu!;
//     });
//   });
// }

//  getmenu(String id){
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
      blurEffectIntensity: 0,
      progressIndicator: Container(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white70.withOpacity(0.8), // Adjust the opacity as needed
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Change the color as needed
            ),
          ],
        ),
      ),
      dismissible: false,
      opacity: 0.1,
      child: Scaffold(
          backgroundColor: const Color(0xfff7f8fa),
         appBar: AppBar(
           automaticallyImplyLeading: false,

            elevation: 0,
            backgroundColor: Colors.white,
            toolbarHeight: 70,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: MyColors.navy),
                    ),
                    SizedBox(width: 5),
                    Text(
                      username.isEmpty ? "" : username,
                      style: TextStyle(fontSize: 17, color: MyColors.navy),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, color: MyColors.mainorange, size: 16),
                      SizedBox(width: 2),
                      Text("Dubai", style: TextStyle(color: MyColors.mainorange, fontSize: 12)),
                      // Other location-related widgets...
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => WishList()));
                },
                child: Icon(Icons.favorite, color: MyColors.mainorange, size: 25),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Notifications()));
                },
                child: Icon(Icons.notifications_active, color: MyColors.mainorange, size: 25),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatList()));
                },
                child: Icon(Icons.chat, color: MyColors.mainorange, size: 25),
              ),
              SizedBox(width: 5),
            ],
          ),

          // appBar: AppBar(
          //   title: Text("Home"),
          // ),
          body: SafeArea(
           child: Stack(
             fit: StackFit.expand,
             children: [
             SingleChildScrollView(
                 physics: const BouncingScrollPhysics(),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     GestureDetector(
                       onTap: (){
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyCard()));
                       },
                       child: Container(
                         height: 30,
                         width: double.infinity,
                         decoration: BoxDecoration(
                           image: DecorationImage(image: AssetImage('assets/images/dcbg.jpg'), fit: BoxFit.fitWidth),
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(Icons.credit_card,color: Color(0xfffeedac),size: 20,),
                             SizedBox(width: 5,),
                             Text("DIGITAL CARD",style: TextStyle(color: MyColors.navy,fontSize: 12,fontWeight: FontWeight.bold),)
                           ],
                         ),
                       ),
                     ),
                     SizedBox(height: 5,),
                     Padding(
                       padding:  EdgeInsets.only(left: 10,right: 10,top: 10),
                       child: SizedBox(
                         height: 40,
                         child: TextFormField(
                           controller: search,
                           readOnly: true,
                           style: TextStyle(color: MyColors.navy),
                           onTap: (){
                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage()));

                           },
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
                           // onTap: (){
                           //   _showChoiceDialog(context);
                           // },
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 5.0,top: 5,right: 5),
                       child: SizedBox(
                         width: double.infinity,
                         height: 200,
                         child: CarouselSlider(
                           items: banners
                               .map((item) => Container(
                             child: Container(
                               margin: EdgeInsets.all(5.0),
                               child: ClipRRect(
                                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                   child: Stack(
                                     children: <Widget>[
                                       Image.network(item.image!, fit: BoxFit.cover, width: 1000.0),
                                       Positioned(
                                         bottom: 0.0,
                                         left: 0.0,
                                         right: 0.0,
                                         child: Container(
                                           decoration: BoxDecoration(
                                             gradient: LinearGradient(
                                               colors: [
                                                 Color.fromARGB(200, 0, 0, 0),
                                                 Color.fromARGB(0, 0, 0, 0)
                                               ],
                                               begin: Alignment.bottomCenter,
                                               end: Alignment.topCenter,
                                             ),
                                           ),

                                         ),
                                       ),
                                     ],
                                   )),
                             ),
                           ))
                               .toList(),
                           carouselController: _controller,
                           options: CarouselOptions(
                               autoPlay: true,
                               enlargeCenterPage: false,
                               // aspectRatio: 1,
                               viewportFraction: 1,
                               onPageChanged: (index, reason) {
                                 setState(() {
                                   _current = index;
                                 });
                               }),
                         ),
                       ),
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: banners.asMap().entries.map((entry) {
                         return GestureDetector(
                           onTap: () => _controller.animateToPage(entry.key),
                           child: Container(
                             width: 5.0,
                             height: 5.0,
                             margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                             decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: (Theme.of(context).brightness == Brightness.dark
                                     ? Colors.white
                                     : Colors.grey.shade500)
                                     .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                           ),
                         );
                       }).toList(),
                     ),
                     Row(
                       children: [
                         Padding(
                           padding: EdgeInsets.only(left: 15,top: 15),
                           child: Text("Nearby Deals",style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.bold,fontSize: 15,),),
                         ),
                         Spacer(),
                         Padding(
                           padding: EdgeInsets.only(top: 15,right: 15),
                           child: InkWell(
                               onTap: (){
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => DealsPage()));
                               },
                               child: Container(
                                   width: 60,
                                   height: 22,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5),
                                       color: MyColors.navy
                                   ),
                                   child: Align(alignment: Alignment.center,
                                       child: Text("View all",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 11),)))),
                         ),
                       ],
                     ),
                     SizedBox(
                       width: double.infinity,
                       height: 180,
                       child: ListView.builder(
                         itemCount: dealslist.length,
                         shrinkWrap: true,
                         scrollDirection: Axis.horizontal,
                         itemBuilder: (BuildContext context, int index) {
                           return GestureDetector(
                             onTap: (){
                               print(dealslist[index].id!);
                               Navigator.of(context).push(MaterialPageRoute(
                                   builder: (context) =>
                                       DealsDetailScreen(dealslist[index].id!)));
                             },
                             child: Padding(
                               padding: EdgeInsets.only(left: 5,top: 8),
                               child: SizedBox(
                                 width: 115,
                                 child: Card(
                                   elevation: 3,
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(15),
                                     side: BorderSide(
                                         color: Colors.grey.shade300,
                                         width: 1.3
                                     ),
                                   ),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Container(
                                         height: 80,
                                         // width: 160,
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                                           // image: DecorationImage(image: NetworkImage(dealslist[index].image!),fit: BoxFit.fill),
                                         ),
                                         child: Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: Image.network(dealslist[index].image!),
                                         ),
                                       ),
                                       Padding(
                                         padding:  EdgeInsets.all(5),
                                         child: Row(
                                           mainAxisSize: MainAxisSize.min,
                                           children: [
                                             Icon(Icons.location_on_outlined,size: 15,color: Colors.grey,),
                                             Text(dealslist[index].city!,style: TextStyle(fontSize: 10,color: Colors.grey,fontWeight: FontWeight.w500),),
                                             // Spacer(),
                                             // Text(dealslist[index].discount! + "% Off",style:  TextStyle(fontSize: 14,color: MyColors.mainorange,fontWeight: FontWeight.bold),),
                                           ],
                                         ),
                                       ),

                                       Container(
                                         height: 3,
                                         width: 160,
                                         color: MyColors.yellow,
                                       ),
                                       // Divider(height: 2,thickness: 3,color: MyColors.mainorange,),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 5.0,top: 5),
                                         child: Text(dealslist[index].title!,style:  TextStyle(color: MyColors.navy,fontSize: 13,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                                       ),
                                       Align(alignment: Alignment.centerRight,child:
                                       Padding(
                                         padding: const EdgeInsets.only(right: 12,top: 2),
                                         child: Text(dealslist[index].discount! + "%",style:  TextStyle(fontSize: 11,color: MyColors.mainorange,fontWeight: FontWeight.bold),),
                                       )),
                                       Align(alignment: Alignment.centerRight,
                                         child: Padding(
                                           padding: const EdgeInsets.only(right: 12),
                                           child: Text("Off".toUpperCase(),style:  TextStyle(fontSize: 11,color: MyColors.mainorange,fontWeight: FontWeight.bold)),
                                         ),
                                       )


                                       // Padding(
                                       //   padding: const EdgeInsets.only(left: 5),
                                       //   child: Row(
                                       //     children: [
                                       //       Image.asset("assets/images/cardd.png",height: 15,width: 15,),
                                       //       const SizedBox(width: 5,),
                                       //       Text(renttList[index].price!,style: const TextStyle(fontSize: 12,color: Colors.black38,fontWeight: FontWeight.bold),),
                                       //       const SizedBox(width: 10,),
                                       //       Image.asset("assets/images/bath.png",height: 15,width: 15,),
                                       //       const SizedBox(width: 5,),
                                       //       Text(renttList[index].bathroom!,style: const TextStyle(fontSize: 12,color: Colors.black38,fontWeight: FontWeight.bold),),
                                       //       // SizedBox(width: 4,),
                                       //       // Text("Bathroom",style: TextStyle(color: Colors.black54),),
                                       //       const SizedBox(width: 5,),
                                       //       Image.asset("assets/images/loca.png",height: 15,width: 15,),
                                       //       Text(renttList[index].city!,style: const TextStyle(fontSize: 11,color: Colors.black38,fontWeight: FontWeight.bold),)
                                       //     ],
                                       //   ),
                                       // ),
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                           );
                         },
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 15,right: 15,top: 10,),
                       child: Row(
                         children: [
                           Text("Suggested Classifieds",style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.bold,fontSize: 15,),),
                           Spacer(),
                           InkWell(
                               onTap: (){
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClassiFiScreen()));
                               },
                               child: Container(
                                   width: 60,
                                   height: 22,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5),
                                       color: MyColors.navy
                                   ),
                                   child: Align(alignment: Alignment.center,
                                       child: Text("View all",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 11),)))),
                         ],
                       ),
                     ),
                     SizedBox(
                       width: double.infinity,height: 220,
                       child: ListView.builder(
                         itemCount: classList.length,
                         shrinkWrap: true,
                         scrollDirection: Axis.horizontal,
                         itemBuilder: (BuildContext context, int index) {
                           return GestureDetector(
                             onTap: (){
                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClassifieeDetails(classList[index].classId!)));
                             },
                             child: Padding(
                               padding: EdgeInsets.only(left: 10,top: 8),
                               child: Card(
                                 elevation: 3,
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Container(
                                       height: 120,
                                       width: 200,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                                         image: DecorationImage(image: NetworkImage(classList[index].image!),fit: BoxFit.fill),
                                       ),
                                     ),
                                     const SizedBox(height: 8,),
                                     Padding(
                                       padding: EdgeInsets.only(left: 5),
                                       child: Text(classList[index].title!,style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.bold,fontSize: 14),),
                                     ),
                                     const SizedBox(height: 8,),
                                     Padding(
                                       padding: EdgeInsets.only(left: 5),
                                       child: Row(
                                         children: [
                                           Image.asset("assets/images/cardd.png",height: 15,width: 15,color: Color(0xffe37640),),
                                           const SizedBox(width: 5,),
                                           Text(
                                             classList[index].formatPrice(classList[index].price ?? ''),
                                             style: const TextStyle(
                                               fontSize: 14,
                                               color: Color(0xffe37640),
                                               fontWeight: FontWeight.bold,
                                             ),
                                           ),


                                           // Text(classList[index].price!,style: const TextStyle(fontSize: 14,color: Color(0xffe37640),fontWeight: FontWeight.bold),),                                        ],
                                         ],),
                                     ),
                                     SizedBox(height: 8,),
                                     // Padding(
                                     //   padding:  EdgeInsets.only(left: 5),
                                     //   child: Row(
                                     //     children: [
                                     //       Image.asset("assets/images/bath.png",height: 15,width: 15,),
                                     //       SizedBox(width: 5,),
                                     //       Text(classList[index].bathroom!,style:  TextStyle(fontSize: 14,color: MyColors.grey1,fontWeight: FontWeight.bold),),                      ],
                                     //   ),
                                     // ),
                                     // SizedBox(height: 10,),
                                     Padding(
                                       padding: EdgeInsets.only(left: 5),
                                       child: Row(
                                           children: [
                                             Icon(Icons.location_on_outlined,size: 15,color: MyColors.grey1),
                                             SizedBox(width: 5,),
                                             Text(classList[index].city!,style: TextStyle(fontSize: 12,color: Colors.grey,fontWeight: FontWeight.w500),)
                                           ]
                                         // Text(classList[index].city!,style:  TextStyle(fontSize: 14,color: MyColors.grey1,fontWeight: FontWeight.bold),)                        ],
                                       ),
                                     ),

                                   ],
                                 ),
                               ),
                             ),
                           );
                         },
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.only(left: 15,top: 15),
                       child: Text("Explore by Cities",style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.bold,fontSize: 15),),
                     ),
                     const SizedBox(width: 10),
                     SizedBox(
                       width: double.infinity,
                       height: 115,
                       child: ListView.builder(
                         itemCount: citylist.length,
                         shrinkWrap: true,
                         scrollDirection: Axis.horizontal,
                         itemBuilder: (BuildContext context, int index) {
                           return Row(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: GestureDetector(
                                   onTap:(){
                                     getHome(citylist[index].id!);
                                   },
                                   child: Column(
                                     children: [
                                       CircleAvatar(
                                         backgroundColor: Colors.transparent,
                                         radius: 35,
                                         backgroundImage: NetworkImage(citylist[index].image!),
                                       ),
                                       SizedBox(height: 10,),
                                       Text(citylist[index].cityName!,style: TextStyle(color: MyColors.grey1,fontSize: 11,fontWeight: FontWeight.w500),)
                                     ],
                                   ),
                                 ),
                               )
                             ],
                           );
                         },
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 15,right: 15,),
                       child: Row(
                         children: [
                           Text("Property for Rent",style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.bold,fontSize: 15),),
                           const Spacer(),
                           InkWell(
                             onTap: (){
                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => SaleandRentViewPage("rent","")));
                             },
                             child: Container(
                                 width: 60,
                                 height: 22,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(5),
                                     color: MyColors.navy
                                 ),
                                 child: Align(alignment: Alignment.center,
                                     child: Text("View all",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 11),))),
                           ),
                         ],
                       ),
                     ),
                     SizedBox(
                       width: double.infinity,
                       height: 200,
                       child: ListView.builder(
                         itemCount: renttList.length,
                         shrinkWrap: true,
                         scrollDirection: Axis.horizontal,
                         itemBuilder: (BuildContext context, int index) {
                           return GestureDetector(
                             onTap: (){
                               Navigator.of(context).push(MaterialPageRoute(builder: (context) =>RentDetailss(renttList[index].rentId!)));
                             },
                             child: Row(
                               children: [
                                 Padding(
                                   padding: EdgeInsets.only(left: 12,top: 12),
                                   child: SizedBox(
                                     width: 200,
                                     // width: 225,
                                     child: Container(
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(15),
                                         // color: Colors.black12,
                                       ),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Container(
                                             height: 130,
                                             // width: 250,
                                             decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(8),
                                               image: DecorationImage(image: NetworkImage(renttList[index].image!),fit: BoxFit.fill),
                                             ),
                                           ),
                                           // const SizedBox(height: 8,),
                                           Padding(
                                             padding: EdgeInsets.only(left: 5,top: 5),
                                             child: Text(renttList[index].price!,style: const TextStyle(color: Color(0xffe37640),fontWeight: FontWeight.bold,fontSize: 16),),
                                           ),
                                           Padding(
                                             padding: const EdgeInsets.only(left: 5,top: 3),
                                             child: Row(
                                               children: [
                                                 Image.asset("assets/images/bed.png",height: 12,color: MyColors.grey1,),
                                                 const SizedBox(width: 5,),
                                                 Text(renttList[index].room!,style: TextStyle(fontSize: 12,color: MyColors.grey1,),),
                                                 const SizedBox(width: 3,),
                                                 Text("Studio",style: TextStyle(fontSize: 12,color: MyColors.grey1,),),
                                                 const SizedBox(width: 5,),
                                                 Image.asset("assets/images/bath.png",height: 12,color: MyColors.grey1,),
                                                 const SizedBox(width: 5,),
                                                 Text(
                                                   renttList[index].bathroom != null
                                                       ? renttList[index].bathroom!
                                                       : 'N/A', // Providing a default value if bathroom is null
                                                   style: TextStyle(
                                                     fontSize: 12,
                                                     color: MyColors.grey1,
                                                   ),
                                                 ),

                                                 SizedBox(width: 3,),
                                                 Text("Bath",style: TextStyle(color: MyColors.grey1,fontSize: 12),),
                                                 const SizedBox(width: 5,),
                                                 Image.asset("assets/images/loca.png",height: 12,color: MyColors.grey1,),
                                                 Flexible(
                                                   flex: 2,
                                                   child: Text(renttList[index].city!,style: TextStyle(color: MyColors.grey1,fontSize: 12),
                                                     maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                 )
                                               ],
                                             ),
                                           ),
                                           // const SizedBox(height: 10,),
                                           // Padding(
                                           //   padding: EdgeInsets.only(left: 5),
                                           //   child: Row(
                                           //     children: [
                                           //       Image.asset("assets/images/cardd.png",height: 15,width: 15,),
                                           //       const SizedBox(width: 5,),
                                           //       Text(renttList[index].price!,style: const TextStyle(fontSize: 14,color: Colors.black38,fontWeight: FontWeight.bold),),                                        ],
                                           //   ),
                                           // ),
                                           // SizedBox(height: 10,),
                                           // Padding(
                                           //   padding:  EdgeInsets.only(left: 5),
                                           //   child: Row(
                                           //     children: [
                                           //       Image.asset("assets/images/bath.png",height: 15,width: 15,),
                                           //        SizedBox(width: 5,),
                                           //       Text(renttList[index].bathroom!,style:  TextStyle(fontSize: 14,color: MyColors.grey1,fontWeight: FontWeight.bold),),                      ],
                                           //   ),
                                           // ),
                                           // SizedBox(height: 10,),
                                           // Padding(
                                           //   padding: EdgeInsets.only(left: 5),
                                           //   child: Row(
                                           //     children: [
                                           //       Icon(Icons.location_on_outlined,size: 15,),
                                           //       SizedBox(width: 5,),
                                           //       Text(renttList[index].city!,style:  TextStyle(fontSize: 14,color: MyColors.grey1,fontWeight: FontWeight.bold),)                        ],
                                           //   ),
                                           // ),
                                           //       Text(renttList[index].price!,style: const TextStyle(fontSize: 14,color: Colors.black38,fontWeight: FontWeight.bold),),                                        ],

                                         ],
                                       ),
                                     ),
                                   ),
                                 )
                               ],
                             ),
                           );
                         },
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
                       child: Row(
                         children: [
                           Text("Property for Sale",style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.bold,fontSize: 15,),),
                           const Spacer(),
                           InkWell(
                               onTap: (){
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) =>SaleandRentViewPage("sale","")));
                               },
                               child: Container(
                                   width: 60,
                                   height: 22,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5),
                                       color: MyColors.navy
                                   ),
                                   child: Align(alignment: Alignment.center,
                                       child: Text("View all",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 11),)))),
                           // const SizedBox(width: 5,),
                           // Padding(
                           //   padding: const EdgeInsets.only(right: 15,top: 15),
                           //   child: InkWell(
                           //       onTap: (){
                           //         Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ProductPage("sale")));
                           //       },
                           //       child: const Icon(Icons.arrow_forward,size: 15,)),
                           // )
                         ],
                       ),
                     ),
                     SizedBox(
                       width: double.infinity,
                       height: 200,
                       child: ListView.builder(
                         itemCount: salessList.length,
                         shrinkWrap: true,
                         scrollDirection: Axis.horizontal,
                         itemBuilder: (BuildContext context, int index) {
                           String images = "";
                           try{
                             images = salessList[index].image.toString().split(",")[0];

                           }catch(e){
                             images = salessList[index].image!;
                           }
                           return GestureDetector(
                             onTap: (){
                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => SalesDetailss(salessList[index].saleId!)));
                             },
                             child: Row(
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.only(left: 12,top: 12),
                                   child: SizedBox(
                                     // width: 225,
                                     width: 200 ,
                                     child: Container(
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(15),
                                         // color: Colors.black12,
                                       ),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Container(
                                             height: 130,
                                             // width: 250,
                                             decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(8),
                                               image: DecorationImage(image: NetworkImage(images),fit: BoxFit.fill),
                                             ),
                                           ),
                                           // const SizedBox(height: 8,),
                                           Padding(
                                             padding: EdgeInsets.only(left: 5,top: 5),
                                             child: Text(salessList[index].formatPrice(salessList[index].price??''),style: const TextStyle(color: Color(0xffe37640),fontWeight: FontWeight.bold,fontSize: 16),),
                                           ),
                                           Padding(
                                             padding: const EdgeInsets.only(left: 5,top: 3),
                                             child: Row(
                                               children: [
                                                 Image.asset("assets/images/bed.png",height: 12,color: MyColors.grey1,),
                                                 const SizedBox(width: 5,),
                                                 Text(salessList[index].bedroom!,style:  TextStyle(fontSize: 12,color: MyColors.grey1,),),
                                                 const SizedBox(width: 5,),
                                                 Text("Bed",style: TextStyle(fontSize: 12,color: MyColors.grey1,),),
                                                 const SizedBox(width: 10,),
                                                 Image.asset("assets/images/bath.png",height: 12,color: MyColors.grey1,),
                                                 const SizedBox(width: 5,),
                                                 Text(salessList[index].bathroom!,style: TextStyle(fontSize: 12,color: MyColors.grey1,),),
                                                 SizedBox(width: 4,),
                                                 Text("Bath",style: TextStyle(color: MyColors.grey1,fontSize: 12),),
                                                 const SizedBox(width: 5,),
                                                 Image.asset("assets/images/loca.png",height: 12,color: MyColors.grey1,),
                                                 Flexible(
                                                   flex: 2,
                                                   child: Text(salessList[index].city!,style: TextStyle(color: MyColors.grey1,fontSize: 12),
                                                     maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                 )
                                               ],
                                             ),
                                           ),

                                         ],
                                       ),
                                     ),
                                   ),
                                 )
                               ],
                             ),
                           );
                         },
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 15,right: 15,top: 8),
                       child: Row(
                         children: [
                           Text("Featured Motors Listings",style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.bold,fontSize: 15,),),
                           Spacer(),
                           InkWell(
                               onTap: (){
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MotorViewPage("")));
                               },
                               child: Container(
                                   width: 60,
                                   height: 22,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5),
                                       color: MyColors.navy
                                   ),
                                   child: Align(alignment: Alignment.center,
                                       child: Text("View all",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 11),)))),
                         ],
                       ),
                     ),
                     SizedBox(
                       width: double.infinity,
                       height: 225,
                       child: ListView.builder(
                         itemCount: motorlist.length,
                         shrinkWrap: true,
                         scrollDirection: Axis.horizontal,
                         itemBuilder: (BuildContext context, int index) {
                           String images = "";
                           try{
                             images = motorlist[index].image.toString().split(",")[0];

                           }catch(e){
                             images = motorlist[index].image!;
                           }
                           return GestureDetector(
                             onTap: (){
                               Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MotorDetails(motorlist[index].motorId!)));
                             },
                             child: Row(
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.only(left: 10,top: 12),
                                   child: SizedBox(
                                     width: 180,
                                     child: Container(
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(8),
                                         color: const Color(0xff006599),
                                       ),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Container(
                                             height: 120,
                                             // width: 250,
                                             decoration: BoxDecoration(
                                               borderRadius: const BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                                               image: DecorationImage(image: NetworkImage(images),fit: BoxFit.cover),
                                             ),
                                           ),
                                           const SizedBox(height: 8,),
                                           Padding(
                                             padding: const EdgeInsets.only(left: 10,top: 5),
                                             child: Text(motorlist[index].title!,style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,),
                                           ),
                                           const SizedBox(height: 3,),
                                           Padding(
                                             padding: const EdgeInsets.only(left: 10),
                                             child: Text(motorlist[index].formatPrice(motorlist[index].price??''),style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                           ),
                                           const SizedBox(height: 8,),
                                           const Padding(
                                             padding: EdgeInsets.only(left: 12,right: 12),
                                             child: Divider(height: 2,color: Colors.white30,thickness: 1,),
                                           ),
                                           const SizedBox(height: 8,),
                                           Padding(
                                             padding: EdgeInsets.only(left: 12),
                                             child: Row(
                                               children: [
                                                 Container(
                                                   height: 20,
                                                   width: 45,
                                                   decoration: BoxDecoration(
                                                       borderRadius: BorderRadius.circular(5),
                                                       color: Colors.white
                                                   ),
                                                   child: Align(alignment: Alignment.center, child: Text(motorlist[index].year!,style:  TextStyle(fontSize: 12,color: MyColors.navy,fontWeight: FontWeight.bold),)),
                                                 ),
                                                 const SizedBox(width: 12,),
                                                 Text(motorlist[index].kms!,style: const TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),),
                                                 const SizedBox(width: 3,),
                                                 const Text("Km",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),),
                                                 const SizedBox(width: 12,),
                                                 Text(motorlist[index].wheels!,style: TextStyle(fontSize: 11,color: Colors.white,fontWeight: FontWeight.bold),)
                                               ],
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 )
                               ],
                             ),
                           );
                         },
                       ),
                     ),
                     SizedBox(height: 20,),

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
  Future<void>_showChoiceDialog(BuildContext context) {
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: const Text('All Categories'),
        content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categorylist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(categorylist[index].title!),
                        onTap: () {
                          setState(() {
                            search.text = categorylist[index].title!;
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                )
              ]
          ),
        ),
      );
    });
  }
  Future<void>_showCitiessDialog(BuildContext context) {
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: const Text('All Categories'),
        content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: citylist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(citylist[index].cityName!),
                        onTap: () {
                          setState(() {
                            // mycities.text = citylist[index].cityName!;
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                )
              ]
          ),
        ),
      );
    });
  }
  Future<void>_showSubmenuDialog(BuildContext context) {
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        // title: Text('All Categories'),
        content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: submenulist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(submenulist[index].subMenu!),
                        onTap: () {
                          Navigator.pop(context);
                          if(submenulist[index].id == "1"){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MotorPage(submenulist[index].id!)));
                          }else if(submenulist[index].id == "41"){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SalePage(submenulist[index].id!)));
                          }else if(submenulist[index].id == "42"){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SalePage(submenulist[index].id!)));
                          }else{
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RentPage(submenulist[index].id!)));
                          }
                        },
                      );
                    },
                  ),
                )
              ]
          ),
        ),
      );
    });
  }
}

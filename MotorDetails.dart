import 'dart:convert';



import 'package:ai3on/models/ParticularMotorViewModel.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../ApiUtils.dart';
import '../../MyColors.dart';
import '../../menusample.dart';
import '../NewScreen/SigninScreen.dart';
import '../homescreens/Add.dart';
import '../homescreens/DealsPage.dart';
import '../homescreens/HomePage.dart';
import '../homescreens/NewClass.dart';

class MotorDetails extends StatefulWidget {
  String id;
  MotorDetails(this.id);
  @override
  State<StatefulWidget> createState() {
    return _MotorDetailsState(this.id);
  }
}
class LoginModel {
  String token; // Assuming 'token' is a property in your LoginModel
  // Other properties and constructor for LoginModel

  LoginModel({required this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(token: json['token']); // Update this to match your JSON response structure
  }
}

class _MotorDetailsState extends State<MotorDetails> with TickerProviderStateMixin {

  TextEditingController msg=new TextEditingController();
  bool islogin = false;

  get() async {
    var sharedpref = await SharedPreferences.getInstance();
    islogin = sharedpref.getBool("islogin")!;
  }

  List<BottomNavigationBarItem> itemss = [
    BottomNavigationBarItem(icon: Icon(Icons.home, size: 30,), label: "Home",),
    BottomNavigationBarItem(
        icon: Icon(Icons.search, size: 30,), label: "Classifieds"),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_circle, size: 30,), label: "Add"),
    BottomNavigationBarItem(
        icon: Icon(Icons.bookmark_add, size: 30,), label: "Deals"),
    BottomNavigationBarItem(icon: Icon(Icons.menu, size: 30,), label: "Menu")
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

  List<SimilarAds> similarmotoraddlist = [];

  ApiUtils apiUtils = ApiUtils();
  String id;

  _MotorDetailsState(this.id);

  String title = "";
  String price = "";
  String describeYourSportsBike = "";
  String usage = "";
  String kilometers = "";
  String years = "";
  String sellerType = "";
  String warranty = "";
  String finalDriveSystem = "";
  String wheels = "";
  String manufaturer = "";
  String engineSize = "";
  String image = "";
  String city = "";
  String lat = "";
  String lng = "";
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool isLoading = true;
  List<MotorsDetails> motorsDetails = [];
  List<String> imageslist = [];
  ScrollController _scrollController = new ScrollController();
  bool backtoTop = false;
  late FlutterGifController controller;
  TextEditingController reason=new TextEditingController();

  @override
  Future<void> submitReport() async {
    final String apiUrl =
        'https://sanishsoft.co.in/demo/al3on/al3on.ae/report_ad_app';

    final Map<String, String> data = {
      'user_id': '3589',
      'ad_id': '8',
      'menu_id': '1',
      'submenu_id': '1',
      'reason': reason.text,
      'notes': msg.text,
      'type': 'default',
    };

    // Manually encode the data into x-www-form-urlencoded format
    String encodedData = data.keys
        .map((key) => "$key=${Uri.encodeComponent(data[key]!)}")
        .join("&");
    print("encodedData : $encodedData");
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: encodedData,
      );
      print(response.statusCode);
      var body = response.body;
      var jsonbody = json.decode(response.body);
      print(body);
      if (response.statusCode == 200) {
        // Report submitted successfully
        print("response.body : ${body}");
        if (jsonbody['msg']) {
          print('Report submitted successfully');
          print(reason);
        }
        // Optionally, show a success message or perform additional actions upon success
      } else {
        // Failed to submit the report
        print('Failed to submit report (${response.statusCode})');
        // Handle error, show an error message, etc.
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error submitting report: $e');
      // Handle network errors or other exceptions
    }
  }
  // String BASE_URL = "https://sanishsoft.co.in/demo/al3on/al3on.ae/";



// Assuming the RegisterModel and its fromJson method are defined similarly to LoginModel

  // String? authToken;
  //
  // Future<LoginModel> login(String email, String password) async {
  // var body = {
  // 'email': email,
  // 'password': password,
  // };
  // final response = await http.post(Uri.parse(BASE_URL + "login_app"), body: body);
  // if (response.statusCode == 200) {
  // var loginModel = LoginModel.fromJson(jsonDecode(response.body));
  // authToken = loginModel.token;
  // return loginModel;
  // } else {
  // throw Exception('Failed to create Login');
  // }
  // }

  // void submitReport() async {
  //   final String apiUrl = 'https://sanishsoft.co.in/demo/al3on/al3on.ae/report_ad_app';
  //
  //   final Map<String, dynamic> data = {
  //     'user_id': 3589,
  //     'ad_id': 8,
  //     'menu_id': 1, // Assuming menu_id and submenu_id are strings
  //     'submenu_id': 1,
  //     'reason': "fraud", // Replace with actual reason
  //     'notes': 'test notes by 27/12/23', // Replace with actual notes
  //     'type': 'default',
  //     // Other required parameters if needed
  //   };
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(data),
  //     );
  //     print(response.body);
  //     print(response.statusCode);
  //
  //     if (response.statusCode == 200) {
  //       // Report submitted successfully
  //       print('Report submitted successfully');
  //       Fluttertoast.showToast(
  //         msg: 'Report submitted successfully',
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //       );
  //       // Optionally, show a success message or perform additional actions upon success
  //     } else {
  //       // Failed to submit the report
  //       print('Failed to submit report (${response.statusCode})');
  //       // Handle error, show an error message, etc.
  //     }
  //   } catch (e) {
  //     // Exception occurred during the request
  //     print('Error submitting report: $e');
  //     // Handle network errors or other exceptions
  //   }
  // }


  void initState() {
    // TODO: implement initState
   submitReport();
    super.initState();
    controller = FlutterGifController(vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    controller.repeat(
      min: 0,
      max: 203,
      period: const Duration(milliseconds: 500),
    );
    apiUtils.getParticularMotor(id).then((value) {
      setState(() {
        title = value.title!;
        price = value.price!;
        kilometers = value.kilometers!;
        years = value.years!;
        warranty = value.warranty!;
        motorsDetails = value.motorsDetails !;
        city = value.city!;
        // lat = value.latitude!;
        // lng = value.longitude!;
        similarmotoraddlist = value.similarAds!;
        imageslist = value.images!;
        print(lat);
        isLoading = false;
      });
    });
    _scrollController.addListener(() {
      setState(() {
        backtoTop = _scrollController.offset > 40 ? true : false;
      });
    });
  }





  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: isLoading,
      blurEffectIntensity: 1,
      progressIndicator: GifImage(
        controller: controller,
        image: AssetImage("assets/images/loader.gif"),
      ),
      dismissible: false,
      opacity: 0.1,
      child: Scaffold(
        bottomNavigationBar: Container(width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/footer.jpg'),
                fit: BoxFit.cover),
          ), child:
          BottomNavigationBar(
            selectedItemColor: MyColors.yellow,
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
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30,), label: "Home",),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search, size: 30,), label: "Classifieds"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle, size: 30,), label: "Add"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_add, size: 30,), label: "Deals"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu, size: 30,), label: "Menu")
            ],
          ),
        ),
        body: isLoading ? SizedBox() : SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              // image.isEmpty ? SizedBox(width: 50,height: 50,child: CircularProgressIndicator(),) :
              Positioned(top: 0, right: 0, left: 0,
                child: SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: Swiper(
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Card(
                          child: Image.network(
                            imageslist[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                    indicatorLayout: PageIndicatorLayout.COLOR,
                    autoplay: true,
                    itemCount: imageslist.length,
                    pagination: const SwiperPagination(),
                    // control: const SwiperControl(color: Colors.black),
                  ),
                ),
                // Image.network(image,height:330,fit: BoxFit.fitHeight,)
              ),
              Positioned(top: 30, left: 20, child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back, size: 30, color: Colors.white,))),
              AnimatedPositioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: backtoTop ? 0 : 300,
                duration: Duration(milliseconds: 400),
                child: SizedBox(
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: backtoTop ? Radius.zero : Radius.circular(
                                30),
                            topLeft: backtoTop ? Radius.zero : Radius.circular(
                                30)),
                        color: Colors.white
                    ),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.all(15),
                          //   child: TextFormField(
                          //     decoration: InputDecoration(
                          //         contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          //         border: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(8)
                          //         ),
                          //         prefixIcon: Icon(Icons.location_on,color: Colors.tealAccent,),
                          //         suffixIcon: Icon(Icons.arrow_drop_down,size: 30,color: Colors.tealAccent,),
                          //         hintText: "Deira City Center",
                          //         hintStyle: TextStyle(color: Colors.tealAccent,fontWeight: FontWeight.bold)
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on, color: MyColors.mainorange,
                                  size: 17,),
                                SizedBox(width: 10,),
                                Text(city, style: TextStyle(
                                    color: MyColors.mainorange,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),),
                                Spacer(),
                                FavoriteButton(
                                  iconSize: 45,
                                  isFavorite: false,
                                  iconColor: Color(0xffF16622),
                                  // iconDisabledColor: Colors.white,
                                  valueChanged: (_isFavorite) {
                                    apiUtils.addtofavorite("1", id).then((
                                        value) {
                                      if (value.status.toString() == "0") {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        showTopSnackBar(context,
                                          CustomSnackBar.error(
                                            message:
                                            value.msg!,
                                          ),
                                        );
                                      } else {
                                        showTopSnackBar(context,
                                          CustomSnackBar.success(
                                            message:
                                            value.msg!,
                                          ),
                                        );
                                      }
                                    });
                                  },
                                ),
                                // Icon(Icons.favorite_border,color: MyColors.mainorange,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                Expanded(child: Text(
                                  title, overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Color(0xff006599),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),)),
                                // Container(width: 200),
                                Spacer(),
                                Text("Share", style: TextStyle(
                                    color: Color(0xff006599),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),),
                                SizedBox(width: 5,),
                                Image.asset("assets/images/share.png",
                                  color: Color(0xff006599), height: 20,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: Row(
                              children: [
                                Text('AED', style: TextStyle(
                                    color: MyColors.mainorange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),),
                                SizedBox(width: 5,),
                                Text(formatPrice(price), style: TextStyle(
                                    color: MyColors.mainorange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),),
                              ],
                            ),
                          ),
                          // SizedBox(height: 10,),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 15,top: 10),
                          //   child: Text("Discount 10%",style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.bold,fontSize: 20),),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 15),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/speed.png", height: 20,
                                  color: Colors.grey,),
                                const SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Km", style: TextStyle(
                                        color: Colors.grey, fontSize: 13),),
                                    Text(kilometers, style: const TextStyle(
                                        color: Colors.grey, fontSize: 13),)
                                  ],
                                ),
                                const SizedBox(width: 30,),
                                Image.asset(
                                  "assets/images/date.png", height: 20,
                                  color: Colors.grey,),
                                const SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Year", style: TextStyle(
                                        color: Colors.grey, fontSize: 13),),
                                    Text(years, style: const TextStyle(
                                        color: Colors.grey, fontSize: 13),)
                                  ],
                                ),
                                const SizedBox(width: 30,),
                                Image.asset(
                                    "assets/images/carwarr.png", height: 20,
                                    color: Colors.grey),
                                const SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("WARRANTY", style: TextStyle(
                                        color: Colors.grey, fontSize: 13),),
                                    Text(warranty, style: const TextStyle(
                                        color: Colors.grey, fontSize: 13),)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          ListView.builder(
                            itemCount: motorsDetails.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 15, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(motorsDetails[index].name!,
                                      style: TextStyle(color: MyColors.navy,
                                          fontWeight: FontWeight.w400),),
                                    SizedBox(height: 5,),
                                    SizedBox(
                                      width: 300,
                                      child: motorsDetails[index].value!
                                          .startsWith("http") ?
                                      SelectableLinkify(
                                        onOpen: _onOpen,
                                        text: motorsDetails[index].value!,
                                      ) :
                                      Text(motorsDetails[index].value!,
                                        style: TextStyle(color: MyColors.grey1,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13),
                                        maxLines: 15,
                                        overflow: TextOverflow.ellipsis,),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          Divider(
                            height: 2,
                            thickness: 1,
                            indent: 15,
                            endIndent: 15,
                            color: Colors.blue[50],),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text('Location', style: TextStyle(
                                color: MyColors.navy,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, bottom: 15),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined,
                                  color: MyColors.grey1, size: 15,),
                                SizedBox(width: 5,),
                                Text(city, style: TextStyle(
                                    color: MyColors.grey1,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13),),
                              ],
                            ),
                          ),
                          lat.isEmpty ? SizedBox() : SizedBox(
                            width: double.infinity, height: 180,
                            child: GoogleMap(
                              onMapCreated: _onMapCreated,

                              initialCameraPosition: CameraPosition(

                                target: LatLng(
                                    double.parse(lat), double.parse(lng)),
                                zoom: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: Row(
                              children: [
                                Text('Is there an issue?',
                                  style: TextStyle(color: MyColors.grey1,),),
                                Spacer(),
                                GestureDetector(
                                    onTap: () => _showCustomPopup(context),
                                    child: Text('Report this ad',
                                      style: TextStyle(
                                        color: MyColors.mainorange,
                                        fontSize: 12,),))
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 12),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      // height:45,
                                      // width: 160,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color(0xff006599),
                                            width: 1.5
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            // Icon(Icons.directions_outlined,color: Colors.blue,),
                                            Image.asset("assets/images/pin.png",
                                              height: 25,
                                              color: Color(0xff006599),),
                                            SizedBox(width: 10,),
                                            Text("Direction", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff006599)),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      // height:45,
                                      // width: 165,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          color: Color(0xff006599)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Icon(Icons.phone_outlined,
                                              color: Colors.white,),
                                            SizedBox(width: 5,),
                                            Text("Call Us", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 15),
                            child: Text('Similar Ads', style: TextStyle(
                                color: MyColors.navy,
                                fontWeight: FontWeight.w800,
                                fontSize: 15),),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 160,
                            child: ListView.builder(
                              itemCount: similarmotoraddlist.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 5, top: 8),
                                      child: SizedBox(
                                        width: 120,
                                        child: Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                8),
                                            side: BorderSide(
                                                color: Colors.grey.shade300,
                                                width: 1.3
                                            ),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              // print(dealslist[index].id!);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MotorDetails(
                                                              similarmotoraddlist[index]
                                                                  .id!)));
                                            },
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                  height: 90,
                                                  // width: 160,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .only(topLeft: Radius
                                                        .circular(8),
                                                        topRight: Radius
                                                            .circular(8)),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            similarmotoraddlist[index]
                                                                .image!),
                                                        fit: BoxFit.fill),
                                                  ),
                                                  // child: Padding(
                                                  //   padding: const EdgeInsets.all(5),
                                                  //   child: Image.network(similarsalesaddlist[index].image!),
                                                  // ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(left: 5, top: 8),
                                                  child: Row(
                                                    children: [
                                                      Text('AED',
                                                        style: TextStyle(
                                                            color: MyColors
                                                                .mainorange,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            fontSize: 13),),
                                                      SizedBox(width: 5,),
                                                      Text(
                                                        similarmotoraddlist[index]
                                                            .formatPrice(
                                                            similarmotoraddlist[index]
                                                                .price ?? ''),
                                                        style: TextStyle(
                                                            color: MyColors
                                                                .mainorange,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            fontSize: 13),),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5, top: 5),
                                                  child: Text(
                                                    similarmotoraddlist[index]
                                                        .title!,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.black38,),),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),

        ),
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (!await launchUrl(Uri.parse(link.url))) {
      throw Exception('Could not launch ${link.url}');
    }
  }

  void _onMapCreated(GoogleMapController googleMapController) {
    final marker = Marker(
      markerId: MarkerId(title),
      position: LatLng(double.parse(lat), double.parse(lng)),
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: title,
        snippet: city,
      ),
    );

    setState(() {
      markers[MarkerId(title)] = marker;
    });
  }

  void _showCustomPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Report this ad', style: TextStyle(
                  color: MyColors.mainorange
              ),),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.cancel_rounded, size: 20, color: Colors.grey[500],))
            ],
          ),
          content: SingleChildScrollView(
            child:
            GestureDetector(
              onTap: () {
                _showReasonToReportDialogspam(context);
              },
              child: Column(
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: (){
                            _showReasonToReportDialogspam( context);
                          },
                          child: Text("Spam",
                            style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                               ),
                        ),
                      ),
                      Divider(height: 2, thickness: 1.5, color: Colors.grey[200],),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: (){
                            _showReasonToReportDialogfraud(context);
                          },
                          child: Text("Fraud",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Divider(height: 2, thickness: 1.5, color: Colors.grey[200],),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: (){
                            _showReasonToReportDialogMiscategorized(context);
                          },
                          child: Text("MisCategorized",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Divider(height: 2, thickness: 1.5, color: Colors.grey[200],),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                         onTap: (){
                           _showReasonToReportDialogRepitiveListing(context);
                         },
                          child: Text("Repitive Listing",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Divider(height: 2, thickness: 1.5, color: Colors.grey[200],),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: (){
                            _showReasonToReportDialogcopyright(context);
                          },
                          child: Text("Copyright infringement",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Divider(height: 2, thickness: 1.5, color: Colors.grey[200],),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: (){
                            _showReasonToReportDialogNotavailable(context);
                          },
                          child: Text("Not Available",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Divider(height: 2, thickness: 1.5, color: Colors.grey[200],),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 80.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();


                        // Use the messages retrieved from the API here
                        print("successfully to loaded to admin");
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(MyColors.navy),
                      ),
                      child: Text("Submit"),
                    )),

                  ElevatedButton(onPressed: () {
                    _showReasonToReportDialogspam(context);
                  }, style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        MyColors.mainorange),), child: Text("Next")),
                  ],
                ),
              ),

            ],
                  ),

                  // ListTile(
                  //   title: Text(
                  //     "Fraud",
                  //     style: TextStyle(
                  //       color: Colors.black54,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     // Add your logic for "Oldest first"
                  //   },
                  // ),
                  // Divider(height: 2, thickness: 1.5, color: Colors.grey[200],),
                  // ListTile(
                  //   title: Text(
                  //     "Miscategorized",
                  //     style: TextStyle(
                  //       color: Colors.black54,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     // Add your logic for "Oldest first"
                  //   },
                  // ),
                  // Divider(height: 2, thickness: 1.5, color: Colors.grey[200],),
                  // ListTile(
                  //   title: Text(
                  //     "Repitive Listing",
                  //     style: TextStyle(
                  //       color: Colors.black54,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     // Add your logic for "Oldest first"
                  //   },
                  // ),
                  // Divider(height: 2, thickness: 1.5, color: Colors.grey[200],),
                  // ListTile(
                  //   title: Text(
                  //     "Copyright infringement",
                  //     style: TextStyle(
                  //       color: Colors.black54,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     // Add your logic for "Oldest first"
                  //   },
                  // ),
                  // Divider(height: 2, thickness: 1.5, color: Colors.grey[200],),
                  // ListTile(
                  //   title: Text(
                  //     "Not Available",
                  //     style: TextStyle(
                  //       color: Colors.black54,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     // Add your logic for "Oldest first"
                  //   },
                  // ),
                  // Divider(height: 2, thickness: 1.5, color: Colors.grey[200],),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 20.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 80.0),
                  //         child: ElevatedButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //             Future<List<String>> retrieveMessages({
                  //               required String userId,
                  //               required String adId,
                  //               required String reason,
                  //               required String notes,
                  //             }) async {
                  //               final String apiUrl = '	https://sanishsoft.co.in/demo/al3on/al3on.ae/report_ad_reason';
                  //
                  //               final Map<String, String> queryParams = {
                  //                 'user_id': "3589",
                  //                 'ad_id': "8",
                  //                 'menu_id': '1', // Assuming menu_id and submenu_id are strings
                  //                 'submenu_id': '1',
                  //                 'reason': reason,
                  //                 'notes': notes,
                  //                 'type': 'default',
                  //                 // Other required parameters if needed
                  //               };
                  //
                  //               final Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);
                  //
                  //               try {
                  //                 final response = await http.get(uri);
                  //
                  //                 if (response.statusCode == 200) {
                  //                   final List<dynamic> messagesList = json.decode(response.body);
                  //                   List<String> messages = messagesList.map((message) => message.toString()).toList();
                  //
                  //                   print('Messages retrieved successfully');
                  //                   return messages;
                  //                 } else {
                  //                   print('Failed to retrieve messages (${response.statusCode})');
                  //                   return []; // Return an empty list or handle error accordingly
                  //                 }
                  //               } catch (e) {
                  //                 print('Error retrieving messages: $e');
                  //                 return []; // Return an empty list or handle errors accordingly
                  //               }
                  //             }
                  //
                  //             // Use the messages retrieved from the API here
                  //             print(messages);
                  //           },
                  //           style: ButtonStyle(
                  //             backgroundColor: MaterialStateProperty.all<Color>(MyColors.navy),
                  //           ),
                  //           child: Text("Submit"),
                  //         )),
                  //
                  //       ElevatedButton(onPressed: () {
                  //         _showReasonToReportDialog(context);
                  //       }, style: ButtonStyle(
                  //         backgroundColor: MaterialStateProperty.all<Color>(
                  //             MyColors.mainorange),), child: Text("Next")),
                  //     ],
                  //   ),
                  // )


                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20.0,right: 20),
                  //   child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
                  // ),


                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showReasonToReportDialogspam(BuildContext context) {
    String selectedValue = 'Spam'; // Holds the selected value
//     // final List<String> options = [
//     //   'Spam',
//     //   'Fraud',
//     //   'Miscategorized',
//     //   'Repitive Listing',
//     //   'Copyright infringement',
//     //   'Not Available',
//     //   // Add your list of options here
//     // ];
// // Check for duplicates in the list of options


    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reason to Report',
                        style: TextStyle(
                          color: MyColors.mainorange, // MyColors.mainorange,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.cancel_rounded,
                            size: 20, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 1.5,
                  color: Colors.grey[200],
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //    height: 30,
                //    width: 200,
                //
                //    decoration: BoxDecoration(
                //      color: Colors.white,
                //      border: Border.all(color: Colors.black)
                //    ),
                //
                //    child: DropdownButtonFormField<String>(
                //      value: selectedValue,
                //      items: options.map((String value) {
                //        return DropdownMenuItem<String>(
                //          value: value,
                //          child: Text(value),
                //        );
                //      }).toList(),
                //      onChanged: (String? newValue) {
                //        setState(() {
                //          selectedValue = newValue!;
                //        });
                //      },
                //      // decoration: InputDecoration(
                //      //   hintText: 'Select an option',
                //      //   suffixIcon: Icon(Icons.arrow_drop_down),
                //      // ),
                //    ),
                //  ),
                // Container(
                //   height: 45,
                //   // Adjust the height to fit both Dropdown and TextField
                //   width: 189,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border.all(color: Colors.black),
                //   ),
                //   child: DropdownButtonFormField<String>(
                //     value: selectedValue,
                //     items: options.map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         selectedValue = newValue!;
                //       });
                //     },
                //   ),
                // ),
                Container(
                  height: 35,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyColors.navy)
                  ), child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left
                        :8.0),
                    child: TextField(
                      controller: reason,
                      style: TextStyle(
                      color: MyColors.navy,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),decoration: InputDecoration(
                      hintText: "Spam",
                      border: InputBorder.none,
                    ),
                    ),
                  ),
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text("Please tell us why you believe this is spam.",
                    style: TextStyle(
                      color: MyColors.navy,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 100,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xffDFE8F1)),
                    ), child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: msg,
                      style: TextStyle(
                        color: MyColors.navy,
                      ),

                      decoration: InputDecoration(

                        hintText: 'Message here',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 100.0, top: 10),
                  child: Text("Minimum 20 characters", style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "You have chosen to report this as spam.", style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  // child: OutlinedButton(
                  //   onPressed: () {
                  //     // Get the selected reason and notes
                  //     String selectedReason = selectedValue; // This is the selected reason
                  //     // Get the notes entered in the TextField
                  //     String enteredNotes = ''; // Get the entered notes from your TextField
                  //
                  //     // Assuming you have the necessary IDs for the report
                  //     String userId = 'your_user_id';
                  //     String adId = 'your_ad_id';
                  //     String menuId = 'your_menu_id';
                  //     String submenuId = 'your_submenu_id';
                  //
                  //     // Submit report via API
                  //     submitReport(
                  //       userId: userId,
                  //       adId: adId,
                  //       menuId: menuId,
                  //       submenuId: submenuId,
                  //       reason: selectedReason,
                  //       notes: enteredNotes,
                  //       type: 'your_type', // Set the appropriate type
                  //     );
                  //
                  //     // Close the dialog after submitting the report
                  //     Navigator.pop(dialogContext);
                  //   },
                  //   child: Text('Submit',style: TextStyle(
                  //
                  //   ),),
                  // ),
                  // child: Container(
                  //   height: 40,
                  //   width: 150,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey[200],
                  //     border: Border.all(color: MyColors.grey1),
                  //   ),
                  //
                  //   child: Center(
                  //     child: Text("Submit Report",
                  //         style: TextStyle(
                  //           color: MyColors.navy,
                  //           fontSize: 13,
                  //           fontWeight: FontWeight.w500,
                  //         )
                  //     ),
                  //   ),
                  // ),
                child:
                ElevatedButton(
                  onPressed: () {
                    submitReport();

                    print(msg);
                    print(reason);// Replace with entered notes

                    // Call the API function to submit the ad report


                    Navigator.of(context).pop(); // Close the dialog after reporting
                  }, style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(MyColors.navy),
                ),
                  child: Text('Submit Report'),
                ),

                ),

              ],
            ),
          );
        }


    );
  }
  void _showReasonToReportDialogfraud(BuildContext context) {
   // Holds the selected value
//     // final List<String> options = [
//     //   'Spam',
//     //   'Fraud',
//     //   'Miscategorized',
//     //   'Repitive Listing',
//     //   'Copyright infringement',
//     //   'Not Available',
//     //   // Add your list of options here
//     // ];
// // Check for duplicates in the list of options


    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reason to Report',
                        style: TextStyle(
                          color: MyColors.mainorange, // MyColors.mainorange,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.cancel_rounded,
                            size: 20, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 1.5,
                  color: Colors.grey[200],
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //    height: 30,
                //    width: 200,
                //
                //    decoration: BoxDecoration(
                //      color: Colors.white,
                //      border: Border.all(color: Colors.black)
                //    ),
                //
                //    child: DropdownButtonFormField<String>(
                //      value: selectedValue,
                //      items: options.map((String value) {
                //        return DropdownMenuItem<String>(
                //          value: value,
                //          child: Text(value),
                //        );
                //      }).toList(),
                //      onChanged: (String? newValue) {
                //        setState(() {
                //          selectedValue = newValue!;
                //        });
                //      },
                //      // decoration: InputDecoration(
                //      //   hintText: 'Select an option',
                //      //   suffixIcon: Icon(Icons.arrow_drop_down),
                //      // ),
                //    ),
                //  ),
                // Container(
                //   height: 45,
                //   // Adjust the height to fit both Dropdown and TextField
                //   width: 189,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border.all(color: Colors.black),
                //   ),
                //   child: DropdownButtonFormField<String>(
                //     value: selectedValue,
                //     items: options.map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         selectedValue = newValue!;
                //       });
                //     },
                //   ),
                // ),
                Container(
                  height: 35,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyColors.navy)
                  ), child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: reason,
                      style: TextStyle(
                        color: MyColors.navy,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),decoration: InputDecoration(
                      hintText: "fraud",
                      border: InputBorder.none,
                    ),
                    ),
                  ),
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text("Please tell us why you believe this is spam.",
                    style: TextStyle(
                      color: MyColors.navy,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 100,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xffDFE8F1)),
                    ), child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: msg,
                      style: TextStyle(
                        color: MyColors.navy,
                      ),

                      decoration: InputDecoration(

                        hintText: 'Message here',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 100.0, top: 10),
                  child: Text("Minimum 20 characters", style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "You have chosen to report this as spam.", style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  // child: OutlinedButton(
                  //   onPressed: () {
                  //     // Get the selected reason and notes
                  //     String selectedReason = selectedValue; // This is the selected reason
                  //     // Get the notes entered in the TextField
                  //     String enteredNotes = ''; // Get the entered notes from your TextField
                  //
                  //     // Assuming you have the necessary IDs for the report
                  //     String userId = 'your_user_id';
                  //     String adId = 'your_ad_id';
                  //     String menuId = 'your_menu_id';
                  //     String submenuId = 'your_submenu_id';
                  //
                  //     // Submit report via API
                  //     submitReport(
                  //       userId: userId,
                  //       adId: adId,
                  //       menuId: menuId,
                  //       submenuId: submenuId,
                  //       reason: selectedReason,
                  //       notes: enteredNotes,
                  //       type: 'your_type', // Set the appropriate type
                  //     );
                  //
                  //     // Close the dialog after submitting the report
                  //     Navigator.pop(dialogContext);
                  //   },
                  //   child: Text('Submit',style: TextStyle(
                  //
                  //   ),),
                  // ),
                  // child: Container(
                  //   height: 40,
                  //   width: 150,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey[200],
                  //     border: Border.all(color: MyColors.grey1),
                  //   ),
                  //
                  //   child: Center(
                  //     child: Text("Submit Report",
                  //         style: TextStyle(
                  //           color: MyColors.navy,
                  //           fontSize: 13,
                  //           fontWeight: FontWeight.w500,
                  //         )
                  //     ),
                  //   ),
                  // ),
                  child:
                  ElevatedButton(
                    onPressed: () {
                      submitReport();
                      print(msg);
                      print(reason);// Replace with entered notes

                      // Call the API function to submit the ad report


                      Navigator.of(context).pop(); // Close the dialog after reporting
                    }, style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(MyColors.navy),
                  ),
                    child: Text('Submit Report'),
                  ),

                ),

              ],
            ),
          );
        }


    );
  }
  void _showReasonToReportDialogMiscategorized(BuildContext context) {
   // Holds the selected value
//     // final List<String> options = [
//     //   'Spam',
//     //   'Fraud',
//     //   'Miscategorized',
//     //   'Repitive Listing',
//     //   'Copyright infringement',
//     //   'Not Available',
//     //   // Add your list of options here
//     // ];
// // Check for duplicates in the list of options


    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reason to Report',
                        style: TextStyle(
                          color: MyColors.mainorange, // MyColors.mainorange,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.cancel_rounded,
                            size: 20, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 1.5,
                  color: Colors.grey[200],
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //    height: 30,
                //    width: 200,
                //
                //    decoration: BoxDecoration(
                //      color: Colors.white,
                //      border: Border.all(color: Colors.black)
                //    ),
                //
                //    child: DropdownButtonFormField<String>(
                //      value: selectedValue,
                //      items: options.map((String value) {
                //        return DropdownMenuItem<String>(
                //          value: value,
                //          child: Text(value),
                //        );
                //      }).toList(),
                //      onChanged: (String? newValue) {
                //        setState(() {
                //          selectedValue = newValue!;
                //        });
                //      },
                //      // decoration: InputDecoration(
                //      //   hintText: 'Select an option',
                //      //   suffixIcon: Icon(Icons.arrow_drop_down),
                //      // ),
                //    ),
                //  ),
                // Container(
                //   height: 45,
                //   // Adjust the height to fit both Dropdown and TextField
                //   width: 189,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border.all(color: Colors.black),
                //   ),
                //   child: DropdownButtonFormField<String>(
                //     value: selectedValue,
                //     items: options.map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         selectedValue = newValue!;
                //       });
                //     },
                //   ),
                // ),
                Container(
                  height: 35,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyColors.navy)
                  ), child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left
                        :5.0),
                    child: TextField(
                      controller: reason,
                      style: TextStyle(
                        color: MyColors.navy,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),decoration: InputDecoration(
                      hintText: "Miscategorized",
                      border: InputBorder.none,
                    ),
                    ),
                  ),
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text("Please tell us why you believe this is spam.",
                    style: TextStyle(
                      color: MyColors.navy,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 100,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xffDFE8F1)),
                    ), child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: msg,
                      style: TextStyle(
                        color: MyColors.navy,
                      ),

                      decoration: InputDecoration(

                        hintText: 'Message here',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 100.0, top: 10),
                  child: Text("Minimum 20 characters", style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "You have chosen to report this as spam.", style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  // child: OutlinedButton(
                  //   onPressed: () {
                  //     // Get the selected reason and notes
                  //     String selectedReason = selectedValue; // This is the selected reason
                  //     // Get the notes entered in the TextField
                  //     String enteredNotes = ''; // Get the entered notes from your TextField
                  //
                  //     // Assuming you have the necessary IDs for the report
                  //     String userId = 'your_user_id';
                  //     String adId = 'your_ad_id';
                  //     String menuId = 'your_menu_id';
                  //     String submenuId = 'your_submenu_id';
                  //
                  //     // Submit report via API
                  //     submitReport(
                  //       userId: userId,
                  //       adId: adId,
                  //       menuId: menuId,
                  //       submenuId: submenuId,
                  //       reason: selectedReason,
                  //       notes: enteredNotes,
                  //       type: 'your_type', // Set the appropriate type
                  //     );
                  //
                  //     // Close the dialog after submitting the report
                  //     Navigator.pop(dialogContext);
                  //   },
                  //   child: Text('Submit',style: TextStyle(
                  //
                  //   ),),
                  // ),
                  // child: Container(
                  //   height: 40,
                  //   width: 150,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey[200],
                  //     border: Border.all(color: MyColors.grey1),
                  //   ),
                  //
                  //   child: Center(
                  //     child: Text("Submit Report",
                  //         style: TextStyle(
                  //           color: MyColors.navy,
                  //           fontSize: 13,
                  //           fontWeight: FontWeight.w500,
                  //         )
                  //     ),
                  //   ),
                  // ),
                  child:
                  ElevatedButton(
                    onPressed: () {
                      submitReport();
                      print(msg);
                      print(reason);// Replace with entered notes

                      // Call the API function to submit the ad report


                      Navigator.of(context).pop(); // Close the dialog after reporting
                    }, style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(MyColors.navy),
                  ),
                    child: Text('Submit Report'),
                  ),

                ),

              ],
            ),
          );
        }


    );
  }
  void _showReasonToReportDialogRepitiveListing(BuildContext context) {
    // Holds the selected value
//     // final List<String> options = [
//     //   'Spam',
//     //   'Fraud',
//     //   'Miscategorized',
//     //   'Repitive Listing',
//     //   'Copyright infringement',
//     //   'Not Available',
//     //   // Add your list of options here
//     // ];
// // Check for duplicates in the list of options


    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reason to Report',
                        style: TextStyle(
                          color: MyColors.mainorange, // MyColors.mainorange,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.cancel_rounded,
                            size: 20, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 1.5,
                  color: Colors.grey[200],
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //    height: 30,
                //    width: 200,
                //
                //    decoration: BoxDecoration(
                //      color: Colors.white,
                //      border: Border.all(color: Colors.black)
                //    ),
                //
                //    child: DropdownButtonFormField<String>(
                //      value: selectedValue,
                //      items: options.map((String value) {
                //        return DropdownMenuItem<String>(
                //          value: value,
                //          child: Text(value),
                //        );
                //      }).toList(),
                //      onChanged: (String? newValue) {
                //        setState(() {
                //          selectedValue = newValue!;
                //        });
                //      },
                //      // decoration: InputDecoration(
                //      //   hintText: 'Select an option',
                //      //   suffixIcon: Icon(Icons.arrow_drop_down),
                //      // ),
                //    ),
                //  ),
                // Container(
                //   height: 45,
                //   // Adjust the height to fit both Dropdown and TextField
                //   width: 189,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border.all(color: Colors.black),
                //   ),
                //   child: DropdownButtonFormField<String>(
                //     value: selectedValue,
                //     items: options.map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         selectedValue = newValue!;
                //       });
                //     },
                //   ),
                // ),
                Container(
                  height: 35,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyColors.navy)
                  ), child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left
                        :6.0),
                    child: TextField(
                      controller: reason,
                      style: TextStyle(
                        color: MyColors.navy,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),decoration: InputDecoration(
                      hintText: "Repitive Listing",
                      border: InputBorder.none,
                    ),
                    ),
                  ),
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text("Please tell us why you believe this is spam.",
                    style: TextStyle(
                      color: MyColors.navy,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 100,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xffDFE8F1)),
                    ), child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: msg,
                      style: TextStyle(
                        color: MyColors.navy,
                      ),

                      decoration: InputDecoration(

                        hintText: 'Message here',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 100.0, top: 10),
                  child: Text("Minimum 20 characters", style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "You have chosen to report this as spam.", style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  // child: OutlinedButton(
                  //   onPressed: () {
                  //     // Get the selected reason and notes
                  //     String selectedReason = selectedValue; // This is the selected reason
                  //     // Get the notes entered in the TextField
                  //     String enteredNotes = ''; // Get the entered notes from your TextField
                  //
                  //     // Assuming you have the necessary IDs for the report
                  //     String userId = 'your_user_id';
                  //     String adId = 'your_ad_id';
                  //     String menuId = 'your_menu_id';
                  //     String submenuId = 'your_submenu_id';
                  //
                  //     // Submit report via API
                  //     submitReport(
                  //       userId: userId,
                  //       adId: adId,
                  //       menuId: menuId,
                  //       submenuId: submenuId,
                  //       reason: selectedReason,
                  //       notes: enteredNotes,
                  //       type: 'your_type', // Set the appropriate type
                  //     );
                  //
                  //     // Close the dialog after submitting the report
                  //     Navigator.pop(dialogContext);
                  //   },
                  //   child: Text('Submit',style: TextStyle(
                  //
                  //   ),),
                  // ),
                  // child: Container(
                  //   height: 40,
                  //   width: 150,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey[200],
                  //     border: Border.all(color: MyColors.grey1),
                  //   ),
                  //
                  //   child: Center(
                  //     child: Text("Submit Report",
                  //         style: TextStyle(
                  //           color: MyColors.navy,
                  //           fontSize: 13,
                  //           fontWeight: FontWeight.w500,
                  //         )
                  //     ),
                  //   ),
                  // ),
                  child:
                  ElevatedButton(
                    onPressed: () {
                      submitReport();
                      print(msg);
                      print(reason);// Replace with entered notes

                      // Call the API function to submit the ad report


                      Navigator.of(context).pop(); // Close the dialog after reporting
                    }, style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(MyColors.navy),
                  ),
                    child: Text('Submit Report'),
                  ),

                ),

              ],
            ),
          );
        }


    );
  }
  void _showReasonToReportDialogcopyright(BuildContext context) {
    // Holds the selected value
//     // final List<String> options = [
//     //   'Spam',
//     //   'Fraud',
//     //   'Miscategorized',
//     //   'Repitive Listing',
//     //   'Copyright infringement',
//     //   'Not Available',
//     //   // Add your list of options here
//     // ];
// // Check for duplicates in the list of options


    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reason to Report',
                        style: TextStyle(
                          color: MyColors.mainorange, // MyColors.mainorange,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.cancel_rounded,
                            size: 20, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 1.5,
                  color: Colors.grey[200],
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //    height: 30,
                //    width: 200,
                //
                //    decoration: BoxDecoration(
                //      color: Colors.white,
                //      border: Border.all(color: Colors.black)
                //    ),
                //
                //    child: DropdownButtonFormField<String>(
                //      value: selectedValue,
                //      items: options.map((String value) {
                //        return DropdownMenuItem<String>(
                //          value: value,
                //          child: Text(value),
                //        );
                //      }).toList(),
                //      onChanged: (String? newValue) {
                //        setState(() {
                //          selectedValue = newValue!;
                //        });
                //      },
                //      // decoration: InputDecoration(
                //      //   hintText: 'Select an option',
                //      //   suffixIcon: Icon(Icons.arrow_drop_down),
                //      // ),
                //    ),
                //  ),
                // Container(
                //   height: 45,
                //   // Adjust the height to fit both Dropdown and TextField
                //   width: 189,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border.all(color: Colors.black),
                //   ),
                //   child: DropdownButtonFormField<String>(
                //     value: selectedValue,
                //     items: options.map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         selectedValue = newValue!;
                //       });
                //     },
                //   ),
                // ),
                Container(
                  height: 35,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyColors.navy)
                  ), child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: reason,
                      style: TextStyle(
                        color: MyColors.navy,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),decoration: InputDecoration(
                      hintText: "Copyright infringement",
                      border: InputBorder.none,
                    ),
                    ),
                  ),
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text("Please tell us why you believe this is spam.",
                    style: TextStyle(
                      color: MyColors.navy,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 100,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xffDFE8F1)),
                    ), child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: msg,
                      style: TextStyle(
                        color: MyColors.navy,
                      ),

                      decoration: InputDecoration(

                        hintText: 'Message here',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 100.0, top: 10),
                  child: Text("Minimum 20 characters", style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "You have chosen to report this as spam.", style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  // child: OutlinedButton(
                  //   onPressed: () {
                  //     // Get the selected reason and notes
                  //     String selectedReason = selectedValue; // This is the selected reason
                  //     // Get the notes entered in the TextField
                  //     String enteredNotes = ''; // Get the entered notes from your TextField
                  //
                  //     // Assuming you have the necessary IDs for the report
                  //     String userId = 'your_user_id';
                  //     String adId = 'your_ad_id';
                  //     String menuId = 'your_menu_id';
                  //     String submenuId = 'your_submenu_id';
                  //
                  //     // Submit report via API
                  //     submitReport(
                  //       userId: userId,
                  //       adId: adId,
                  //       menuId: menuId,
                  //       submenuId: submenuId,
                  //       reason: selectedReason,
                  //       notes: enteredNotes,
                  //       type: 'your_type', // Set the appropriate type
                  //     );
                  //
                  //     // Close the dialog after submitting the report
                  //     Navigator.pop(dialogContext);
                  //   },
                  //   child: Text('Submit',style: TextStyle(
                  //
                  //   ),),
                  // ),
                  // child: Container(
                  //   height: 40,
                  //   width: 150,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey[200],
                  //     border: Border.all(color: MyColors.grey1),
                  //   ),
                  //
                  //   child: Center(
                  //     child: Text("Submit Report",
                  //         style: TextStyle(
                  //           color: MyColors.navy,
                  //           fontSize: 13,
                  //           fontWeight: FontWeight.w500,
                  //         )
                  //     ),
                  //   ),
                  // ),
                  child:
                  ElevatedButton(
                    onPressed: () {
                      submitReport();
                      print(msg);
                      print(reason);// Replace with entered notes

                      // Call the API function to submit the ad report


                      Navigator.of(context).pop(); // Close the dialog after reporting
                    }, style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(MyColors.navy),
                  ),
                    child: Text('Submit Report'),
                  ),

                ),

              ],
            ),
          );
        }


    );
  }
  void _showReasonToReportDialogNotavailable(BuildContext context) {
    String selectedValue = 'Spam'; // Holds the selected value
//     // final List<String> options = [
//     //   'Spam',
//     //   'Fraud',
//     //   'Miscategorized',
//     //   'Repitive Listing',
//     //   'Copyright infringement',
//     //   'Not Available',
//     //   // Add your list of options here
//     // ];
// // Check for duplicates in the list of options


    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reason to Report',
                        style: TextStyle(
                          color: MyColors.mainorange, // MyColors.mainorange,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.cancel_rounded,
                            size: 20, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 1.5,
                  color: Colors.grey[200],
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //    height: 30,
                //    width: 200,
                //
                //    decoration: BoxDecoration(
                //      color: Colors.white,
                //      border: Border.all(color: Colors.black)
                //    ),
                //
                //    child: DropdownButtonFormField<String>(
                //      value: selectedValue,
                //      items: options.map((String value) {
                //        return DropdownMenuItem<String>(
                //          value: value,
                //          child: Text(value),
                //        );
                //      }).toList(),
                //      onChanged: (String? newValue) {
                //        setState(() {
                //          selectedValue = newValue!;
                //        });
                //      },
                //      // decoration: InputDecoration(
                //      //   hintText: 'Select an option',
                //      //   suffixIcon: Icon(Icons.arrow_drop_down),
                //      // ),
                //    ),
                //  ),
                // Container(
                //   height: 45,
                //   // Adjust the height to fit both Dropdown and TextField
                //   width: 189,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border.all(color: Colors.black),
                //   ),
                //   child: DropdownButtonFormField<String>(
                //     value: selectedValue,
                //     items: options.map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         selectedValue = newValue!;
                //       });
                //     },
                //   ),
                // ),
                Container(
                  height: 35,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyColors.navy)
                  ), child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: TextField(
                      controller: reason,
                      style: TextStyle(
                        color: MyColors.navy,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),decoration: InputDecoration(
                      hintText: "Not Available",
                      border: InputBorder.none,
                    ),
                    ),
                  ),
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text("Please tell us why you believe this is spam.",
                    style: TextStyle(
                      color: MyColors.navy,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 100,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xffDFE8F1)),
                    ), child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: msg,
                      style: TextStyle(
                        color: MyColors.navy,
                      ),

                      decoration: InputDecoration(

                        hintText: 'Message here',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 100.0, top: 10),
                  child: Text("Minimum 20 characters", style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "You have chosen to report this as spam.", style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  // child: OutlinedButton(
                  //   onPressed: () {
                  //     // Get the selected reason and notes
                  //     String selectedReason = selectedValue; // This is the selected reason
                  //     // Get the notes entered in the TextField
                  //     String enteredNotes = ''; // Get the entered notes from your TextField
                  //
                  //     // Assuming you have the necessary IDs for the report
                  //     String userId = 'your_user_id';
                  //     String adId = 'your_ad_id';
                  //     String menuId = 'your_menu_id';
                  //     String submenuId = 'your_submenu_id';
                  //
                  //     // Submit report via API
                  //     submitReport(
                  //       userId: userId,
                  //       adId: adId,
                  //       menuId: menuId,
                  //       submenuId: submenuId,
                  //       reason: selectedReason,
                  //       notes: enteredNotes,
                  //       type: 'your_type', // Set the appropriate type
                  //     );
                  //
                  //     // Close the dialog after submitting the report
                  //     Navigator.pop(dialogContext);
                  //   },
                  //   child: Text('Submit',style: TextStyle(
                  //
                  //   ),),
                  // ),
                  // child: Container(
                  //   height: 40,
                  //   width: 150,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey[200],
                  //     border: Border.all(color: MyColors.grey1),
                  //   ),
                  //
                  //   child: Center(
                  //     child: Text("Submit Report",
                  //         style: TextStyle(
                  //           color: MyColors.navy,
                  //           fontSize: 13,
                  //           fontWeight: FontWeight.w500,
                  //         )
                  //     ),
                  //   ),
                  // ),
                  child:
                  ElevatedButton(
                    onPressed: () {
                      submitReport();
                      print(msg);
                      print(reason);// Replace with entered notes

                      // Call the API function to submit the ad report


                      Navigator.of(context).pop(); // Close the dialog after reporting
                    }, style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(MyColors.navy),
                  ),
                    child: Text('Submit Report'),
                  ),

                ),

              ],
            ),
          );
        }


    );
  }



  String formatPrice(String originalPrice) {
    String priceValue = originalPrice.replaceAll(RegExp(r'[^0-9]'), '');
    int priceNumber = int.tryParse(priceValue) ?? 0;
    String formattedPrice = priceNumber.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
    );
    return formattedPrice;
  }


}






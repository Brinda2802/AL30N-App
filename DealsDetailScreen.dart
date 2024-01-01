import 'package:ai3on/models/DealsDetailsModel.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../ApiUtils.dart';
import '../../MyColors.dart';
import '../../menusample.dart';
import '../NewScreen/SigninScreen.dart';
import '../homescreens/Add.dart';
import '../homescreens/DealsPage.dart';
import '../homescreens/HomePage.dart';
import '../homescreens/NewClass.dart';

class DealsDetailScreen extends StatefulWidget {
  String id;
  DealsDetailScreen(this.id);
  @override
  State<StatefulWidget> createState() {
    return _DealsDetailScreenState(this.id);
  }
}

class _DealsDetailScreenState extends State<DealsDetailScreen> with TickerProviderStateMixin{
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
  TextEditingController locationcontroller = TextEditingController();
  String id;
  // String selectedDealsId="";
  _DealsDetailScreenState(this.id);

  String title = "";
  String discount = "";
  String startdat = "";
  String enddat = "";
  String location = "";
  String description = "";
  String imagess = "";
  String logos = "";
  String tittlee = "";
  String phone = "";
  String city = "";
  String updates = "";
  double lat = 0.0;
  double lng = 0.0;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool isLoading = true;
  ScrollController _scrollController = new ScrollController();
  bool backtoTop = false;
  late FlutterGifController controller;


  ApiUtils apiUtils = ApiUtils();

  List<SimilarDeals> similardealslist = [];
  late Deals deals;
  late Company company;
  @override
  void initState() {
    super.initState();
    controller = FlutterGifController(vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    controller.repeat(
      min: 0,
      max: 103,
      period: const Duration(milliseconds: 500),
    );
    apiUtils.getdealdetails(id).then((value) {
      setState(() {
        imagess = value.images!;
        similardealslist = value.similarDeals!;
        // dealdetailsPojo = value;
        // dealdetailsPojo.images!;
        title = value.deals!.title!;
        discount = value.deals!.discount!;
        startdat = value.deals!.startDate!;
        enddat = value.deals!.endDate!;
        location = value.deals!.arabicAddress!;
        description = value.deals!  .description!;
        imagess = value.images!;
        logos = value.company!.logo!;
        tittlee = value.company!.title!;
        phone = value.company!.phone!;
        city = value.company!.address!;
        updates = value.company!.updatedAt!;
        try{
          lat = double.parse(value.company!.latitude!);
          lng = double.parse(value.company!.longitude!);
        }catch(e){

        }

        isLoading = false;
        print("vijayyyyy");
        print(lat);
        print("vijayyyyy");

        // print("title : ${dealdetailsPojo.deals!.title}");
      });
    });
    _scrollController.addListener(() {
      setState(() {
        backtoTop = _scrollController.offset > 50 ? true : false;
      });
    });
  }
  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );

    return htmlText.replaceAll(exp, '');
  }
  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: isLoading,
      blurEffectIntensity: 0,
      progressIndicator:  GifImage(
        controller: controller,
        image: AssetImage("assets/images/loader.gif"),
      ) ,
      dismissible: false,
      opacity: 0.1,
      child: Scaffold(
        body: isLoading ? SizedBox():SafeArea(
          child: SafeArea(

            child: Stack(
              fit: StackFit.expand,
              children: [
                // image.isEmpty ? SizedBox(width: 50,height: 50,child: CircularProgressIndicator(),) :
                Positioned(top: 0,right: 0,left:0,
                  child:  Image.network(imagess,height:330,fit: BoxFit.fitWidth,)
                ),
                Positioned(top: 30,left: 20, child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back,size: 30,color: Colors.white,))),
                AnimatedPositioned(
                  bottom: 0,left: 0,right: 0,top: backtoTop ? 0:300,
                  duration: Duration(milliseconds: 300),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight:Radius.circular(30),topLeft: Radius.circular(30)),
                        color: Colors.white
                    ),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,top: 30),
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                  color: MyColors.lightblue
                              ),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Icon(Icons.location_on_outlined,color: MyColors.navy,),
                                  ),
                                  SizedBox(width: 5,),
                                  Flexible(flex: 2,child: Text(city,style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.w600,),overflow: TextOverflow.ellipsis,)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 4,
                                    child: Text(tittlee,style: TextStyle(color:  Color(0xff006599),fontWeight: FontWeight.bold,fontSize: 20),)),
                                Flexible(
                                  flex: 2,
                                  child: FavoriteButton(
                                    iconSize: 45,
                                    isFavorite: false,
                                    iconColor: Color(0xffF16622),
                                    // iconDisabledColor: Colors.white,
                                    valueChanged: (_isFavorite) {
                                      apiUtils.addtofavorite("5", id).then((value) {
                                        if(value.status.toString() == "0"){
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
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15,),
                            child: Text(title,style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.bold,fontSize: 18),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15,top: 10),
                            child: Row(
                              children: [
                                Icon(Icons.date_range,color: MyColors.grey1,size: 15),
                                SizedBox(width: 8,),
                                Text(startdat,style: TextStyle(fontWeight: FontWeight.w400,color: MyColors.grey1,fontSize: 13),),
                                SizedBox(width: 5,),
                                Text(enddat,style: TextStyle(fontWeight: FontWeight.w400,color: MyColors.grey1,fontSize: 13),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
                            child: Row(
                              children: [
                                Image.asset("assets/images/fblogoo.png",height: 33,color: MyColors.navy,),
                                SizedBox(width: 8,),
                                Image.asset("assets/images/instaglogo.png",height: 33,color: MyColors.navy,),
                                Spacer(),
                                Text("SHARE",style: TextStyle(color: Color(0xff006599),fontWeight: FontWeight.bold),),
                                SizedBox(width: 8,),
                                Icon(Icons.share,color: Color(0xff006599),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text("Deal Summary",style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.w500),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(removeAllHtmlTags(description),style: TextStyle(color: Color(0XFF2c79a8)),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text('Location',style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.w500,fontSize: 15),),
                          ),
                           SizedBox(width: double.infinity,height: 180,
                            child: GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(lat,lng ),
                                zoom: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15,top: 15),
                            child: Text('Similar Deals',style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.w800,fontSize: 15),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: (2 / 2.4),
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: List.generate(similardealslist.length, (index) {
                                  return Card(
                                    elevation: 5,
                                    color: Color(0xfff8f8f8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        // print(dealslist[index].id!);
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) =>
                                                DealsDetailScreen(similardealslist[index].id!)));
                                      },
                                      child: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.center ,
                                        children: [
                                          Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                                                image: DecorationImage(image: NetworkImage(similardealslist[index].image!), fit: BoxFit.fill)),
                                          ),
                                          // SizedBox(
                                          //   height: 12,
                                          // ),
                                          Container(
                                              height: 25,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: MyColors.darkblue
                                              ),
                                              child: Align(alignment: Alignment.center,child: Text(similardealslist[index].title!,
                                                style: TextStyle(fontWeight: FontWeight.w600,color: MyColors.navy,fontSize: 14),overflow: TextOverflow.ellipsis,))),
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
                                            padding: const EdgeInsets.only(right: 7, top: 5,),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.location_on_outlined, size: 22, color: Colors.black54,),
                                                Text(similardealslist[index].city!.isNotEmpty ? similardealslist[index].city! : "Dubai",
                                                  style: TextStyle(fontSize: 13, color: Color(0xff6e90ae)),
                                                ),
                                                // Spacer(),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 3,),
                                          Container(
                                            height: 3,
                                            width: 160,
                                            color: Color(0xfffdcc0c),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 7,right: 7,top: 3),
                                            child: Row(
                                              children: [
                                                Text("Discount",style: TextStyle(color: Color(0xffff6347),fontWeight: FontWeight.bold),),
                                                SizedBox(width: 3,),
                                                Text(similardealslist[index].discount!,
                                                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffff6347,))),
                                                Text(" %",
                                                    style: TextStyle(color: Color(0xffff6347),fontWeight: FontWeight.bold)),
                                                Spacer(),
                                                Icon(Icons.favorite,color: MyColors.mainorange,size: 20,),
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
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Flexible(
                          //       flex: 3,
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(15),
                          //         child: Container(
                          //           // height:45,
                          //           // width: 160,
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(10),
                          //             border: Border.all(
                          //                 color: Color(0xff006599),
                          //                 width: 1.5
                          //             ),
                          //           ),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(10),
                          //             child: Row(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                 Image.asset("assets/images/pin.png",height: 25,color: Color(0xff006599),),
                          //                 SizedBox(width: 10,),
                          //                 Text("Direction",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff006599)),)
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     Flexible(
                          //       flex: 3,
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(15),
                          //         child: Container(
                          //           // height:45,
                          //           // width: 165,
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(15),
                          //               color: Color(0xff006599)
                          //           ),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(12),
                          //             child: Row(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                 Icon(Icons.phone_outlined,color: Colors.white,),
                          //                 SizedBox(width: 10,),
                          //                 Text("Call Us",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                         Padding(
                           padding: const EdgeInsets.all(9.0),
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
                                              color: const Color(0xff006599),
                                              width: 1.5
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Icon(Icons.directions_outlined,color: Colors.blue,),
                                              Image.asset("assets/images/pin.png",height: 25,color: Color(0xff006599),),
                                              SizedBox(width: 10,),
                                              Text("Direction",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff006599)),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        // height:45,
                                        // width: 165,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: const Color(0xff006599)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.phone_outlined,color: Colors.white,),
                                              SizedBox(width: 5,),
                                              Text("Call Us",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                         ),


                          SizedBox(height: 20,)
                          // Padding(
                          //   padding: const EdgeInsets.all(15),
                          //   child: Row(
                          //     children: [
                          //       Container(
                          //         height:45,
                          //         width: 160,
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(10),
                          //           border: Border.all(
                          //               color: Color(0xff006599),
                          //               width: 1.5
                          //           ),
                          //         ),
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             // Icon(Icons.directions_outlined,color: Colors.blue,),
                          //             Image.asset("assets/images/pin.png",height: 25,color: Color(0xff006599),),
                          //             SizedBox(width: 10,),
                          //             Text("Direction",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff006599)),)
                          //           ],
                          //         ),
                          //       ),
                          //       Spacer(),
                          //       Container(
                          //         height:45,
                          //         width: 165,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(10),
                          //             color: Color(0xff006599)
                          //         ),
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Icon(Icons.phone_outlined,color: Colors.white,),
                          //             SizedBox(width: 5,),
                          //             Text("Call Us",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
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
  void _onMapCreated(GoogleMapController googleMapController) {

    final marker = Marker(
      markerId: MarkerId(title),
      position: LatLng(lat,lng),
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
}

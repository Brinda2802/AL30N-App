import 'package:ai3on/ApiUtils.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../MyColors.dart';
import '../../menusample.dart';
import '../../models/ParticularRentViewModel.dart';
import '../NewScreen/SigninScreen.dart';
import '../homescreens/Add.dart';
import '../homescreens/DealsPage.dart';
import '../homescreens/HomePage.dart';
import '../homescreens/NewClass.dart';

class RentDetailss extends StatefulWidget {
  String id;
  RentDetailss(this.id);
  @override
  State<StatefulWidget> createState() {
    return _RentDetailssState(this.id);
  }
}

class _RentDetailssState extends State<RentDetailss> with TickerProviderStateMixin{
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


  List<SimilarAds> similarsalesaddlist = [];
  List<RentDetails> rentDetails = [];
  List<String> imageslist =[];

  ApiUtils apiUtils = ApiUtils();
  String id;
  _RentDetailssState(this.id);
  String title = "";
  String price="";
  String describeYourProperty="";
  String size="";
  String bedrooms="";
  String bathrooms="";
  String isItFurnished="";
  String rentIsPaid="";
  String rERALandlordName="";
  String rERAPropertyStatus="";
  String occupancyStatus="";
  String neighbourhood="";
  String image = "";
  String city = "";
  String lat = "";
  String lng = "";
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool isLoading = true;
  ScrollController _scrollController = new ScrollController();
  bool backtoTop = false;

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
    apiUtils.getParticularProduct(id).then((value) {
      setState(() {
        title = value.title!;
        price=value.price!;
        size=value.size!;
        bedrooms=value.bedrooms!;
        bathrooms=value.bathrooms!;
        similarsalesaddlist = value.similarAds!;
        rentDetails = value.rentDetails!;
        imageslist = value.images!;
        city = value.city!;
        lat = value.latitude!;
        lng = value.longitude!;
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
      progressIndicator:  GifImage(
        controller: controller,
        image: AssetImage("assets/images/loader.gif"),
      ) ,       dismissible: false,
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
        body: isLoading ? SizedBox() : SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              // image.isEmpty ? SizedBox(width: 50,height: 50,child: CircularProgressIndicator(),):
              Positioned(top: 0,right: 0,left:0,
                child: SizedBox(
                  height: 350,
                  width: double.infinity,
                  child:Swiper(
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
                // Image.network(image,height:350,fit: BoxFit.fitHeight,)
              ),
              Positioned(top: 30,left: 20, child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,size: 30,color: Colors.white,))),
              AnimatedPositioned(
                bottom: 0,left: 0,right: 0,top: backtoTop ? 0:300,
                duration: Duration(milliseconds: 400),
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: backtoTop ? Radius.zero : Radius.circular(30),topLeft: backtoTop ? Radius.zero : Radius.circular(30)),
                      color: Colors.white
                  ),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Icon(Icons.location_on,color: MyColors.mainorange,size: 17,),
                              SizedBox(width: 10,),
                              Text(city,style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.w400,fontSize: 15),),
                              Spacer(),
                              FavoriteButton(
                                iconSize: 45,
                                isFavorite: false,
                                iconColor: Color(0xffF16622),
                                // iconDisabledColor: MyColors.mainorange,
                                valueChanged: (_isFavorite) {
                                  apiUtils.addtofavorite("4", id).then((value) {
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
                              // Icon(Icons.favorite_border,color: MyColors.mainorange,)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: Row(
                            children: [
                              Text(title,style: TextStyle(color: Color(0xff006599),fontWeight: FontWeight.bold,fontSize: 15),overflow: TextOverflow.ellipsis,),
                              Spacer(),
                              Text("Share",style: TextStyle(color: Color(0xff006599),fontWeight: FontWeight.w500,fontSize: 13),),
                              SizedBox(width: 5,),
                              Image.asset("assets/images/share.png",color: Color(0xff006599),height: 20,)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,top: 5),
                          child: Row(
                            children: [
                              Text('AED',style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.bold,fontSize: 15),),
                              SizedBox(width: 5,),
                              Text(formatPrice(price),style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.bold,fontSize: 15),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,top: 15),
                          child: Row(
                            children: [
                              Image.asset("assets/images/bed.png",height: 20,color: Colors.grey,),
                              const SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Beds",style: TextStyle(color: Colors.grey,fontSize: 13),),
                                  Text(bedrooms,style:  TextStyle(color: Colors.grey),)
                                ],
                              ),
                              const SizedBox(width: 30,),
                              Image.asset("assets/images/bath.png",height: 20,color: Colors.grey),
                              const SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Baths",style: TextStyle(color: Colors.grey,fontSize: 13),),
                                  Text(bathrooms,style: const TextStyle(color: Colors.grey,fontSize: 13),)
                                ],
                              ),
                              const SizedBox(width: 30,),
                              Image.asset("assets/images/scale.png",height: 20,color: Colors.grey,),
                              const SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Sqft",style: TextStyle(color: Colors.grey,fontSize: 13),),
                                  Text(size,style: const TextStyle(color: Colors.grey,fontSize: 13),)
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5,),
                        ListView.builder(
                          itemCount: rentDetails.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return   Padding(
                              padding: const EdgeInsets.only(left: 15,top: 15,bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(rentDetails[index].name!,style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.w400),),
                                  SizedBox(height: 15,),
                                  SizedBox(
                                    width: 300,
                                    child:rentDetails[index].value!.startsWith("http") ?
                                    SelectableLinkify(
                                      onOpen: _onOpen,
                                      text:rentDetails[index].value!,
                                    ) :
                                    Text(rentDetails[index].value!,style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w400,fontSize: 13),
                                      maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        Divider(height: 2,thickness: 1,indent: 15,endIndent: 15,color: Colors.blue[50],),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text('Location',style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.w500,fontSize: 15),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,bottom: 15),
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined,color: MyColors.grey1,size: 15,),
                              SizedBox(width:5,),
                              Text(city,style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w600,fontSize: 15),),
                            ],
                          ),
                        ),
                        lat.isEmpty ?SizedBox(): SizedBox(width: double.infinity,height: 180,
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,

                            initialCameraPosition: CameraPosition(

                              target: LatLng(double.parse(lat),double.parse(lng)),
                              zoom: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                          child: Row(
                            children: [
                              Text('Is there an issue?',style: TextStyle(color: MyColors.grey1,),),
                              Spacer(),
                              GestureDetector(
                                onTap: (){
                                  _showCustomPopup(context);
                                },
                                  child: Text('Report this ad',style: TextStyle(color: MyColors.mainorange,fontSize: 12),))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 12),
                          child: Row(
                            children: [
                              Flexible(
                                flex:2,
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
                        Padding(
                          padding: const EdgeInsets.only(left: 15,top: 15),
                          child: Text('Similar Ads',style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.bold,fontSize: 15),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 160,
                          child: ListView.builder(
                            itemCount: similarsalesaddlist.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5,top: 8),
                                    child: SizedBox(
                                      width: 120,
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          side: BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 1.3
                                          ),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            // print(dealslist[index].id!);
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) =>
                                                    RentDetailss(similarsalesaddlist[index].id!)));
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 90,
                                                // width: 160,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                                                  image: DecorationImage(image: NetworkImage(similarsalesaddlist[index].image!),fit: BoxFit.fill),
                                                ),
                                                // child: Padding(
                                                //   padding: const EdgeInsets.all(5),
                                                //   child: Image.network(similarsalesaddlist[index].image!),
                                                // ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5,top: 8),
                                                child: Row(
                                                  children: [
                                                    Text('AED',style:  TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.bold,fontSize: 13),),
                                                    SizedBox(width: 5,),
                                                    Text(similarsalesaddlist[index].formatPrice(similarsalesaddlist[index].price??''),style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.bold,fontSize: 13),),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 5,top: 5),
                                                child: Text(similarsalesaddlist[index].title!,overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 11,color: Colors.black38,),),
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
              )
            ],
          ),

        ),
      ),
    );
  }
  void _showCustomPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Some Context'),
        content: Container(
        width: double.minPositive,
        child: ListView(
        shrinkWrap: true,
        children: [
        ListTile(
        title: Text('Spam'),
        onTap: () {
        // Handle Spam option selection
        Navigator.pop(context);
        },
        ),
        ListTile(
        title: Text('Fraud'),
        onTap: () {
        // Handle Fraud option selection
        Navigator.pop(context);
        },
        ),
        // Add other options similarly

        // Submit button
        ElevatedButton(
        onPressed: () {
        // Handle submit button action
        Navigator.pop(context);
        },
        child: Text('Submit'),
        ),
        // Cancel button
        TextButton(
        onPressed: () {
        // Handle cancel button action
        Navigator.pop(context);
        },
        child: Text('Cancel'),
        ),
        ],
        ),
        ));

      },
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
      position: LatLng(double.parse(lat),double.parse(lng)),
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


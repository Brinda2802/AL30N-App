import 'package:ai3on/screens/ViewAllScreen/FilterPage.dart';
import 'package:ai3on/screens/details/RentDetails.dart';
import 'package:ai3on/screens/details/SalesDetails.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'dart:async';

import 'ApiUtils.dart';
import 'MyColors.dart';
import 'models/HomePageModel.dart';
import 'models/Productdetail.dart';

class propertyforsaleview extends StatefulWidget {
  String s;
  String id;

  propertyforsaleview(this.id, this.s);

  @override
  State<StatefulWidget> createState() {
    return _propertyforsaleviewState(this.s,this.id);
  }
}

class _propertyforsaleviewState extends State<propertyforsaleview>with TickerProviderStateMixin
{
  List<String> namess = [
    "Property Type",
    "Price Range",
    "Rent",
    "All Residential",
    "Bedrooms",
    "Bathrooms",
    "All Furnishing types"
  ];
  String s;
  List<Productdetail> productslist = [];
  ApiUtils apiUtils = ApiUtils();
  List<SaleList> salessList = [];
  List<RentsList> rentsList = [];
  List<MotorsList> motorsList = [];
  late FlutterGifController controller;

  String id;

  _propertyforsaleviewState(this.id,this.s);



  bool isLoading = true;

  List<String> choices = <String>[
    "Item 1",
    "Item 2",
    "Item 3",
  ];


  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   controller = FlutterGifController(vsync: this,
  //     duration: const Duration(milliseconds: 500),
  //   );
  //   controller.repeat(
  //     min: 0,
  //     max: 203,
  //     period: const Duration(milliseconds: 500),
  //   );
  //   if (s == "rent") {
  //     apiUtils.ViewRentList().then((value) {
  //       setState(() {
  //         isLoading = false;
  //         rentsList = value.rentsList!.cast<RentsList>();
  //       });
  //     });
  //   } else if (s == "sale") {
  //     apiUtils.ViewSaleList().then((value) {
  //       setState(() {
  //         isLoading = false;
  //
  //         salessList = value.saleList!.cast<SaleList>();
  //       });
  //     });
  //   } else if (s == "motor") {
  //     apiUtils.ViewMotorList().then((value) {
  //       setState(() {
  //         isLoading = false;
  //
  //         motorsList = value.motorsList!.cast<MotorsList>();
  //       });
  //     });
  //   }
  // }
  void initState() {
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

    // Start loading data
    if (s == "rent") {
      apiUtils.ViewRentList().then((value) {
        setState(() {
          isLoading = false;
          rentsList = value.rentsList!.cast<RentsList>();
        });
      });
    } else if (s == "sale") {
      apiUtils.ViewSaleList().then((value) {
        setState(() {
          isLoading = false;
          salessList = value.saleList!.cast<SaleList>();
        });
      });
    } else if (s == "motor") {
      apiUtils.ViewMotorList().then((value) {
        setState(() {
          isLoading = false;
          motorsList = value.motorsList!.cast<MotorsList>();
        });
      });
    }

    // Stop loading after 5 seconds
    Timer(Duration(seconds: 5), () {
      if (mounted) { // Check if the widget is still mounted
        setState(() {
          isLoading = false;
        });
      }
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
      child:
      Scaffold(
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
            title: Text("Sales List",style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
            actions: [
              // Image.asset("assets/images/brandlogo.png",height: 20,)
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 35, right: 35, top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FilterPage()));
                          },
                          child: Container(
                            // height: 30,
                            // width: ,
                            // decoration: BoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/images/filterr.png", height: 15,
                                      color: MyColors.navy,)),
                                SizedBox(width: 15,),
                                Text("Filters", style: TextStyle(
                                    color: MyColors.navy, fontSize: 18),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(height: 35,
                            child: VerticalDivider(
                              color: Colors.grey, thickness: 1.2,)),
                        SizedBox(width: 20,),
                        GestureDetector(
                          onTap: () {
                            _showPopupMenu();
                          },
                          child: Container(
                            // height: 25,
                            // width: 25,
                            // decoration: BoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/images/sortby.png", height: 15,
                                      color: MyColors.navy,)),
                                SizedBox(width: 15,),
                                Text("Sort by", style: TextStyle(
                                  color: MyColors.navy, fontSize: 18,),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                 SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: salessList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        String image = "";

                        try {
                          image = salessList[index].image!.split(",")[0];
                        } catch (e) {
                          image = salessList[index].image!;
                        }
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      child: Container(
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
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>SalesDetailss(
                                                    salessList[index]
                                                        .saleId!)));


                                      },
                                    ),
                                    // Padding(padding: EdgeInsets.only(top: 20)),
                                    Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: MyColors.darkblue
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(salessList[index].title!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.navy,
                                                fontSize: 18),),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8, top: 8),
                                      child: Row(
                                        children: [
                                          Text("Beds :", style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xffc3c2ca),
                                              fontWeight: FontWeight.bold),),
                                          SizedBox(width: 5,),
                                          Text(salessList[index].bedroom!,
                                            style: TextStyle(fontSize: 15,
                                                color: Color(0xffc3c2ca),
                                                fontWeight: FontWeight.bold),),
                                          Spacer(),
                                          Text("30 Min ago", style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xffc3c2ca),
                                              fontWeight: FontWeight.bold),),
                                          SizedBox(width: 5,),
                                          FavoriteButton(
                                            iconSize: 45,
                                            isFavorite: false,
                                            // iconDisabledColor: Colors.white,
                                            valueChanged: (_isFavorite) {
                                              apiUtils.addtofavorite("3", id)
                                                  .then((value) {
                                                if (value.status.toString() ==
                                                    "0") {
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
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 3),
                                      child: Row(
                                        children: [
                                          Text("Baths :", style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xffc3c2ca),
                                              fontWeight: FontWeight.bold),),
                                          SizedBox(width: 5,),
                                          Text(salessList[index].bathroom!,
                                            style: TextStyle(fontSize: 15,
                                                color: Color(0xffc3c2ca),
                                                fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,
                                          right: 8,
                                          top: 3,
                                          bottom: 5),
                                      child: Row(
                                        children: [
                                          Text("City :", style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xffc3c2ca),
                                              fontWeight: FontWeight.bold),),
                                          SizedBox(width: 5,),
                                          Text(salessList[index].city!,
                                            style: TextStyle(fontSize: 15,
                                                color: Color(0xffc3c2ca),
                                                fontWeight: FontWeight.bold),),
                                          Spacer(),
                                          Text(salessList[index].price!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffe37640),
                                                fontSize: 18),),
                                        ],
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Row(
                                    //     children: [
                                    //       Image.asset("assets/images/bed.png",height: 18,color: Colors.grey,),
                                    //       SizedBox(width: 3,),
                                    //       Text(saleList[index].bedroom!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                    //       Text("bed",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                    //       SizedBox(width: 10,),
                                    //       Image.asset("assets/images/bath.png",height: 18,color: Colors.grey),
                                    //       SizedBox(width: 3,),
                                    //       Text(saleList[index].bathroom!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                    //       Text("Bath",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                    //       SizedBox(width: 10,),
                                    //       Icon(Icons.location_on_outlined,color: Colors.grey,size: 18,),
                                    //       SizedBox(width: 3,),
                                    //       Text(saleList[index].city!,style: TextStyle(fontSize: 13,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),)
                                    //     ],
                                    //   ),
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Row(
                                    //     children: [
                                    //       Container(
                                    //         height:35,
                                    //         width: 140,
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
                                    //             Image.asset("assets/images/emaa.png",height: 20,),
                                    //             // Icon(Icons.message_outlined,color: Color(0xff006599),),
                                    //             SizedBox(width: 10,),
                                    //             Text("Message",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff006599)),)
                                    //           ],
                                    //         ),
                                    //       ),
                                    //       Spacer(),
                                    //       Container(
                                    //         height:35,
                                    //         width: 140,
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
                            )
                          ],
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          )
      ),
    );
  }

  void _showPopupMenu() async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: [
        PopupMenuItem(
          onTap: (){
            Navigator.pop(context);
          },
          child: Text("Oldest first",style: TextStyle(color: MyColors.navy),),
        ),
        PopupMenuItem(
          onTap: (){
            Navigator.pop(context);
          },
          child: Text("Newest first",style: TextStyle(color: MyColors.navy),),
        ),
        PopupMenuItem(
          onTap: (){
            Navigator.pop(context);
          },
          child: Text("Low to High discount",style: TextStyle(color: MyColors.navy),),
        ),
        PopupMenuItem(
          onTap: (){
            Navigator.pop(context);
          },
          child: Text("Hight to Low discount",style: TextStyle(color: MyColors.navy),),
        ),
      ],
      elevation: 8.0,
    );
  }
}
//{
//   List<String> namess = [
//     "Property Type",
//     "Price Range",
//     "Rent",
//     "All Residential",
//     "Bedrooms",
//     "Bathrooms",
//     "All Furnishing types"
//   ];
//   String s;
//   List<Productdetail> productslist = [];
//   ApiUtils apiUtils = ApiUtils();
//   List<SaleList> salessList = [];
//   late FlutterGifController controller;
//   String id;
//
//   _propertyforsaleviewState(this.s, this. id);
//
//
//
//   bool isLoading = true;
//
//   List<String> choices = <String>[
//     "Item 1",
//     "Item 2",
//     "Item 3",
//   ];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller = FlutterGifController(vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     controller.repeat(
//       min: 0,
//       max: 203,
//       period: const Duration(milliseconds: 500),
//     );
//     apiUtils.ViewSaleList().then((value) {
//       setState(() {
//         isLoading = false;
//
//         salessList = value.saleList!.cast<SaleList>();
//       });
//     });
//     }
//   }
//
//   Widget build(BuildContext context) {
//
//     var isLoading;
//     return BlurryModalProgressHUD(
//         inAsyncCall: isLoading,
//         blurEffectIntensity: 1,
//         progressIndicator: GifImage(
//         controller: controller,
//         image: AssetImage("assets/images/loader.gif"),
//     ),
//     dismissible: false,
//     opacity: 0.1,
//     child:Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration:
//           BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/footer.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 2,
//         centerTitle: true,
//         title: Text("Sales List",style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),),
//         actions: [
//           // Image.asset("assets/images/brandlogo.png",height: 20,)
//         ],
//       ),
//       body:SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.only(left: 35, right: 35, top: 25),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => FilterPage()));
//                     },
//                     child: Container(
//                       // height: 30,
//                       // width: ,
//                       // decoration: BoxDecoration(),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Align(alignment: Alignment.center,
//                               child: Image.asset(
//                                 "assets/images/filterr.png", height: 15,
//                                 color: MyColors.navy,)),
//                           SizedBox(width: 15,),
//                           Text("Filters", style: TextStyle(
//                               color: MyColors.navy, fontSize: 18),),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 20,),
//                   Container(height: 35,
//                       child: VerticalDivider(
//                         color: Colors.grey, thickness: 1.2,)),
//                   SizedBox(width: 20,),
//                   GestureDetector(
//                     onTap: () {
//                       _showPopupMenu();
//                     },
//                     child: Container(
//                       // height: 25,
//                       // width: 25,
//                       // decoration: BoxDecoration(),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Align(alignment: Alignment.center,
//                               child: Image.asset(
//                                 "assets/images/sortby.png", height: 15,
//                                 color: MyColors.navy,)),
//                           SizedBox(width: 15,),
//                           Text("Sort by", style: TextStyle(
//                             color: MyColors.navy, fontSize: 18,),),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ) ,
//     )
//     );
//     }
//
//
// void _showPopupMenu() async {
//   await showMenu(
//     context: context,
//     position: RelativeRect.fromLTRB(100, 100, 100, 100),
//     items: [
//       PopupMenuItem(
//         onTap: (){
//           Navigator.pop(context);
//         },
//         child: Text("Oldest first",style: TextStyle(color: MyColors.navy),),
//       ),
//       PopupMenuItem(
//         onTap: (){
//           Navigator.pop(context);
//         },
//         child: Text("Newest first",style: TextStyle(color: MyColors.navy),),
//       ),
//       PopupMenuItem(
//         onTap: (){
//           Navigator.pop(context);
//         },
//         child: Text("Low to High discount",style: TextStyle(color: MyColors.navy),),
//       ),
//       PopupMenuItem(
//         onTap: (){
//           Navigator.pop(context);
//         },
//         child: Text("Hight to Low discount",style: TextStyle(color: MyColors.navy),),
//       ),
//     ],
//     elevation: 8.0,
//   );
// }
//
//
// }

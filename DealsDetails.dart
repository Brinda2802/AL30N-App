// import 'package:ai3on/screens/homescreens/DealsPage.dart';
// import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
// import 'package:card_swiper/card_swiper.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// import '../../ApiUtils.dart';
// import '../../MyColors.dart';
// import '../../models/DealsDetailsModel.dart';
//
// class DealsDetails extends StatefulWidget {
//
//   // String mDealsId;
//
//   // DealsDetails(String dealsId){
//   //   mDealsId = dealsId;
//   // }
//
//   String id;
//   DealsDetails(this.id);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _DealsDetailsState(this.id);
//   }
//
// }
//
// class _DealsDetailsState extends State<DealsDetails> {
//
//   TextEditingController locationcontroller = TextEditingController();
//   String id;
//   // String selectedDealsId="";
//   _DealsDetailsState(this.id);
//
//   String title = "";
//   String discount = "";
//   String startdat = "";
//   String enddat = "";
//   String location = "";
//   String description = "";
//   String imagess = "";
//   String logos = "";
//   String tittlee = "";
//   String phone = "";
//   String city = "";
//   String updates = "";
//   String lat = "";
//   String lng = "";
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//   bool isLoading = true;
//
//
//   ApiUtils apiUtils = ApiUtils();
//
//   List<SimilarDeals> similardealslist = [];
//   late Deals deals;
//   late Company company;
//
//
//   // DealsDetailsModel dealdetailsPojo = DealsDetailsModel();
//
//   // _DealsDetailsState(String dealsId){
//   //
//   //   selectedDealsId = dealsId;
//   //
//   //   print("Current Delas Id : $selectedDealsId");
//   // }
//
//
//   @override
//   void initState() {
//     super.initState();
//     apiUtils.getdealdetails(id).then((value) {
//       setState(() {
//         imagess = value.images!;
//         similardealslist = value.similarDeals!;
//         // dealdetailsPojo = value;
//         // dealdetailsPojo.images!;
//         title = value.deals!.title!;
//         discount = value.deals!.discount!;
//         startdat = value.deals!.startDate!;
//         enddat = value.deals!.endDate!;
//         location = value.deals!.arabicAddress!;
//         description = value.deals!  .description!;
//         imagess = value.images!;
//         logos = value.company!.logo!;
//         tittlee = value.company!.title!;
//         phone = value.company!.phone!;
//         city = value.company!.address!;
//         updates = value.company!.updatedAt!;
//         isLoading = false;
//         // lat = value.latitude!;
//         // lng = value.longitude!;
//         // print("title : ${dealdetailsPojo.deals!.title}");
//       });
//     });
//   }
//
//
//
//   // List<String> images = ["assets/images/bbq1.jpeg", "assets/images/carr.jpg", "assets/images/ro5.jpg"];
//
//   @override
//   Widget build(BuildContext context) {
//     return BlurryModalProgressHUD(
//       inAsyncCall: isLoading,
//       blurEffectIntensity: 1,
//       progressIndicator:LoadingAnimationWidget.halfTriangleDot(color: MyColors.navy, size: 100) ,
//       dismissible: false,
//       opacity: 0.1,
//       child: Scaffold(
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: isLoading ? Container():
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15,top: 20),
//                     child: Row(
//                       children: [
//                         InkWell(
//                             onTap: (){
//                               Navigator.pop(context);
//                             },
//                             child: Icon(Icons.arrow_back)),
//                         SizedBox(width: 15,),
//                         Text("DealsDetails",style: TextStyle(fontWeight: FontWeight.bold),)
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   Center(child: Image.network(imagess,height: 200,fit: BoxFit.fill)),
//                   // SizedBox(
//                   //   height: 250,
//                   //   width: double.infinity,
//                   //   child:Swiper(
//                   //     itemBuilder: (context, index) {
//                   //       return SizedBox(
//                   //         child: Card(
//                   //           child: Image.network(
//                   //             imagess,
//                   //             fit: BoxFit.fill,
//                   //           ),
//                   //         ),
//                   //       );
//                   //     },
//                   //     indicatorLayout: PageIndicatorLayout.COLOR,
//                   //     autoplay: true,
//                   //     itemCount: imagess.length,
//                   //     pagination: const SwiperPagination(),
//                   //     control: const SwiperControl(color: Colors.black),
//                   //   ),
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Text("Discount",style: TextStyle(color: Color(0xffff6347)),),
//                         SizedBox(width: 5,),
//                         Text(discount,style: TextStyle(color: Color(0xffff6347)),),
//                         Text("% dine in or takeaway order",style: TextStyle(color: Color(0xffff6347)),)
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Icon(Icons.date_range),
//                         Text(startdat,style: TextStyle(fontWeight: FontWeight.bold),),
//                         SizedBox(width: 5,),
//                         Text(enddat,style: TextStyle(fontWeight: FontWeight.bold),)
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text("Deal Summary",style: TextStyle(color: Color(0xffff6347)),),
//                   ),
//                   // Padding(
//                   //   padding: const EdgeInsets.all(8.0),
//                   //   child: Text(description,style: TextStyle(color: Color(0XFF2c79a8)),),
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text("Location",style: TextStyle(color: Color(0XFF2c79a8),fontWeight: FontWeight.bold,fontSize: 18),),
//                   ),
//                   // Padding(
//                   //   padding: const EdgeInsets.all(8.0),
//                   //   child: TextFormField(
//                   //     controller: locationcontroller,
//                   //     decoration: InputDecoration(
//                   //       border: OutlineInputBorder(
//                   //         borderRadius: BorderRadius.circular(10),
//                   //       ),
//                   //       prefixIcon: Icon(
//                   //         Icons.location_on
//                   //       ),
//                   //       hintText: 'location',
//                   //     ),
//                   //     onTap: (){
//                   //       setState(() {
//                   //         location;
//                   //       });
//                   //     },
//                   //   ),
//                   // ),
//                   // lat.isEmpty ?SizedBox(): SizedBox(width: double.infinity,height: 180,
//                   //   child: GoogleMap(
//                   //     onMapCreated: _onMapCreated,
//                   //     initialCameraPosition: CameraPosition(
//                   //       target: LatLng(double.parse(lat),double.parse(lng)),
//                   //       zoom: 12,
//                   //     ),
//                   //   ),
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Text("Is there issue?",style: TextStyle(color: Color(0xff8d94a8)),),
//                         Spacer(),
//                         Text("Report this Ad Now",style: TextStyle(color: Color(0xff8d94a8)),)
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(15),
//                     child: Container(
//                       // height: 400,
//                       color: Color(0xfff8f8f8),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Row(
//                             children: [
//                               CachedNetworkImage(
//                                 imageUrl:logos,
//                                 errorWidget: (context, url, error) => Icon(Icons.error),width: 50,height: 50
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Flexible(
//                                   child: Text(tittlee,maxLines: 3,
//                                     style: TextStyle(color: Color(0xff2c79a8),fontWeight: FontWeight.bold,fontSize: 20),),
//                                 ),
//                               ),
//                             ],
//                           ),
//
//
//                           Row(
//                             children: [
//                               Flexible(
//                                 flex: 2,
//                                 child: Container(
//                                   height: 45,
//                                   width: 220,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Color(0xff17578f),
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(Icons.phone,color: Colors.white,),
//                                       SizedBox(width: 8,),
//                                       Text(phone,style: TextStyle(color: Colors.white),)
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 5,),
//                               Flexible(
//                                 flex: 2,
//                                 child: Container(
//                                   height: 45,
//                                   width: 220,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       border: Border.all(color: Color(0xff17578f),width: 2)
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(Icons.pin_drop,color: Color(0xff8d94a8),),
//                                       SizedBox(width: 8,),
//                                       Flexible(child: Text(city,style: TextStyle(color: Color(0xff8d94a8)),))
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 18,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.asset("assets/images/face.png",height: 25,),
//                               SizedBox(width: 10,),
//                               Image.asset("assets/images/insta.png",height: 25,)
//                             ],
//                           ),
//                           SizedBox(height: 8,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text("Last Updated on"),
//                               SizedBox(width: 5,),
//                               Text(updates)
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text("Similar Deals",style: TextStyle(color:Color(0xff30618c),fontSize: 20,fontWeight: FontWeight.bold),),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: GridView.count(
//                         crossAxisCount: 2,
//                         childAspectRatio: (2/2.7),
//                         crossAxisSpacing: 5,
//                         mainAxisSpacing: 5,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         children: List.generate(similardealslist.length, (index) {
//                           return Card(
//                             elevation: 5,
//                             color: Color(0xfff8f8f8),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   height: 120,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
//                                       image: DecorationImage(image: NetworkImage(similardealslist[index].image!),fit: BoxFit.fill)
//                                   ),
//                                 ),
//                                 // Image.network(similardealslist[index].image!,fit: BoxFit.fill,),
//                                 SizedBox(height: 10,),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 8.0),
//                                   child: Text(similardealslist[index].title!,style: TextStyle(color: Color(0xff6e90ae)),),
//                                 ),
//                                 SizedBox(height: 15,),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.location_on_outlined),
//                                       Text(similardealslist[index].city!),
//                                       Spacer(),
//                                       Column(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Text(similardealslist[index].discount!,style: TextStyle(color: Color(0xffff6347))),
//                                               Text("%",style: TextStyle(color: Color(0xffff6347)))
//                                             ],
//                                           ),
//                                           Text("OFF",style: TextStyle(color: Color(0xffff6347)) )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         })
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//       ),
//     );
//   }
//   void _onMapCreated(GoogleMapController googleMapController) {
//
//     final marker = Marker(
//       markerId: MarkerId(title),
//       position: LatLng(double.parse(lat),double.parse(lng)),
//       // icon: BitmapDescriptor.,
//       infoWindow: InfoWindow(
//         title: title,
//         snippet: city,
//       ),
//     );
//
//     setState(() {
//       markers[MarkerId(title)] = marker;
//     });
//   }
// }

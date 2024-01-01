// import 'package:ai3on/ApiUtils.dart';
// import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
//
// import '../../MyColors.dart';
// import '../../models/ParticularRentViewModel.dart';
//
// class ProductDetails extends StatefulWidget {
//   String id;
//   ProductDetails(this.id);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _ProductDetailsState(this.id);
//   }
// }
//
// class _ProductDetailsState extends State<ProductDetails> {
//   List<SimilarAds> similarsalesaddlist = [];
//
//   ApiUtils apiUtils = ApiUtils();
//   String id;
//   _ProductDetailsState(this.id);
//   String title = "";
//   String pricePerYear="";
//   String describeYourProperty="";
//   String size="";
//   String bedrooms="";
//   String bathrooms="";
//   String isItFurnished="";
//   String rentIsPaid="";
//   String rERALandlordName="";
//   String rERAPropertyStatus="";
//   String occupancyStatus="";
//   String neighbourhood="";
//   String image = "";
//   String city = "";
//   String lat = "";
//   String lng = "";
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//   bool isLoading = true;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     apiUtils.getParticularProduct(id).then((value) {
//       setState(() {
//
//          title = value.rents!.title!;
//          pricePerYear=value.rents!.pricePerYear!;
//          describeYourProperty=value.rents!.describeYourProperty!;
//         size=value.rents!.size!;
//         bedrooms=value.rents!.bedrooms!;
//         bathrooms=value.rents!.bathrooms!;
//        // rentIsPaid=value.rents!.rentIsPaid!;
//         rERALandlordName=value.rents!.rERALandlordName!;
//         image = value.rents!.addPictures!;
//         rERAPropertyStatus=value.rents!.rERAPropertyStatus!;
//        // occupancyStatus=value.rents!.occupancyStatus!;
//         neighbourhood=value.rents!.neighbourhood!;
//          similarsalesaddlist = value.similarAds!;
//
//          //   isItFurnished=value.rents!.isItFurnished!;
//          city = value.city!;
//          lat = value.latitude!;
//          lng = value.longitude!;
//          print(lat);
//          isLoading = false;
//
//       });
//
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return BlurryModalProgressHUD(
//       inAsyncCall: isLoading,
//       blurEffectIntensity: 1,
//       progressIndicator:LoadingAnimationWidget.halfTriangleDot(color: MyColors.bule1, size: 100) ,
//       dismissible: false,
//       opacity: 0.1,
//       child: Scaffold(
//         body: SafeArea(
//           child: Stack(
//             children: [
//               // image.isEmpty ? SizedBox(width: 50,height: 50,child: CircularProgressIndicator(),):
//               Positioned(top: 0,right: 0,left:0,child: Image.network(image,height:350,fit: BoxFit.fitHeight,)),
//               Positioned(top: 30,left: 20, child: GestureDetector(
//                 onTap: (){
//                   Navigator.pop(context);
//                 },
//                   child: Icon(Icons.arrow_back,size: 30,color: Colors.white,))),
//               Positioned(
//                 bottom: 0,left: 0,right: 0,
//                 child: Container(
//                   height: 500,
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(topRight:Radius.circular(30),topLeft: Radius.circular(30)),
//                     color: Colors.white
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(15),
//                           child: Row(
//                             children: [
//                               Icon(Icons.location_on,color: MyColors.mainorange,size: 20,),
//                               SizedBox(width: 10,),
//                               Text(city,style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.w600,fontSize: 20),),
//                               Spacer(),
//                               Icon(Icons.favorite_border,color: MyColors.mainorange,)
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15,),
//                           child: Text(title,style: TextStyle(color: Color(0xff006599),fontWeight: FontWeight.bold,fontSize: 20),),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15,top: 15),
//                           child: Row(
//                             children: [
//                               Image.asset("assets/images/bed.png",height: 25),
//                               const SizedBox(width: 10,),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text("Beds",style: TextStyle(color: Colors.black),),
//                                   Text(bedrooms,style: const TextStyle(fontWeight: FontWeight.bold),)
//                                 ],
//                               ),
//                               const SizedBox(width: 40,),
//                               Image.asset("assets/images/bath.png",height: 25),
//                               const SizedBox(width: 10,),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text("Baths",style: TextStyle(color: Colors.black),),
//                                   Text(bathrooms,style: const TextStyle(fontWeight: FontWeight.bold),)
//                                 ],
//                               ),
//                               const SizedBox(width: 40,),
//                               Image.asset("assets/images/scale.png",height: 25,),
//                               const SizedBox(width: 10,),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text("Sqft",style: TextStyle(color: Colors.black),),
//                                   Text(size,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 10),)
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 5,),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15,top: 15),
//                           child: Text(describeYourProperty,
//                             // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eget ipsum condimentum,"
//                             //   "ultricies augue vel, tempus erat. Mauris placerat dolor diam, "
//                             //   "nec volutpat magna gravida sed. In at placerat lorem."
//                             //   "Phasellus ultrices maximus risus, eu consectetur odio eleifend sit amet. "
//                             //   "Quisque at eros lorem. ",
//                             style: TextStyle(color: Colors.grey[600],fontSize: 18,height: 1.5),),
//                         ),
//                         SizedBox(height: 15,),
//                         Divider(height: 2,thickness: 1,indent: 15,endIndent: 15,color: Colors.blue[50],),
//                         Padding(
//                           padding: const EdgeInsets.all(15),
//                           child: Text('Property Info',style: TextStyle(color: MyColors.bule1,fontWeight: FontWeight.bold,fontSize: 18),),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 25,top: 10,),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset("assets/images/bed.png",height: 25,color: MyColors.grey1,),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 15),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Furnished",style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.bold),),
//                                     SizedBox(height: 15,),
//                                     Text('No',style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500),)
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 25,top: 20,),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset("assets/images/bath.png",height: 25,color: MyColors.grey1,),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 15),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Furnished",style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.bold),),
//                                     SizedBox(height: 15,),
//                                     Text('No',style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500),)
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 25,top: 20,),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset("assets/images/mmm.png",height: 25,color: MyColors.grey1),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 15),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Furnished",style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.bold),),
//                                     SizedBox(height: 15,),
//                                     Text('No',style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500),)
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 25,top: 20,),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset("assets/images/coin.png",height: 25,color: MyColors.grey1,),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 15),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Furnished",style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.bold),),
//                                     SizedBox(height: 15,),
//                                     Text('No',style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500),)
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 25,top: 20,),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset("assets/images/apart.png",height: 25,color: MyColors.grey1,),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 15),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Furnished",style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.bold),),
//                                     SizedBox(height: 15,),
//                                     Text('No',style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500),)
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 25,top: 20,),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset("assets/images/docum.png",height: 25,color: MyColors.grey1,),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 15),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Furnished",style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.bold),),
//                                     SizedBox(height: 15,),
//                                     Text('No',style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500),)
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 25,top: 20,),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset("assets/images/ddd.png",height: 25,color: MyColors.grey1,),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 15),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Furnished",style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.bold),),
//                                     SizedBox(height: 15,),
//                                     Text('No',style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500),)
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 25,top: 20,),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset("assets/images/refer.png",height: 25,color: MyColors.grey1,),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 15),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Furnished",style: TextStyle(color: MyColors.mainorange,fontWeight: FontWeight.bold),),
//                                     SizedBox(height: 15,),
//                                     Text('No',style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500),)
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 15,),
//                         Divider(height: 2,thickness: 1,indent: 15,endIndent: 15,color: Colors.blue[50],),
//                         Padding(
//                           padding: const EdgeInsets.all(15),
//                           child: Text('Location',style: TextStyle(color: MyColors.bule1,fontWeight: FontWeight.bold,fontSize: 18),),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15,bottom: 15),
//                           child: Row(
//                             children: [
//                               Icon(Icons.location_on_outlined,color: MyColors.grey1,size: 20,),
//                               SizedBox(width:5,),
//                               Text(city,style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w600,fontSize: 15),),
//                             ],
//                           ),
//                         ),
//                         lat.isEmpty ?SizedBox(): SizedBox(width: double.infinity,height: 180,
//                           child: GoogleMap(
//                             onMapCreated: _onMapCreated,
//
//                             initialCameraPosition: CameraPosition(
//
//                               target: LatLng(double.parse(lat),double.parse(lng)),
//                               zoom: 12,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15,top: 15),
//                           child: Text('Similar Ads',style: TextStyle(color: MyColors.bule1,fontWeight: FontWeight.bold,fontSize: 18),),
//                         ),
//                         SizedBox(
//                           width: double.infinity,
//                           height: 200,
//                           child: ListView.builder(
//                             itemCount: similarsalesaddlist.length,
//                             shrinkWrap: true,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Row(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 12,top: 20),
//                                     child: SizedBox(
//                                       width: 250,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           // borderRadius: BorderRadius.circular(15),
//                                           // color: Colors.black12,
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Container(
//                                               height: 120,
//                                               width: 230,
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(8),
//                                                 image: DecorationImage(image: NetworkImage(similarsalesaddlist[index].image!),fit: BoxFit.fill),
//                                               ),
//                                             ),
//                                             const SizedBox(height: 8,),
//                                             Padding(
//                                               padding: const EdgeInsets.only(left: 5),
//                                               child: Row(
//                                                 children: [
//                                                   Text('AED',style: const TextStyle(color: Color(0xffe37640),fontWeight: FontWeight.bold),),
//                                                   SizedBox(width: 5,),
//                                                   Text(similarsalesaddlist[index].price!,style: const TextStyle(color: Color(0xffe37640),fontWeight: FontWeight.bold),),
//                                                 ],
//                                               ),
//                                             ),
//                                             const SizedBox(height: 10,),
//                                             Padding(
//                                               padding: EdgeInsets.only(left: 5),
//                                               child: Text(similarsalesaddlist[index].title!,style: const TextStyle(fontSize: 14,color: Colors.black38,fontWeight: FontWeight.bold),),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               );
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(15),
//                           child: Row(
//                             children: [
//                               Container(
//                                 height:58,
//                                 width: 155,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                       color: const Color(0xff006599),
//                                       width: 1.5
//                                   ),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     // Icon(Icons.directions_outlined,color: Colors.blue,),
//                                     Image.asset("assets/images/emaa.png",height: 20,),
//                                     const SizedBox(width: 10,),
//                                     const Text("Message",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff006599)),)
//                                   ],
//                                 ),
//                               ),
//                               const Spacer(),
//                               Container(
//                                 height:58,
//                                 width: 155,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: const Color(0xff006599)
//                                 ),
//                                 child: const Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.phone_outlined,color: Colors.white,),
//                                     SizedBox(width: 5,),
//                                     Text("Call Us",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//
//         ),
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

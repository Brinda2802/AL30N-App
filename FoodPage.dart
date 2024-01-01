// import 'package:flutter/material.dart';
//
// import '../../models/Foods.dart';
// import 'FoodDetails.dart';
//
// class FoodPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _FoodPageState();
//   }
// }
//
// class _FoodPageState extends State<FoodPage> {
//
//   List<Foods> foodslist = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     foodslist.add(Foods("assets/images/ice1.jfif", "Baskin Robbins", "Deira City Center,Dubai","20%"));
//     foodslist.add(Foods("assets/images/bbq1.jpeg", "BBQ", "Business Bay,Dubai","10%"));
//     foodslist.add(Foods("assets/images/kfc1.jfif", "KFC", "Deira City Center,Dubai","30%"));
//     foodslist.add(Foods("assets/images/piz.jfif", "PIZZA", "Samana Greens,Arjan","25%"));
//     foodslist.add(Foods("assets/images/ice2.jpg", "Baskin Robbins", "Deira City Center,Dubai","20%"));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // SizedBox(width: 4,),
//                 Padding(
//                   padding: const EdgeInsets.all(13),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffeaeaea))),
//                         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8)
//                         ),
//                         prefixIcon: Icon(Icons.location_on,color: Colors.grey),
//                         hintText: "Dubai",
//                         hintStyle: TextStyle(color: Colors.grey)
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 13,right: 13,bottom: 13),
//                   child: TextFormField(
//                     decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffeaeaea))),
//                         contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(
//                             color: Colors.blue
//                           ),
//                         ),
//                         suffixIcon: Icon(Icons.expand_more,color: Colors.black,),
//                         hintText: "Food & Beverage",
//                         hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ListView.builder(
//                     itemCount: foodslist.length,
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemBuilder: (BuildContext context, int index) {
//                       return Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(15),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   InkWell(
//                                     child: Container(
//                                       height: 170,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         image: DecorationImage(image: AssetImage(foodslist[index].imagess),fit: BoxFit.fill),
//                                       ),
//                                     ),
//                                     onTap: (){
//                                       Navigator.of(context).push(MaterialPageRoute(builder: (context) =>FoodDetails()));
//                                     },
//                                   ),
//                                   // Padding(padding: EdgeInsets.only(top: 20)),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         Text(foodslist[index].name,style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff006599),fontSize: 20),),
//                                         Spacer(),
//                                         Text(foodslist[index].Dicount,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xffe37640)),)
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(bottom: 8.0,),
//                                     child: Row(
//                                       children: [
//                                         // Image.asset("assets/images/loca.png",height: 20,color: Colors.black38,),
//                                         Icon(Icons.location_on_outlined,color: Colors.grey,),
//                                         SizedBox(width: 5,),
//                                         Text(foodslist[index].location,style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold,),),
//                                         Spacer(),
//                                         Padding(
//                                           padding: const EdgeInsets.only(right: 8.0),
//                                           child: Text("OFF",style: TextStyle(color: Color(0xffe37640),fontSize: 20,fontWeight: FontWeight.bold),),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                           height:38,
//                                           width: 140,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(10),
//                                             border: Border.all(
//                                                 color: Color(0xff006599),
//                                                 width: 1.5
//                                             ),
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             children: [
//                                               Image.asset("assets/images/pin.png",height: 25,color: Color(0xff006599),),
//                                               SizedBox(width: 10,),
//                                               Text("Direction",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff006599)),)
//                                             ],
//                                           ),
//                                         ),
//                                         Spacer(),
//                                         Container(
//                                           height:38,
//                                           width: 140,
//                                           decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(10),
//                                               color: Color(0xff006599)
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             children: [
//                                               Icon(Icons.phone_outlined,color: Colors.white,),
//                                               SizedBox(width: 5,),
//                                               Text("Call Us",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//     );
//   }
// }

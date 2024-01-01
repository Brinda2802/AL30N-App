// import 'package:flutter/material.dart';
//
// class FoodDetails extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _FoodDetailsState();
//   }
// }
//
// class _FoodDetailsState extends State<FoodDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child:
//         Stack(
//           children: [
//             Positioned(top: 0,right: 0,left:0,child: Image.asset("assets/images/ice.jpg",height:330,fit: BoxFit.fitHeight,)),
//             Positioned(top: 30,left: 20, child: Icon(Icons.arrow_back,size: 30,color: Colors.white,)),
//             Positioned(
//               bottom: 0,left: 0,right: 0,
//               child: Container(height: 500,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(topRight:Radius.circular(30),topLeft: Radius.circular(30)),
//                     color: Colors.white
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(15),
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                               contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8)
//                               ),
//                               prefixIcon: Icon(Icons.location_on,color: Colors.tealAccent,),
//                               suffixIcon: Icon(Icons.arrow_drop_down,size: 30,color: Colors.tealAccent,),
//                               hintText: "Deira City Center",
//                               hintStyle: TextStyle(color: Colors.tealAccent,fontWeight: FontWeight.bold)
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 15,),
//                         child: Text("BASKIN ROBBINS",style: TextStyle(color: Color(0xff006599),fontWeight: FontWeight.bold,fontSize: 25),),
//                       ),
//                       // SizedBox(height: 10,),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 15,top: 10),
//                         child: Text("Discount 10%",style: TextStyle(color: Color(0xffe37640),fontWeight: FontWeight.bold,fontSize: 20),),
//                       ),
//                       SizedBox(height: 10,),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 15,top: 15),
//                         child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eget ipsum condimentum,"
//                             "ultricies augue vel, tempus erat. Mauris placerat dolor diam, "
//                             "nec volutpat magna gravida sed. In at placerat lorem."
//                             "Phasellus ultrices maximus risus, eu consectetur odio eleifend sit amet. "
//                             "Quisque at eros lorem. ",style: TextStyle(fontSize: 20,height: 1.4),),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(15),
//                         child: Row(
//                           children: [
//                             Container(
//                               height:58,
//                               width: 155,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                     color: Color(0xff006599),
//                                     width: 1.5
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   // Icon(Icons.directions_outlined,color: Colors.blue,),
//                                   Image.asset("assets/images/pin.png",height: 25,color: Color(0xff006599),),
//                                   SizedBox(width: 10,),
//                                   Text("Direction",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff006599)),)
//                                 ],
//                               ),
//                             ),
//                             Spacer(),
//                             Container(
//                               height:58,
//                               width: 155,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Color(0xff006599)
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(Icons.phone_outlined,color: Colors.white,),
//                                   SizedBox(width: 5,),
//                                   Text("Call Us",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//
//       ),
//     );
//   }
// }

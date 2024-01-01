import 'package:ai3on/screens/details/RentDetails.dart';
import 'package:flutter/material.dart';

import '../../ApiUtils.dart';
import '../../models/MotorListModel.dart';
import '../details/ProductDetails.dart';

class MotorPage extends StatefulWidget {

  String selectedmotorId = "";

  MotorPage(this.selectedmotorId){}

  @override
  State<StatefulWidget> createState() {
    return _MotorPageState(selectedmotorId);
  }
}

class _MotorPageState extends State<MotorPage> {

  List<String> namess = ["Property Type", "Price Range","Rent","All Residential","Bedrooms","Bathrooms","All Furnishing types"];

  ApiUtils apiUtils = ApiUtils();

  List<MotorsList> motorlist = [];

  String motorId;

  _MotorPageState(this.motorId){
    motorId = motorId;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiUtils.getmotorlist(motorId).then((value) {
      setState(() {
        motorlist = value.motorsList!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(width: 4,),
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffeaeaea))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          prefixIcon: Icon(Icons.location_on,color: Colors.black38,),
                          hintText: "Enter location",
                          hintStyle: TextStyle(color: Colors.black38)
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Flexible(flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.black26,
                                    width: 1.5
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/filt.png",height: 20,width: 20,),
                                SizedBox(width: 5,),
                                Text("Filters"),
                                SizedBox(width: 5,),
                                CircleAvatar(radius: 10,backgroundColor: Colors.black,child:
                                Text("3",style: TextStyle(color: Colors.white),),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(flex: 3,
                        child: ListView.builder(
                          itemCount: motorlist.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                // Image.asset("assets/images/filter.png",height: 25,width: 25,),
                                // Text("Filters"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12,right: 5,top: 5),
                                  child: Container(
                                    height: 42 ,
                                    width: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.black26,
                                          width: 1.5
                                      ),
                                      // color: Colors.tealAccent
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(namess[index],style: TextStyle(fontWeight: FontWeight.bold),),
                                        ),
                                        Spacer(),
                                        Icon(Icons.keyboard_arrow_down)
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
                SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: motorlist.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(image: NetworkImage(motorlist[index].image!),fit: BoxFit.fill),
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>RentDetailss("10")));
                                    },
                                  ),
                                  // Padding(padding: EdgeInsets.only(top: 20)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(motorlist[index].title!,style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffc3c2ca),fontSize: 18),),
                                        Spacer(),
                                        Container(
                                          height: 22,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Align(alignment: Alignment.center,child: Text("Featured",style: TextStyle(color: Colors.white),)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(motorlist[index].price!,style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffe37640),fontSize: 18),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Row(
                                      children: [
                                        Image.asset("assets/images/date.png",height: 18,),
                                        SizedBox(width: 5,),
                                        Text(motorlist[index].year!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                        SizedBox(width: 10,),
                                        Image.asset("assets/images/speed.png",height: 18,),
                                        SizedBox(width: 5,),
                                        Text(motorlist[index].kms!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                        SizedBox(width: 3,),
                                        Text("km",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                        SizedBox(width: 10,),
                                        Image.asset("assets/images/color.png",height: 18,),
                                        SizedBox(width: 5,),
                                        // Text(motorlist[index].city!,style: TextStyle(fontSize: 13,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on,color: Colors.grey,size: 18,),
                                        Text(motorlist[index].city!,style: TextStyle(fontSize: 13,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height:35,
                                          width: 140,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Color(0xff006599),
                                                width: 1.5
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset("assets/images/emaa.png",height: 20,),
                                              // Icon(Icons.message_outlined,color: Color(0xff006599),),
                                              SizedBox(width: 10,),
                                              Text("Message",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff006599)),)
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          height:35,
                                          width: 140,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Color(0xff006599)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.phone_outlined,color: Colors.white,),
                                              SizedBox(width: 5,),
                                              Text("Call Us",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

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
    );
  }
}

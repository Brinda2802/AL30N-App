import 'package:ai3on/screens/details/RentDetails.dart';
import 'package:flutter/material.dart';

import '../../ApiUtils.dart';
import '../../models/SaleListModel.dart';
import '../details/ProductDetails.dart';

class SalePage extends StatefulWidget {

  String selectedsalesId = "";

  SalePage(this.selectedsalesId){}

  @override
  State<StatefulWidget> createState() {
    return _SalePageState(selectedsalesId);
  }

}

class _SalePageState extends State<SalePage> {

  List<String> namess = ["Property Type", "Price Range","Rent","All Residential","Bedrooms","Bathrooms","All Furnishing types"];

  ApiUtils apiUtils = ApiUtils();

  List<SaleList> saleslist = [];

  String salesId;

  _SalePageState(this.salesId){
    salesId = salesId;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiUtils.getsaleslist(salesId).then((value) {
      setState(() {
        saleslist = value.saleList!;
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
                          itemCount: namess.length,
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
                    itemCount: saleslist.length,
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
                                      height: 170,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(image: NetworkImage(saleslist[index].image!),fit: BoxFit.fill),
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
                                        Text(saleslist[index].price!,style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffe37640),fontSize: 18),),
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
                                    child: Row(
                                      children: [
                                        Image.asset("assets/images/bed.png",height: 18,color: Colors.grey,),
                                        SizedBox(width: 5,),
                                        Text(saleslist[index].bedroom!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                        SizedBox(width: 10,),
                                        Image.asset("assets/images/bath.png",height: 18,color: Colors.grey),
                                        Text(saleslist[index].bathroom!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                        SizedBox(width: 10,),
                                        Image.asset("assets/images/scale.png",height: 18,color: Colors.grey),
                                        Text(saleslist[index].size!,style: TextStyle(fontSize: 13,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(saleslist[index].title!,style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffc3c2ca),fontSize: 18),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on,color: Colors.grey,size: 18,),
                                        Text(saleslist[index].city!,style: TextStyle(fontSize: 13,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
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

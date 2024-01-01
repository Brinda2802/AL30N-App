import 'package:ai3on/models/vij/MyRentModel.dart';
import 'package:ai3on/models/vij/MySaleModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../ApiUtils.dart';
import '../../../MyColors.dart';
import '../../../menusample.dart';
import '../../NewScreen/SigninScreen.dart';
import '../../ViewAllScreen/FilterPage.dart';
import '../../homescreens/Add.dart';
import '../../homescreens/DealsPage.dart';
import '../../homescreens/HomePage.dart';
import '../../homescreens/NewClass.dart';
import '../RentDetails.dart';
import '../SalesDetails.dart';

class ClassifieldsRentPage extends StatefulWidget {
  String id;
  String tittle;
  int my;
   ClassifieldsRentPage(this.id, this.tittle, this.my);

  @override
  State<ClassifieldsRentPage> createState() => _ClassifieldsRentPageState();
}

class _ClassifieldsRentPageState extends State<ClassifieldsRentPage> {
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
  ApiUtils apiUtils = ApiUtils();
  List<RentsList> rentsList = [];
  List<SaleList> salessList = [];

  @override
  void initState() {

    super.initState();
    if(widget.my == 1){
      apiUtils.getClassRents(widget.id).then((value) {
        setState(() {
          rentsList = value.rentsList!;
          print(rentsList.length);
        });
      });
    }else {
      apiUtils.getClassSale(widget.id).then((value) {
        setState(() {
          salessList = value.saleList!;
          print(salessList.length);
        });
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: MyColors.navy, //change your color here
        ),
        title: Text(widget.tittle,style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.bold,fontSize: 18,),),
        elevation: 2,
      ),
      body:rentsList.isEmpty && salessList.isEmpty ? Center(
        child: Text("No Records Found!",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: MyColors.navy),),
      ) :
      SafeArea(child: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                          _showCustomPopup(context);
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
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    width: double.infinity,
                    child: widget.my == 1 ?
                    ListView.builder(
                      itemCount: rentsList.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      child: Container(
                                        height: 170,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                          image: DecorationImage(image: NetworkImage(rentsList[index].image!),fit: BoxFit.fill),
                                        ),
                                      ),
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>RentDetailss(rentsList[index].rentId!)));
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
                                          child: Text(rentsList[index].title!,
                                            style: TextStyle(fontWeight: FontWeight.bold,color: MyColors.navy,fontSize: 18),),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
                                      child: Row(
                                        children: [
                                          Text("Beds :",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                          SizedBox(width: 5,),
                                          Text(rentsList[index].room!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                          Spacer(),
                                          Text("30 Min ago",style: TextStyle(fontSize: 12,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                          SizedBox(width: 5,),
                                          Icon(Icons.favorite,color: MyColors.mainorange,size: 20,),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8,top: 3),
                                      child: Row(
                                        children: [
                                          Text("Baths :",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                          SizedBox(width: 5,),
                                          Text(rentsList[index].bathroom!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 3,bottom: 5),
                                      child: Row(
                                        children: [
                                          Text("City :",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                          SizedBox(width: 5,),
                                          Text(rentsList[index].city!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                          Spacer(),
                                          Text(rentsList[index].price!,style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffe37640),fontSize: 18),),
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
                    ) :
                    ListView.builder(
                      itemCount: salessList.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
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
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(image: NetworkImage(salessList[index].image!),fit: BoxFit.fill),
                                        ),
                                      ),
                                      onTap: (){
                                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ProductDetails()));
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SalesDetailss(salessList[index].saleId!)));

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
                                            style: TextStyle(fontWeight: FontWeight.bold,color: MyColors.navy,fontSize: 18),),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
                                      child: Row(
                                        children: [
                                          Text("Beds :",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                          SizedBox(width: 5,),
                                          Text(salessList[index].bedroom!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                          Spacer(),
                                          Text("30 Min ago",style: TextStyle(fontSize: 12,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                          SizedBox(width: 5,),
                                          Icon(Icons.favorite,color: MyColors.mainorange,size: 20,),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8,top: 3),
                                      child: Row(
                                        children: [
                                          Text("Baths :",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                          SizedBox(width: 5,),
                                          Text(salessList[index].bathroom!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 3,bottom: 5),
                                      child: Row(
                                        children: [
                                          Text("City :",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                          SizedBox(width: 5,),
                                          Text(salessList[index].city!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                          Spacer(),
                                          Text(salessList[index].price!,style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffe37640),fontSize: 18),),
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
                    )
                    ,
                  ),
                ),
              ],
            ),
          )
        ],
      )),
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
    );
  }
  void _showCustomPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.33, // Adjust the height as needed
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Oldest first",
                  style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Add your logic for "Oldest first"
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              ),
              ListTile(
                title: Text(
                  "Newest first",
                  style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Add your logic for "Oldest first"
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              ),
              ListTile(
                title: Text(
                  "Low to High discount",
                  style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Add your logic for "Oldest first"
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              ),
              ListTile(
                title: Text(
                  "High to Low discount",
                  style: TextStyle(
                    color: MyColors.navy,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Add your logic for "Oldest first"
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0,right: 20),
              //   child: Divider(height: 2,thickness: 1.5,color: Colors.grey[200],),
              // ),


            ],
          ),
        );
      },
    );
  }
}

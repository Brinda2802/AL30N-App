import 'package:ai3on/ApiUtils.dart';
import 'package:ai3on/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../menusample.dart';
import '../../../models/vij/MyMotorModel.dart';
import '../../NewScreen/SigninScreen.dart';
import '../../ViewAllScreen/FilterPage.dart';
import '../../homescreens/Add.dart';
import '../../homescreens/DealsPage.dart';
import '../../homescreens/HomePage.dart';
import '../../homescreens/NewClass.dart';
import '../MotorDetails.dart';

class ClassifiedChildSubMenu extends StatefulWidget {
  String id;
  String subid;
  String tittle;
  String mainid;
  ClassifiedChildSubMenu(this.id,this.subid,this.tittle, this.mainid);

  @override
  State<StatefulWidget> createState() {
    return _ClassifiedChildSubMenuState();
  }
}

class _ClassifiedChildSubMenuState extends State<ClassifiedChildSubMenu> {
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
  List<MotorsList> motorlist = [];
  @override
  void initState() {

    super.initState();
    if(widget.mainid == "1") {
      apiUtils.getClassMotors(widget.id, widget.subid).then((value) {
        setState(() {
          motorlist = value.motorsList!;
          print(motorlist.length);
        });
      });
    }else{

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
      body:motorlist.isEmpty ? Center(
        child: Text("No Records Found!",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: MyColors.navy),),
      ) :
      Stack(
        fit: StackFit.expand,
        children: [
           Column(
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
                        _showCustomPopup( context);
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
                  itemCount: motorlist.length,
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
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                      image: DecorationImage(image: NetworkImage(motorlist[index].image!),fit: BoxFit.fill),
                                    ),
                                  ),
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MotorDetails(motorlist[index].motorId!)));
                                  },
                                ),
                                // Padding(padding: EdgeInsets.only(top: 20)),
                                Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: MyColors.darkblue
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(motorlist[index].title!,style: TextStyle(fontWeight: FontWeight.bold,color: MyColors.navy,fontSize: 18),),
                                    )),
                                // Padding(
                                //   padding: const EdgeInsets.all(5),
                                //   child: Text(motorsList[index].price!,style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffe37640),fontSize: 18),),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
                                  child: Row(
                                    children: [
                                      Text("Year :",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                      Text(motorlist[index].year!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
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
                                      Text("Mileage :",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                      Text(motorlist[index].kms!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                      Text("Km",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text("City :",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                      Text(motorlist[index].city!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                      Spacer(),
                                      Text(motorlist[index].formatPrice(motorlist[index].price??''),style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffe37640),fontSize: 18),),
                                    ],
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Row(
                                //     children: [
                                //       Image.asset("assets/images/speed.png",height: 18,color: Colors.grey,),
                                //       SizedBox(width: 3,),
                                //       Text(motorsList[index].year!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                //       Text("Year",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                //       SizedBox(width: 10,),
                                //       Image.asset("assets/images/speed.png",height: 18,color: Colors.grey),
                                //       SizedBox(width: 3,),
                                //       Text(motorsList[index].kms!,style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                //       Text("Km",style: TextStyle(fontSize: 15,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),),
                                //       SizedBox(width: 10,),
                                //       Image.asset("assets/images/color.png",height: 18,color: Colors.grey),
                                //       SizedBox(width: 3,),
                                //       Text(motorsList[index].wheels!,style: TextStyle(fontSize: 13,color: Color(0xffc3c2ca),fontWeight: FontWeight.bold),)
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
        ],
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

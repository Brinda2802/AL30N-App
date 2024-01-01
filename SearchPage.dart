import 'package:ai3on/screens/details/DealsDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../ApiUtils.dart';
import '../../MyColors.dart';
import '../../menusample.dart';
import '../../models/SearchModel.dart';
import '../NewScreen/SigninScreen.dart';
import '../details/ClassifiedPage/ClassifiedSubmen.dart';
import '../details/ClassifieeDetails.dart';
import 'dart:convert';

import 'Add.dart';
import 'DealsPage.dart';
import 'HomePage.dart';
import 'NewClass.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
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

  TextEditingController search = TextEditingController();
  ApiUtils apiUtils = ApiUtils();
  List<SearchData> searchlist = [];
  List<SearchData> copysearchData = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    search.addListener(() {
      setState(() {
        String text = search.text;
        if (text.isEmpty) {
          copysearchData.clear();
        } else {
          copysearchData.clear();

          for (int i = 0; i < searchlist.length; i++) {
            if ( searchlist[i].title!.toLowerCase().contains(text.toLowerCase())) {
              print(text);

              copysearchData.add( searchlist[i]);
            }
          }
        }
      });

    });
    var then = apiUtils.getSearchData().then((value) {
      setState(() {
        copysearchData = value.searchData!;
        searchlist.addAll(value.searchData!) ;

        isLoading = false;

      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text("Search"),
          actions: [
            // Image.asset("assets/images/brandlogo.png",height: 20,)
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 10,right: 10,top: 10),
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: search,
                        style: TextStyle(color: MyColors.navy),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: MyColors.lightblue ,
                            contentPadding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: "Search",
                            hintStyle: TextStyle(fontSize: 12,color: MyColors.blue),
                            // label: Text("Search",style: TextStyle(fontWeight: FontWeight.bold),),
                            suffixIcon:  Icon(Icons.search,color: MyColors.blue,size: 22,)
                        ),
                        // onTap: (){
                        //   _showChoiceDialog(context);
                        // },
                      ),
                    ),
                  ),
                  ListView.builder(itemCount: copysearchData.length ,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DealsDetailScreen(copysearchData[index].id!)));

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(decoration:
                            BoxDecoration(
                                color: Color(0xfffaf4f4),borderRadius: BorderRadius.all(Radius.circular(8))
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(copysearchData[index].title!,style: TextStyle(color: MyColors.mainblue),),
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
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
}

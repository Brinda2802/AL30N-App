import 'package:ai3on/MyColors.dart';
import 'package:ai3on/screens/ChatScreen/ChatDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../menusample.dart';
import '../MyCard.dart';
import '../NewScreen/SigninScreen.dart';
import '../homescreens/Add.dart';
import '../homescreens/DealsPage.dart';
import '../homescreens/HomePage.dart';
import '../homescreens/NewClass.dart';

class ChatList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatListState();
  }
}

class _ChatListState extends State<ChatList> {
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
  List<String> names = ["Aravind","kannan","Gopal","Jegan","Mathan","Aravind","kannan","Gopal","Jegan","Mathan",];
  List<String> namess = ["Hii","Hello","Welcome","How are you","okk","Hii","Hello","Welcome","okk","GoodMorning"];
  List<String> images = ["assets/images/img.png","assets/images/img1.png","assets/images/img5.png",
    "assets/images/img1.png","assets/images/img2.jpg","assets/images/img.png",
    "assets/images/img1.png","assets/images/img5.png","assets/images/img2.jpg","assets/images/img.png",];
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
        title: Text("Chat"),
        actions: [
          // Image.asset("assets/images/brandlogo.png",height: 20,)
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: names.length,
                  physics: NeverScrollableScrollPhysics(),
                  // scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatDetailPage()));
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(images[index],width: 60,height: 60,),
                                SizedBox(width: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(names[index],style: TextStyle(fontWeight: FontWeight.bold,color: MyColors.navy),),
                                      SizedBox(height: 5,),
                                      Text(namess[index],style: TextStyle(color: Colors.black45),)
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("2:00pm",style: TextStyle(color: Colors.black38),),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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

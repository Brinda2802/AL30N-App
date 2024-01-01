import 'package:ai3on/MyColors.dart';
import 'package:ai3on/screens/homescreens/HomePage.dart';
import 'package:ai3on/screens/homescreens/Mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>with TickerProviderStateMixin {

  late AnimationController _controllerLeft;
  late AnimationController _controllerRight;
  late Animation<Offset> _offsetAnimationLeft;
  late Animation<Offset> _offsetAnimationRight;


  get() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Future.delayed(const Duration(seconds: 6), () {
      if (preferences.getBool("islogin") != null) {
        if (!preferences.getBool("islogin")!) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) =>  HomePage()));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) =>  HomePage()));
        }
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) =>  HomePage()));
      }
    });
  }


  void initState() {
    super.initState();
    get();
    _controllerLeft = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _controllerRight = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _offsetAnimationLeft = Tween<Offset>(
      begin: Offset(-2.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controllerLeft,
      curve: Curves.easeInOut,
    ));

    _offsetAnimationRight = Tween<Offset>(
      begin: Offset(2.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controllerRight,
      curve: Curves.easeInOut,
    ));

    _controllerLeft.forward();
    _controllerRight.forward();
  }


  @override
  void dispose() {
    _controllerLeft.dispose();
    _controllerRight.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          body:Stack(
            children: [
              GestureDetector(
                onTap: (){
                  print(height);
                  print(width);
                },
                child: Image.asset("assets/bg.jpeg",height: MediaQuery.of(context).size.height,width: double.infinity,
                fit: BoxFit.cover,),
              ),
              // Container(
              //     width: double.infinity,
              //     height: MediaQuery.of(context).size.height,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(image: AssetImage("assets/images/bgim.jpg"),fit: BoxFit.cover)
              //     ),
              //     alignment: Alignment.center,
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                      position: _offsetAnimationLeft,
                      child: Image.asset("assets/images/whitelogo.png", height: 180, width: 180,)),
                  /*.animate(
                    effects: [
                      MoveEffect(
                        curve: Curves.elasticOut,
                        delay: 0.ms,
                        duration: 5000.ms,
                        begin: Offset(150, 0),
                        end: Offset(0, 0),
                      ),
                    ],
                  ),*/
                  SizedBox(height: 10,),
                  Divider(height: 2,thickness: 3,color: MyColors.yellow,indent: 90,endIndent: 90,),
                  SizedBox(height: 10,),
                  SlideTransition(
                      position: _offsetAnimationRight,
                      child: Text("AIoan is committed to\nSupport the community",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18,height: 1.3),textAlign: TextAlign.center,)),

   /* animate(
                    effects: [
                      MoveEffect(
                        curve: Curves.elasticOut,
                        delay: 0.ms,
                        duration: 5000.ms,
                        begin: Offset(0, 150),
                        end: Offset(0, 0),
                      ),
                    ],
                  ),*/
                  // SizedBox(height: 5,),
                  // Text("Support the community",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),).animate(
                  //   effects: [
                  //     MoveEffect(
                  //       curve: Curves.elasticOut,
                  //       delay: 0.ms,
                  //       duration: 5000.ms,
                  //       begin: Offset(-150, 0),
                  //       end: Offset(0, 0),
                  //     ),
                  //   ],
                  // )
                ],
              )
            ],
          )
      ),
    );
  }

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage("assets/images/backg1.jpeg"), context);
    super.didChangeDependencies();
  }
}

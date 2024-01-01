import 'package:ai3on/screens/homescreens/Mainpage.dart';
import 'package:flutter/material.dart';



class NewSplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewSplashScreenState();
  }
}

class _NewSplashScreenState extends State<NewSplashScreen> {
  get(){
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  Mainpage()));
    });
  }
  @override
  void initState() {
    super.initState();
    get();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            "assets/images/bgim.png",  // Replace with the actual path to your image
            fit: BoxFit.cover,
          ),

          // Other Widgets on top of the background image
          // Add your widgets here...
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:ai3on/MyColors.dart';
import 'package:ai3on/models/CategorysModel.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:date_format_field/date_format_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


import '../../ApiUtils.dart';
import '../../menusample.dart';
import '../NewScreen/SigninScreen.dart';
import '../homescreens/Add.dart';
import '../homescreens/DealsPage.dart';
import '../homescreens/HomePage.dart';
import '../homescreens/NewClass.dart';


class AddCompany extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddCompanyState();
  }
}

class _AddCompanyState extends State<AddCompany> {
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
  bool isLoading = false;

  TextEditingController search = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController arabictitle = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController insta = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController myimagess = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController lattitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  TextEditingController offercity = TextEditingController();
  TextEditingController discountpercentage = TextEditingController();
  TextEditingController offerstartdate = TextEditingController();
  TextEditingController offerenddate = TextEditingController();
  TextEditingController offerdescription = TextEditingController();
  TextEditingController offeraddress = TextEditingController();
  TextEditingController specialdiscount = TextEditingController();
  TextEditingController offerdescriptionarabic = TextEditingController();
  TextEditingController contractimage = TextEditingController();


  var _formKey = GlobalKey<FormState>();
  var _formKey1 = GlobalKey<FormState>();

  ApiUtils apiUtils = ApiUtils();

  List<Categorys> categorys = [];
  String id = "";

  DateTime? _date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      apiUtils.getcategorys().then((value) {
        categorys = value.categorys!;
      });
    });
  }

  XFile? imageFile = XFile("");
  XFile? contactfile = XFile("");


  String? selectedValue;
  final ImagePicker picker = ImagePicker();
  int selectedindex = 0;


  Future<void>_showChoiceDialog(BuildContext context) {
    return showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Choose option",style: TextStyle(color: Colors.blue),),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  _openGallery(context);
                },
                title: Text("Gallery"),
                leading: Icon(Icons.account_box,color: Colors.blue,),
              ),

              Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  _openCamera(context);
                },
                title: Text("Camera"),
                leading: Icon(Icons.camera,color: Colors.blue,),
              ),
            ],
          ),
        ),);
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: isLoading,
      blurEffectIntensity: 1,
      progressIndicator:LoadingAnimationWidget.halfTriangleDot(color: MyColors.navy, size: 100) ,
      dismissible: false,
      opacity: 0.1,
      child:
      Scaffold(
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
            title: Text("Company Registration"),
            actions: [
              // Image.asset("assets/images/brandlogo.png",height: 20,)
            ],
          ),
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                IndexedStack(
                  index: selectedindex,
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15,right: 10),
                                  child: Container(
                                    height: 100,
                                    width: 100,

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(55),
                                        image: DecorationImage(image:
                                        FileImage(File(imageFile!.path))
                                        ),
                                        border: Border.all(color: Colors.orangeAccent,width: 2)
                                    ),
                                    // child: Image.asset("assets/images/pro.png",height: 30,),
                                  ),
                                ),
                                SizedBox(height: 15,),
                                GestureDetector(
                                  onTap: (){
                                    _showChoiceDialog(context);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xff006599)
                                    ),
                                    child: Align(alignment: Alignment.center,
                                        child: Text("Choose Logo",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10,top: 15),
                                  child: TextFormField(
                                      controller: category,
                                      readOnly: true,
                                      onTap: (){
                                        showModalBottomSheet(
                                          // isDismissible: true,
                                            isScrollControlled: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                            ),
                                            backgroundColor: Colors.white,
                                            context: context,
                                            builder: (context) {
                                              return bottomdilog();
                                            });
                                        // showDialog(
                                        //     context: context,
                                        //     builder: (my) => StatefulBuilder(
                                        //         builder: (context,setState) {
                                        //           return AlertDialog(
                                        //               backgroundColor:  Colors.white,
                                        //               content: SizedBox(
                                        //                 width: double.maxFinite,
                                        //                 //  <------- Use SizedBox to limit width
                                        //                 child: ListView.builder(
                                        //                     shrinkWrap: true,
                                        //                     itemCount:categorys.length,
                                        //                     physics: const BouncingScrollPhysics(),
                                        //                     itemBuilder:
                                        //                         (BuildContext context, int index) {
                                        //                       return GestureDetector(
                                        //                         onTap: (){
                                        //                           setState((){
                                        //                             id = categorys[index].id!;
                                        //                             category.text = categorys[index].title!;
                                        //                             Navigator.pop(context);
                                        //                           });
                                        //                         },
                                        //                         child: Padding(
                                        //                           padding: const EdgeInsets.all(10.0),
                                        //                           child: Text(categorys[index].title!)
                                        //                         ),
                                        //                       );
                                        //                     }),
                                        //               ));
                                        //         }
                                        //     ));
                                      },
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            // borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Select Category *",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Select Category';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: title,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            // borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter company name*",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your Company name';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: arabictitle,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter comapany arabic name*",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your comapany arabic name';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: phoneno,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter phone*",style: TextStyle(color: MyColors.grey1,
                                              fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your phone no';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: email,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter Email*",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your Email';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: address,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter address*",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your address';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: facebook,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter facebook link",style: TextStyle(color: MyColors.grey1,
                                              fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your facebook link';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: insta,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter instagram link",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your instagram link';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: website,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter website link",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your website link';
                                        }
                                        return null;
                                      }
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 35,right: 35,top: 20),
                                  child: InkWell(
                                    onTap: (){
                                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Mainpage()));
                                      final isValid = _formKey.currentState!.validate();
                                      if(!isValid){
                                        return;
                                      }
                                      else{
                                        setState(() {
                                          selectedindex = 1;
                                        });

                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color(0xff006599)
                                      ),
                                      child: Align(alignment: Alignment.center,
                                          child: Text("Next",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15),)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10,top: 20),
                                  child: TextFormField(
                                      controller: offercity,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            // borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter Offer City*",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your Offer city';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: offeraddress,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter Offer Address*",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your offer address';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: discountpercentage,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter Discount Percentage*",style: TextStyle(color: MyColors.grey1,
                                              fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your Discount Percentage';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: specialdiscount,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter Special Discount*",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your Special Discount';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15),
                                  child: DateFormatField(
                                    type: DateFormatType.type2,
                                    addCalendar: true,
                                    onComplete: (date) {
                                      setState(() {
                                        _date = date;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                        ),
                                        suffixIcon: Icon(Icons.date_range_sharp),
                                        label: Text("Enter Offer Start Date*",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15),
                                  child: DateFormatField(
                                    type: DateFormatType.type2,
                                    addCalendar: true,
                                    onComplete: (date) {
                                      setState(() {
                                        _date = date;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                        ),
                                        suffixIcon: Icon(Icons.date_range_sharp),
                                        label: Text("Enter Offer End Date*",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: offerdescription,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter Offer Description*",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter offer Description';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: offerdescriptionarabic,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter Offer Description Arabic*",style: TextStyle(color: MyColors.grey1,
                                              fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your offer description Abrabic';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: lattitude,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter Latitude*",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your Latitude';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                SizedBox(height: 20,),

                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: TextFormField(
                                      controller: longitude,
                                      style: TextStyle(color: MyColors.navy),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:  BorderSide(color: Color.fromRGBO(126, 132, 138, 1),),
                                          ),
                                          label: Text("Enter Longitude*",style: TextStyle(color: MyColors.grey1,fontWeight: FontWeight.w500,fontSize: 13),)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your Longitude';
                                        }
                                        return null;
                                      }
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10,top: 15),
                                  child: TextFormField(
                                      onTap: () async {

                                        contactfile  = await picker.pickImage(source: ImageSource.gallery
                                        );
                                        contractimage.text = contactfile!.path;
                                        // pickImage(source: ImageSource.gallery);


                                      },
                                      readOnly: true,
                                      style: TextStyle(color: MyColors.navy),
                                      controller: contractimage ,
                                      decoration: InputDecoration(
                                        suffixText:' Choose File' ,
                                        suffixStyle: TextStyle(
                                            color: Colors.red,fontSize: 20
                                        ),
                                        hintStyle: TextStyle(color: Colors.grey),
                                        labelText: "Sign and Upload Contract",
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(5.0),
                                          ),
                                          borderSide: new BorderSide(
                                            color: Colors.black,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Choose a Contract ';
                                        }
                                        return null;
                                      }
                                  ),
                                ),



                                Padding(
                                  padding: const EdgeInsets.only(left: 35,right: 35,top: 20),
                                  child: InkWell(
                                    onTap: (){
                                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Mainpage()));
                                      final isValid = _formKey1.currentState!.validate();
                                      if(!isValid){
                                        return;
                                      }
                                      else{
                                        setState(() {
                                          isLoading = true;
                                        });
                                        apiUtils.postaddcompany(email.text,
                                            id, title.text, address.text,
                                            "", phoneno.text, facebook.text,
                                            insta.text, website.text,
                                            lattitude.text, longitude.text,
                                            arabictitle.text,
                                            offercity.text, offeraddress.text, discountpercentage.text,
                                            specialdiscount.text,
                                            offerstartdate.text, offerenddate.text, offerdescription.text,offerdescriptionarabic.text,
                                            imageFile!, contactfile!).then((value) {
                                          if(value.status.toString() == "0"){
                                            setState(() {
                                              isLoading = false;
                                            });
                                            showTopSnackBar(context,
                                              CustomSnackBar.error(
                                                message:
                                                value.msg!,
                                              ),
                                            );
                                          }else{
                                            showTopSnackBar(context,
                                              CustomSnackBar.success(
                                                message:
                                                value.msg!,
                                              ),
                                            );
                                            Navigator.pop(context);

                                          }
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color(0xff006599)
                                      ),
                                      child: Align(alignment: Alignment.center,
                                          child: Text("Sumbit",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15),)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
      ),
    );
  }
  void _openGallery(BuildContext context) async{
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = image!;
    });
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context)  async{
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      imageFile = photo!;
    });
    Navigator.pop(context);
  }

  bottomdilog(){
    return StatefulBuilder(
        builder: (context,setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 55,
                width: double.infinity,
                decoration:
                BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/footer.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                          child: Icon(Icons.close,color: Colors.white,size: 24,)),
                    ),
                    Spacer(),
                    Text("Category",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 12,right: 12,top: 23),
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
                        prefixIcon:  Icon(Icons.search,color: MyColors.blue,size: 22,)
                    ),
                    // onTap: (){
                    //   _showChoiceDialog(context);
                    // },
                  ),
                ),
              ),
              SizedBox(height: 8,),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount:categorys.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder:
                      (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        setState((){
                          id = categorys[index].id!;
                          category.text = categorys[index].title!;
                          Navigator.pop(context);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 3.5,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(categorys[index].title!,style: TextStyle(color: MyColors.navy,fontWeight: FontWeight.w500),),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          );
        }
    );
  }
}

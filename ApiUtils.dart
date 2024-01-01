import 'dart:convert';
import 'package:ai3on/models/CategoryModel.dart';
import 'package:ai3on/models/CategorysModel.dart';
import 'package:ai3on/models/CitiesModel.dart';
import 'package:ai3on/models/ClassifiedsModel.dart';
import 'package:ai3on/models/DealsDetailsModel.dart';
import 'package:ai3on/models/EditProfileModel.dart';
import 'package:ai3on/models/MyadsModel.dart';
import 'package:ai3on/models/ParticularRentViewModel.dart';
import 'package:ai3on/models/PostAddModel.dart';
import 'package:ai3on/models/ViewSaleListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'models/AddCompanyModel.dart';
import 'models/ContactModel.dart';
import 'models/DealsModel.dart';
import 'models/GetChildMenuModel.dart';
import 'models/GetMenuModel.dart';
import 'models/HomePageModel.dart';
import 'models/LoginModel.dart';
import 'models/MenuModel.dart';
import 'models/MotorListModel.dart';
import 'models/ParticularClassifiedViewModel.dart';
import 'models/ParticularMotorViewModel.dart';
import 'models/ParticularSaleViewModel.dart';
import 'models/PlanModel.dart';
import 'models/ProfileModel.dart';
import 'models/RegisterModel.dart';
import 'package:http/http.dart' as http;
import 'models/RentListModel.dart';
import 'models/SaleListModel.dart';
import 'models/SearchModel.dart';
import 'models/SubMenuModel.dart';
import 'models/ViewMotorListModel.dart';
import 'models/ViewRentListModel.dart';
import 'models/WishlistModel.dart';
import 'models/vij/CompanyCategoryModel.dart';
import 'models/vij/FavoriteListModel.dart';
import 'models/vij/MyMotorModel.dart';
import 'models/vij/MyRentModel.dart';
import 'models/vij/MySaleModel.dart';

class ApiUtils {

  String BASE_URL = "https://sanishsoft.co.in/demo/al3on/al3on.ae/";

  Future<RegisterModel> register(String firstname,String email,String password) async{
 var body={
   'firstname' : firstname,
   'email' : email,
   'password' : password,
 };
 final response = await http.post(Uri.parse(BASE_URL+"register_app"),body: body);
 if(response.statusCode == 200){
   return RegisterModel.fromJson(jsonDecode(response.body));
 }else{
   throw Exception('Failed to create Register');
 }
}

  Future<LoginModel> login(String email,String password) async{
  var body={
    'email' : email,
    'password' : password,
  };
  final response = await http.post(Uri.parse(BASE_URL+"login_app"),body: body);
  if(response.statusCode == 200){
    return LoginModel.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to create Login');
  }
}

  Future<MenuModel> getmenu()async{

 var response = await http.get(Uri.parse(BASE_URL+"get_menu"));

 var jsondata = json.decode(response.body);
 print(response.body);

 return MenuModel.fromJson(jsondata);
}

//   Future<SubMenuModel> submenu(String id) async{
//   var body = {
//     'menu_id' : id,
//   };
//   final response = await http.get(Uri.parse(BASE_URL+"get_sub_menu/$id"));
//
//   var jsondata = json.decode(response.body);
//   print(response.body);
//
//   return SubMenuModel.fromJson(jsondata);
// }

  Future<ProfileModel> fetchProfile(String s) async{

  final prefs = await SharedPreferences.getInstance();

  var body = {
    "user_id":s,
  };
  final response = await http.post(Uri.parse(BASE_URL+"get_profile_app"),body: body);
  if(response.statusCode == 200){
    return ProfileModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load profile');
  }
}

  Future<ParticularRentViewModel> getParticularProduct(String id) async{

  final response = await http.get(Uri.parse(BASE_URL+"rent_details_app/$id"));
  print(response.body);
  if(response.statusCode == 200){
    return ParticularRentViewModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load profile');
  }
}

  Future<ParticularSaleViewModel> getParticularSale(String id) async{

    final response = await http.get(Uri.parse(BASE_URL+"sale_details_app/$id"));
    print(response.body);
    if(response.statusCode == 200){
      return ParticularSaleViewModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<GetMenuModel> getAllClassifieldsMenu(String id) async{

    final response = await http.get(Uri.parse(BASE_URL+"get_sub_menu/$id"));
    print(response.body);
    if(response.statusCode == 200){
      return GetMenuModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<GetChildMenuModel> getAllClassifieldsChildMenu(String id) async{

    final response = await http.get(Uri.parse(BASE_URL+"get_child_menu/$id"));
    print(response.body);
    if(response.statusCode == 200){
      return GetChildMenuModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<ParticularMotorViewModel> getParticularMotor(String id) async{

    final response = await http.get(Uri.parse(BASE_URL+"motors_details_app/$id"));
    print(response.body);
    if(response.statusCode == 200){
      return ParticularMotorViewModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<ParticularClassifiedViewModel> getParticularClassified(String id) async{

    final response = await http.get(Uri.parse(BASE_URL+"classifieds_details_app/$id"));
    print(response.body);
    if(response.statusCode == 200){
      return ParticularClassifiedViewModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<EditProfileModel> editprofile(String username,String surname,String email,String phone) async{
  var body = {
    'user_name' : username,
    'surname' : surname,
    'user_email' : email,
    'phone' : phone,
  };
  final response = await http.post(Uri.parse(BASE_URL+"editprofile_app"),body: body);
  if(response.statusCode == 200){
    return EditProfileModel.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to creat editprofile');
  }
}

  Future<MyMotorModel> getClassMotors(String id,String subid) async{
  var body = {
    'sub_menu' : id,
    'child_menu' : subid,
  };
  final response = await http.post(Uri.parse(BASE_URL+"listof_motor_app"),body: body);
  if(response.statusCode == 200){
    return MyMotorModel.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to creat editprofile');
  }
}
  Future<MyRentModel> getClassRents(String id) async{
  var body = {
    'sub_menu' : id,
  };
  final response = await http.post(Uri.parse(BASE_URL+"listof_rent_app"),body: body);
  if(response.statusCode == 200){
    return MyRentModel.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to creat editprofile');
  }
}
  Future<MySaleModel> getClassSale(String id) async{
  var body = {
    'sub_menu' : id,
  };
  final response = await http.post(Uri.parse(BASE_URL+"listof_sale_app"),body: body);
  if(response.statusCode == 200){
    return MySaleModel.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to creat editprofile');
  }
}

  // Future<SupportModel> support(String title, String message,File file) async{
//   var body = {
//     'title' : title,
//     'message' : message,
//     'upload_file (image)' : file
//   };
//   final response = await http.post(Uri.parse(BASE_URL+"support_app"),body: body),
//   // response.files.add(
//   //   http.MultipartFile(
//   //     'file',
//   //     file.readAsBytes().asStream(),
//   //     file.lengthSync()
//   //   )
//   );
//
//   if(response.statusCode == 200){
//     return SupportModel.fromJson(jsonDecode(response.body));
//   }else{
//     throw Exception('Failed to creat support');
//   }
// }

  Future<CitiesModel> getcity() async{

 var response = await http.get(Uri.parse(BASE_URL+"get_cites"));

 var jsondata =json.decode(response.body);

 return CitiesModel.fromJson(jsondata);

}

  Future<CategoryModel> getcategory() async{
  
  var response = await http.get(Uri.parse(BASE_URL+"get_categorys"));

  var jsondata = json.decode(response.body);

  return CategoryModel.fromJson(jsondata);
}

  Future<DealsModel> getdeal() async{
  
  var response = await http.get(Uri.parse(BASE_URL+"deals_app"));

  var jsondata = json.decode(response.body);

  return DealsModel.fromJson(jsondata);
}

  Future<DealsDetailsModel> getdealdetails(String dealId)async{

    var response = await http.get(Uri.parse(BASE_URL+"dealsdetails_app/$dealId"));

    var jsondata = json.decode(response.body);
    print(dealId);
    // print(response.body);
    return DealsDetailsModel.fromJson(jsondata);
  }
  
  Future<MotorListModel> getmotorlist(String motorId) async {
  
  var response = await http.get(Uri.parse(BASE_URL+"motor_list_app/$motorId"));

  var jsondata = json.decode(response.body);

  return MotorListModel.fromJson(jsondata);
  }

  Future<SaleListModel> getsaleslist(String salesId) async {

    var response = await http.get(Uri.parse(BASE_URL+"sale_list_app/$salesId"));
    print(response.body);

    var jsondata = json.decode(response.body);

    return SaleListModel.fromJson(jsondata);
  }

  Future<RentListModel> getrentlist(String rentId) async {

    var response = await http.get(Uri.parse(BASE_URL+"rent_list_app/$rentId"));
    print(response.body);

    var jsondata = json.decode(response.body);

    return RentListModel.fromJson(jsondata);
  }

  Future<HomePageModel> gethomelist(String city) async {

    var body ={
      'city':city
    };
    var response = await http.post(Uri.parse(BASE_URL+"home_page_app"),body: body);

    print(response.body);

    var jsondata = json.decode(response.body);

    return HomePageModel.fromJson(jsondata);
  }

  Future<ViewSaleListModel> ViewSaleList() async {

    var response = await http.get(Uri.parse("https://sanishsoft.co.in/demo/al3on/al3on.ae/sale_list_app/42"));
    print(response.body);

    var jsondata = json.decode(response.body);

    return ViewSaleListModel.fromJson(jsondata);
  }

  Future<ViewRentListModel> ViewRentList() async {

    var response = await http.get(Uri.parse("https://sanishsoft.co.in/demo/al3on/al3on.ae/rent_list_app/36"));
    print(response.body);

    var jsondata = json.decode(response.body);

    return ViewRentListModel.fromJson(jsondata);
  }

  Future<ViewMotorListModel> ViewMotorList() async {

    var response = await http.get(Uri.parse("https://sanishsoft.co.in/demo/al3on/al3on.ae/motor_list_app/1"));
    print(response.body);

    var jsondata = json.decode(response.body);

    return ViewMotorListModel.fromJson(jsondata);
  }

  Future<ClassifiedsModel> getclassifields() async {

    var response = await http.get(Uri.parse("https://sanishsoft.co.in/demo/al3on/al3on.ae/classifieds_list_app/53"));
    print(response.body);
    var jsondata = json.decode(response.body);
    return ClassifiedsModel.fromJson(jsondata);
    
  }

  Future<PostAddModel> GetPostAddScreen(String menu_id,String sub_menu_id) async {
    final prefs = await SharedPreferences.getInstance();
    var body = {
      "user_id":prefs.getString("user_id"),
      "menu_id" : menu_id,
      "sub_menu_id":sub_menu_id
    };
    print(menu_id + sub_menu_id);
    var response = await http.post(Uri.parse("https://sanishsoft.co.in/demo/al3on/al3on.ae/post_attributes"),body: body);
    print(response.body);

    var jsondata = json.decode(response.body);

    return PostAddModel.fromJson(jsondata);
  }
  // Future<void> submitReport({
  //   required String authToken, // This can be a token or user ID
  //   required String userId,
  //   required String adId,
  //   required String menuId,
  //   required String submenuId,
  //   required String reason,
  //   required String notes,
  //   required String type,
  // }) async {
  //   String apiUrl = 'https://sanishsoft.co.in/demo/al3on/al3on.ae/report_ad_app';
  //   // ... (previous code remains the same)
  //
  //   // Your API request body including user authentication
  //   Map<String, String> requestBody = {
  //     'auth_token': authToken, // Include the authentication token here
  //     'user_id': userId,
  //     'ad_id': adId,
  //     'menu_id': menuId,
  //     'submenu_id': submenuId,
  //     'reason': reason,
  //     'notes': notes,
  //     'type': type,
  //   };
  //
  //   try {
  //     var response = await http.post(
  //       Uri.parse(apiUrl),
  //       body: requestBody,
  //     );
  //     if (response.statusCode == 200) {
  //       // Report submitted successfully
  //       print('Report submitted!');
  //       // You can handle further actions after a successful report submission
  //     } else {
  //       // Handle errors if any
  //       print('Failed to submit report - Error: ${response.statusCode}');
  //     }
  //
  //     // ... (rest of the function remains the same)
  //   } catch (e) {
  //     print('Exception during report submission: $e');
  //     // ... (error handling remains the same)
  //   }
  // }


  Future<RegisterModel> SavePostAddScreen(String menu_id,String sub_menu_id, List<Attributes> attributes, List<TextEditingController> edittextlist, List<String> ids, List<XFile> imagelist,) async {
    final prefs = await SharedPreferences.getInstance();

    print(menu_id + sub_menu_id);
    var request = http.MultipartRequest("POST", Uri.parse("https://sanishsoft.co.in/demo/al3on/al3on.ae/add_post_app"));
    request.fields['user_id'] = prefs.getString("user_id").toString();
    request.fields['menu_id'] = menu_id;
    request.fields['sub_menu_id'] = sub_menu_id;
    for(int i=0;i<imagelist.length;i++) {
      var pic1 = await http.MultipartFile.fromPath("AddPictures${(i+1).toString()}", imagelist[i].path);
      request.files.add(pic1);
    }
    // var response = await http.post(Uri.parse(""),body: body);
    // print(response.body);
    for(int i=0;i<attributes.length;i++){
      if(ids[i].isEmpty) {
        // body[attributes[i].attributeName!] =
        //     edittextlist[i].text;
          request.fields[attributes[i].attributeName!] = edittextlist[i].text;

      }else{
        request.fields[attributes[i].attributeName!] =  ids[i];
      }

    }
    http.Response response =
    await http.Response.fromStream(await request.send());
    print(request.fields.entries.length);
    // print(response.body);
    log(response.body);
    print(response.body.toString());

    return RegisterModel.fromJson(json.decode(response.body.toString()));
    // var jsondata = json.decode(response.body);

    // return RegisterModel.fromJson(jsondata);
  }

  Future<ContactModel> postcontact(String email,String subject,String description,String phone,XFile? pic) async{
    final prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest("POST", Uri.parse("${BASE_URL}contact_app"));
    if(pic !=null) {
      var pic1 = await http.MultipartFile.fromPath("upload_file", pic.path);
      request.files.add(pic1);
    }

    request.fields['user_id'] = prefs.getString("user_id").toString();
    request.fields['email'] = email;
    request.fields['subject'] = subject;
    request.fields['description'] = description;
    //   'email' : email,
    //   'subject' : subject,
    //   'description' : description,
    //   'phone' : phone,
    //   // 'upload_file' : imagess,
    http.Response response =
    await http.Response.fromStream(await request.send());
    return ContactModel.fromJson(json.decode(response.body.toString()));
    // var body={
    //   'email' : email,
    //   'subject' : subject,
    //   'description' : description,
    //   'phone' : phone,
    //   // 'upload_file' : imagess,
    //
    // };
    // final response = await http.post(Uri.parse(BASE_URL+"contact_app"),body: body);
    // print(response.body);
    // if(response.statusCode == 200){
    //   return ContactModel.fromJson(jsonDecode(response.body));
    // }else{
    //   throw Exception('Failed to create Register');
    // }
  }

  Future<AddCompanyModel> postaddcompany(
    String email,
      String category,
      String title,
      String   address,
      String  map,
      String  phone,
      String  facebook,
      String   instagram,
      String  website,
      String  latitude,
      String  longitude,
      String arabic_title,
      String  offer_city,
      String   offer_address,
      String  discount_percentage,
      String  special_discount,
      String  start_date,
      String  end_date,
      String  description,
      String  arabic_description,
      XFile logo,
      XFile contract
      ) async{

    final prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest("POST", Uri.parse("${BASE_URL}addcompany_app"));
    // if(pic !=null) {
      var pic1 = await http.MultipartFile.fromPath("logo_file", logo.path);
      request.files.add(pic1);
      var pic2 = await http.MultipartFile.fromPath("contract", contract.path);
      request.files.add(pic2);
    // }
    request.fields['user_id'] = prefs.getString("user_id").toString();
    request.fields['email'] = email;
    request.fields['category'] =category;
    request.fields['title'] = title ;
    request.fields['address'] = address;
    request.fields['map'] = map;
    request.fields['phone'] = phone;
    request.fields['facebook'] = facebook;
    request.fields['instagram'] = instagram;
    request.fields['website'] = website;
    request.fields['latitude'] = latitude;
    request.fields['longitude'] = longitude;
    request.fields['arabic_title'] = arabic_title;
    request.fields['offer_city'] = offer_city;
    request.fields['offer_address'] = offer_address;
    request.fields['discount_percentage'] = discount_percentage;
    request.fields['special_discount'] = special_discount;
    request.fields['start_date'] = start_date;
    request.fields['end_date'] =end_date;
    request.fields['description'] = description;
    request.fields['arabic_description'] = arabic_description;

    http.Response response =
    await http.Response.fromStream(await request.send());
    print(response.body.toString());
    return AddCompanyModel.fromJson(json.decode(response.body.toString()));
    // print(response.body);
    // if(response.statusCode == 200){
    //   return AddCompanyModel.fromJson(jsonDecode(response.body));
    // }else{
    //   throw Exception('Failed to create Register');
    // }
  }

  Future<PlanModel> getplan() async {

  var response = await http.get(Uri.parse(BASE_URL+"plans_app"));

  var jsondata = json.decode(response.body);

  return PlanModel.fromJson(jsondata);
  }

  Future<CategorysModel> getcategorys() async {

    var response = await http.get(Uri.parse(BASE_URL+"get_categorys"));
    print(response.body);

    var jsondata = json.decode(response.body);

    return CategorysModel.fromJson(jsondata);
  }

  Future<MyadsModel> postadslist() async {
    final prefs = await SharedPreferences.getInstance();
    var body = {
      "user_id":prefs.getString("user_id"),
    };
    var response = await http.post(Uri.parse("https://sanishsoft.co.in/demo/al3on/al3on.ae/my_ads_app"),body: body);
    print(response.body);

    var jsondata = json.decode(response.body);

    return MyadsModel.fromJson(jsondata);
  }

  Future<WishlistModel> addtofavorite(String menu_id,String ad_id) async {
    final prefs = await SharedPreferences.getInstance();
    var body = {
      "user_id":prefs.getString("user_id"),
    };
    var response = await http.post(Uri.parse("https://sanishsoft.co.in/demo/al3on/al3on.ae/add_wishlist_app/$menu_id/$ad_id"),body: body);
    print(response.body);

    var jsondata = json.decode(response.body);

    return WishlistModel.fromJson(jsondata);
  }

  Future<FavoriteListModel> getwishlist() async {
    final prefs = await SharedPreferences.getInstance();
    var body = {
      "user_id":prefs.getString("user_id"),
    };
    var response = await http.post(Uri.parse("https://sanishsoft.co.in/demo/al3on/al3on.ae/my_wishlist_app"),body: body);
    print(response.body);

    var jsondata = json.decode(response.body);

    return FavoriteListModel.fromJson(jsondata);
  }

  Future<CompanyCategoryModel> getaddcompanycategory() async {
    var response = await http.get(Uri.parse("https://sanishsoft.co.in/demo/al3on/al3on.ae/get_categorys"));
    print(response.body);
    var jsondata = json.decode(response.body);
    return CompanyCategoryModel.fromJson(jsondata);
  }

  Future<SearchModel> getSearchData() async {
    var response = await http.get(Uri.parse("https://sanishsoft.co.in/demo/al3on/al3on.ae/deals_search"));
    print(response.body);
    var jsondata = json.decode(response.body);
    return SearchModel.fromJson(jsondata);
  }

}

import 'package:flutter/src/painting/text_style.dart';

class ParticularClassifiedViewModel {
  int? status;
  String? msg;
  String? city;
  String? title;
  List<String>? images;
  String? price;
  List<ClassifiedsDetails>? classifiedsDetails;
  SubMenu? subMenu;
  String? latitude;
  String? longitude;
  List<SimilarAds>? similarAds;
  // Define a function to format the price
  String formatPrice(String originalPrice) {
    String priceValue = originalPrice.replaceAll(RegExp(r'[^0-9]'), '');
    int priceNumber = int.tryParse(priceValue) ?? 0;
    String formattedPrice = priceNumber.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
    );
    return formattedPrice;
  }

// Usage example:


  ParticularClassifiedViewModel(
      {this.status,
        this.msg,
        this.city,
        this.title,
        this.images,
        this.price,
        this.classifiedsDetails,
        this.subMenu,
        this.latitude,
        this.longitude,
        this.similarAds});

  ParticularClassifiedViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    city = json['city'];
    title = json['Title'];
    images = json['images'].cast<String>();
    price = json['Price'];
    if (json['classifieds_details'] != null) {
      classifiedsDetails = <ClassifiedsDetails>[];
      json['classifieds_details'].forEach((v) {
        classifiedsDetails!.add(new ClassifiedsDetails.fromJson(v));
      });
    }


    subMenu = json['sub_menu'] != null
        ? new SubMenu.fromJson(json['sub_menu'])
        : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['similar_ads'] != null) {
      similarAds = <SimilarAds>[];
      json['similar_ads'].forEach((v) {
        similarAds!.add(new SimilarAds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['city'] = this.city;
    data['Title'] = this.title;
    data['images'] = this.images;
    data['Price'] = this.price;
    if (this.classifiedsDetails != null) {
      data['classifieds_details'] =
          this.classifiedsDetails!.map((v) => v.toJson()).toList();
    }
    if (this.subMenu != null) {
      data['sub_menu'] = this.subMenu!.toJson();
    }
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.similarAds != null) {
      data['similar_ads'] = this.similarAds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassifiedsDetails {
  String? name;
  String? value;

  ClassifiedsDetails({this.name, this.value});

  ClassifiedsDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class SubMenu {
  String? id;
  String? menu;
  String? subMenu;
  String? image;
  String? status;
  String? createdAt;

  SubMenu(
      {this.id,
        this.menu,
        this.subMenu,
        this.image,
        this.status,
        this.createdAt});

  SubMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menu = json['menu'];
    subMenu = json['sub_menu'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu'] = this.menu;
    data['sub_menu'] = this.subMenu;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class SimilarAds {
  String? image;
  String? title;
  String? price;

  SimilarAds({this.image, this.title, this.price});

  SimilarAds.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['Price'] = this.price;
    return data;
  }

  String formatPrice(String originalPrice) {
    String priceValue = originalPrice.replaceAll(RegExp(r'[^0-9]'), '');
    int priceNumber = int.tryParse(priceValue) ?? 0;
    String formattedPrice = priceNumber.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
    );
    return formattedPrice;
  }
}
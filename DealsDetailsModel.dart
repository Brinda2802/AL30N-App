class DealsDetailsModel {
  List<SimilarDeals>? similarDeals;
  Deals? deals;
  String? images;
  Company? company;

  DealsDetailsModel({this.similarDeals, this.deals, this.images, this.company});

  DealsDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['similar_deals'] != null) {
      similarDeals = <SimilarDeals>[];
      json['similar_deals'].forEach((v) {
        similarDeals!.add(new SimilarDeals.fromJson(v));
      });
    }
    deals = json['deals'] != null ? new Deals.fromJson(json['deals']) : null;
    images = json['images'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null ?? Company();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.similarDeals != null) {
      data['similar_deals'] =
          this.similarDeals!.map((v) => v.toJson()).toList();
    }
    if (this.deals != null) {
      data['deals'] = this.deals!.toJson();
    }
    data['images'] = this.images;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class SimilarDeals {
  String? id;
  String? image;
  String? title;
  String? city;
  String? discount;

  SimilarDeals({this.id, this.image, this.title, this.city, this.discount});

  SimilarDeals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    city = json['city'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['city'] = this.city;
    data['discount'] = this.discount;
    return data;
  }
}

class Deals {
  String? id;
  String? offerId;
  String? companyId;
  String? title;
  String? arabicTitle;
  String? city;
  String? arabicCity;
  String? address;
  String? arabicAddress;
  String? discount;
  String? specialDiscount;
  String? feature;
  String? image;
  String? startDate;
  String? endDate;
  String? description;
  String? arabicDescription;
  String? createdOn;
  String? updatedAt;
  String? status;
  String? approveStatus;
  String? latitude;
  String? longitude;
  String? map;
  String? branch;

  Deals(
      {this.id,
        this.offerId,
        this.companyId,
        this.title,
        this.arabicTitle,
        this.city,
        this.arabicCity,
        this.address,
        this.arabicAddress,
        this.discount,
        this.specialDiscount,
        this.feature,
        this.image,
        this.startDate,
        this.endDate,
        this.description,
        this.arabicDescription,
        this.createdOn,
        this.updatedAt,
        this.status,
        this.approveStatus,
        this.latitude,
        this.longitude,
        this.map,
        this.branch});

  Deals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerId = json['offer_id'];
    companyId = json['company_id'];
    title = json['title'];
    arabicTitle = json['arabic_title'];
    city = json['city'];
    arabicCity = json['arabic_city'];
    address = json['address'];
    arabicAddress = json['arabic_address'] ?? "";
    discount = json['discount'];
    specialDiscount = json['special_discount'];
    feature = json['feature'];
    image = json['image'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'] ?? "";
    arabicDescription = json['arabic_description'];
    createdOn = json['created_on'];
    updatedAt = json['updated_at'];
    status = json['status'];
    approveStatus = json['approve_status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    map = json['map'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['offer_id'] = this.offerId;
    data['company_id'] = this.companyId;
    data['title'] = this.title;
    data['arabic_title'] = this.arabicTitle;
    data['city'] = this.city;
    data['arabic_city'] = this.arabicCity;
    data['address'] = this.address;
    data['arabic_address'] = this.arabicAddress;
    data['discount'] = this.discount;
    data['special_discount'] = this.specialDiscount;
    data['feature'] = this.feature;
    data['image'] = this.image;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['arabic_description'] = this.arabicDescription;
    data['created_on'] = this.createdOn;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['approve_status'] = this.approveStatus;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['map'] = this.map;
    data['branch'] = this.branch;
    return data;
  }
}

class Company {
  String? id;
  String? companyId;
  String? category;
  String? title;
  String? arabicTitle;
  String? logo;
  String? contract;
  String? feature;
  String? address;
  String? map;
  String? latitude;
  String? longitude;
  String? phone;
  String? email;
  String? facebook;
  String? instagram;
  String? website;
  String? password;
  String? emailVerification;
  String? createdOn;
  String? updatedAt;
  String? status;
  String? approveStatus;

  Company(
      {this.id,
        this.companyId,
        this.category,
        this.title,
        this.arabicTitle,
        this.logo,
        this.contract,
        this.feature,
        this.address,
        this.map,
        this.latitude,
        this.longitude,
        this.phone,
        this.email,
        this.facebook,
        this.instagram,
        this.website,
        this.password,
        this.emailVerification,
        this.createdOn,
        this.updatedAt,
        this.status,
        this.approveStatus});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    category = json['category'];
    title = json['title'];
    arabicTitle = json['arabic_title'];
    logo = json['logo']??"";
    contract = json['contract'];
    feature = json['feature'];
    address = json['address'];
    map = json['map'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phone = json['phone'];
    email = json['email'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    website = json['website'];
    password = json['password'];
    emailVerification = json['email_verification'];
    createdOn = json['created_on'];
    updatedAt = json['updated_at'];
    status = json['status'];
    approveStatus = json['approve_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['category'] = this.category;
    data['title'] = this.title;
    data['arabic_title'] = this.arabicTitle;
    data['logo'] = this.logo;
    data['contract'] = this.contract;
    data['feature'] = this.feature;
    data['address'] = this.address;
    data['map'] = this.map;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['website'] = this.website;
    data['password'] = this.password;
    data['email_verification'] = this.emailVerification;
    data['created_on'] = this.createdOn;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['approve_status'] = this.approveStatus;
    return data;
  }
}

class HomePageModel {
  Motors? motors;
  Sales? sales;
  Rent? rent;
  CitesData? citesData;
  DealsData? dealsData;
  List<Banners>? banners;

  HomePageModel(
      {this.motors,
        this.sales,
        this.rent,
        this.citesData,
        this.dealsData,
        this.banners});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    motors =
    json['motors'] != null ? new Motors.fromJson(json['motors']) : null;
    sales = json['sales'] != null ? new Sales.fromJson(json['sales']) : null;
    rent = json['rent'] != null ? new Rent.fromJson(json['rent']) : null;
    citesData = json['cites_data'] != null
        ? new CitesData.fromJson(json['cites_data'])
        : null;
    dealsData = json['deals_data'] != null
        ? new DealsData.fromJson(json['deals_data'])
        : null;
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.motors != null) {
      data['motors'] = this.motors!.toJson();
    }
    if (this.sales != null) {
      data['sales'] = this.sales!.toJson();
    }
    if (this.rent != null) {
      data['rent'] = this.rent!.toJson();
    }
    if (this.citesData != null) {
      data['cites_data'] = this.citesData!.toJson();
    }
    if (this.dealsData != null) {
      data['deals_data'] = this.dealsData!.toJson();
    }
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Motors {
  List<MotorsList>? motorsList;

  Motors({this.motorsList});

  Motors.fromJson(Map<String, dynamic> json) {
    if (json['motors_list'] != null) {
      motorsList = <MotorsList>[];
      json['motors_list'].forEach((v) {
        motorsList!.add(new MotorsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.motorsList != null) {
      data['motors_list'] = this.motorsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MotorsList {
  String? motorId;
  String? image;
  String? title;
  String? describe;
  String? price;
  String? city;
  String? wheels;
  String? year;
  String? kms;
  String? phone;

  MotorsList(
      {this.motorId,
        this.image,
        this.title,
        this.describe,
        this.price,
        this.city,
        this.wheels,
        this.year,
        this.kms,
        this.phone});

  MotorsList.fromJson(Map<String, dynamic> json) {
    motorId = json['motor_id'];
    image = json['image'];
    title = json['title'];
    describe = json['describe'];
    price = json['price'];
    city = json['city'];
    wheels = json['Wheels'];
    year = json['year'];
    kms = json['kms'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['motor_id'] = this.motorId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['describe'] = this.describe;
    data['price'] = this.price;
    data['city'] = this.city;
    data['Wheels'] = this.wheels;
    data['year'] = this.year;
    data['kms'] = this.kms;
    data['phone'] = this.phone;
    return data;
  }
  String formatPrice(String originalPrice) {
    String priceValue = originalPrice.replaceAll(RegExp(r'[^0-9]'), ''); // Extracts only numbers
    int priceNumber = int.tryParse(priceValue) ?? 0; // Parses the extracted number
    String formattedPrice = priceNumber.toStringAsFixed(2); // Formats number to 2 decimal places
    return formattedPrice;
  }

}

class Sales {
  List<SaleList>? saleList;

  Sales({this.saleList});

  Sales.fromJson(Map<String, dynamic> json) {
    if (json['sale_list'] != null) {
      saleList = <SaleList>[];
      json['sale_list'].forEach((v) {
        saleList!.add(new SaleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.saleList != null) {
      data['sale_list'] = this.saleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaleList {
  String? saleId;
  String? image;
  String? title;
  String? size;
  String? price;
  String? city;
  String? bathroom;
  String? bedroom;

  SaleList(
      {this.saleId,
        this.image,
        this.title,
        this.size,
        this.price,
        this.city,
        this.bathroom,
        this.bedroom});

  SaleList.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    image = json['image'];
    title = json['title'];
    size = json['size'];
    price = json['price'];
    city = json['city'];
    bathroom = json['bathroom'];
    bedroom = json['bedroom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_id'] = this.saleId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['size'] = this.size;
    data['price'] = this.price;
    data['city'] = this.city;
    data['bathroom'] = this.bathroom;
    data['bedroom'] = this.bedroom;
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

class Rent {
  List<RentsList>? rentsList;

  Rent({this.rentsList});

  Rent.fromJson(Map<String, dynamic> json) {
    if (json['rents_list'] != null) {
      rentsList = <RentsList>[];
      json['rents_list'].forEach((v) {
        rentsList!.add(new RentsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rentsList != null) {
      data['rents_list'] = this.rentsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RentsList {
  String? rentId;
  String? image;
  String? title;
  String? price;
  String? city;
  String? bathroom;
  String? room;

  RentsList({this.rentId,
    this.image,
    this.title,
    this.price,
    this.city,
    this.bathroom,
    this.room});

  RentsList.fromJson(Map<String, dynamic> json) {
    rentId = json['rent_id'];
    image = json['image'];
    title = json['title'];
    price = json['price'];
    city = json['city'];
    bathroom = json['bathroom'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rent_id'] = this.rentId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['price'] = this.price;
    data['city'] = this.city;
    data['bathroom'] = this.bathroom;
    data['room'] = this.room;
    return data;
  }

}

class CitesData {
  List<Cites>? cites;

  CitesData({this.cites});

  CitesData.fromJson(Map<String, dynamic> json) {
    if (json['cites'] != null) {
      cites = <Cites>[];
      json['cites'].forEach((v) {
        cites!.add(new Cites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cites != null) {
      data['cites'] = this.cites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cites {
  String? id;
  String? cityName;
  String? arabicTitle;
  String? image;
  String? status;
  String? createdAt;

  Cites(
      {this.id,
        this.cityName,
        this.arabicTitle,
        this.image,
        this.status,
        this.createdAt});

  Cites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['city_name'];
    arabicTitle = json['arabic_title'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_name'] = this.cityName;
    data['arabic_title'] = this.arabicTitle;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class DealsData {
  List<Delas>? delas;

  DealsData({this.delas});

  DealsData.fromJson(Map<String, dynamic> json) {
    if (json['delas'] != null) {
      delas = <Delas>[];
      json['delas'].forEach((v) {
        delas!.add(new Delas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.delas != null) {
      data['delas'] = this.delas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Delas {
  String? id;
  String? image;
  String? title;
  String? city;
  String? discount;

  Delas({this.id, this.image, this.title, this.city, this.discount});

  Delas.fromJson(Map<String, dynamic> json) {
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

class Banners {
  String? id;
  String? image;

  Banners({this.id, this.image});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}

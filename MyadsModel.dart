class MyadsModel {
  List<MotorsList>? motorsList;
  List<RentsList>? rentsList;
  List<SalesList>? salesList;
  List<ClassList>? classList;

  MyadsModel({this.motorsList, this.rentsList, this.salesList, this.classList});

  MyadsModel.fromJson(Map<String, dynamic> json) {
    if (json['motors_list'] != null) {
      motorsList = <MotorsList>[];
      json['motors_list'].forEach((v) {
        motorsList!.add(new MotorsList.fromJson(v));
      });
    }
    if (json['rents_list'] != null) {
      rentsList = <RentsList>[];
      json['rents_list'].forEach((v) {
        rentsList!.add(new RentsList.fromJson(v));
      });
    }
    if (json['sales_list'] != null) {
      salesList = <SalesList>[];
      json['sales_list'].forEach((v) {
        salesList!.add(new SalesList.fromJson(v));
      });
    }
    if (json['class_list'] != null) {
      classList = <ClassList>[];
      json['class_list'].forEach((v) {
        classList!.add(new ClassList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.motorsList != null) {
      data['motors_list'] = this.motorsList!.map((v) => v.toJson()).toList();
    }
    if (this.rentsList != null) {
      data['rents_list'] = this.rentsList!.map((v) => v.toJson()).toList();
    }
    if (this.salesList != null) {
      data['sales_list'] = this.salesList!.map((v) => v.toJson()).toList();
    }
    if (this.classList != null) {
      data['class_list'] = this.classList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesList {
  String? image;
  String? title;
  String? price;

  SalesList({this.image, this.title, this.price});

  SalesList.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['price'] = this.price;
    return data;
  }
}

class ClassList {
  String? image;
  String? title;
  String? price;

  ClassList({this.image, this.title, this.price});

  ClassList.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['price'] = this.price;
    return data;
  }
}

class RentsList {
  String? image;
  String? title;
  String? price;

  RentsList({this.image, this.title, this.price});

  RentsList.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['price'] = this.price;
    return data;
  }
}

class MotorsList {
  String? image;
  String? title;
  String? price;
  bool isChecked; // Declare isChecked property

  MotorsList({this.image, this.title, this.price, this.isChecked = false}); // Initialize isChecked in the constructor

  MotorsList.fromJson(Map<String, dynamic> json)
      : image = json['image'],
        title = json['title'],
        price = json['price'],
        isChecked = false; // Initialize isChecked while parsing from JSON

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    data['price'] = price;
    return data;
  }
}



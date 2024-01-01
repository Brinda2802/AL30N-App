class MotorListModel {
  List<MotorsList>? motorsList;

  MotorListModel({this.motorsList});

  MotorListModel.fromJson(Map<String, dynamic> json) {
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
  String? price;
  String? city;
  String? year;
  String? kms;
  String? phone;

  MotorsList(
      {this.motorId,
        this.image,
        this.title,
        this.price,
        this.city,
        this.year,
        this.kms,
        this.phone});

  MotorsList.fromJson(Map<String, dynamic> json) {
    motorId = json['motor_id'];
    image = json['image'];
    title = json['title'];
    price = json['price'];
    city = json['city'];
    year = json['year'];
    kms = json['kms'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['motor_id'] = this.motorId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['price'] = this.price;
    data['city'] = this.city;
    data['year'] = this.year;
    data['kms'] = this.kms;
    data['phone'] = this.phone;
    return data;
  }
}

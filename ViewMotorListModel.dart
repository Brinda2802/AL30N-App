class ViewMotorListModel {
  List<MotorsList>? motorsList;

  ViewMotorListModel({this.motorsList});

  ViewMotorListModel.fromJson(Map<String, dynamic> json) {
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

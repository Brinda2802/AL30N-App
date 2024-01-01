class RentListModel {
  List<RentsList>? rentsList;

  RentListModel({this.rentsList});

  RentListModel.fromJson(Map<String, dynamic> json) {
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

  RentsList(
      {this.rentId,
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

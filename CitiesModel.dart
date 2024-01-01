class CitiesModel {
  List<Cites>? cites;

  CitiesModel({this.cites});

  CitiesModel.fromJson(Map<String, dynamic> json) {
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

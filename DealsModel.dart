class DealsModel {
  List<Delas>? delas;

  DealsModel({this.delas});

  DealsModel.fromJson(Map<String, dynamic> json) {
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

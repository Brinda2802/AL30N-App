class FavoriteListModel {
  List<MyList>? motorsList;
  List<MyList>? rentsList;
  List<MyList>? salesList;
  List<MyList>? classList;

  FavoriteListModel(
      {this.motorsList, this.rentsList, this.salesList, this.classList});

  FavoriteListModel.fromJson(Map<String, dynamic> json) {
    if (json['motors_list'] != null) {
      motorsList = <MyList>[];
      json['motors_list'].forEach((v) {
        motorsList!.add(new MyList.fromJson(v));
      });
    }
    if (json['rents_list'] != null) {
      rentsList = <MyList>[];
      json['rents_list'].forEach((v) {
        rentsList!.add(new MyList.fromJson(v));
      });
    }
    if (json['sales_list'] != null) {
      salesList = <MyList>[];
      json['sales_list'].forEach((v) {
        salesList!.add(new MyList.fromJson(v));
      });
    }
    if (json['class_list'] != null) {
      classList = <MyList>[];
      json['class_list'].forEach((v) {
        classList!.add(new MyList.fromJson(v));
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

class MyList {
  String? image;
  String? title;
  String? price;

  MyList({this.image, this.title, this.price});

  MyList.fromJson(Map<String, dynamic> json) {
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

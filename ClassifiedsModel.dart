class ClassifiedsModel {
  List<ClassList>? classList;

  ClassifiedsModel({this.classList});

  ClassifiedsModel.fromJson(Map<String, dynamic> json) {
    if (json['class_list'] != null) {
      classList = <ClassList>[];
      json['class_list'].forEach((v) {
        classList!.add(new ClassList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.classList != null) {
      data['class_list'] = this.classList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassList {
  String? classId;
  String? image;
  String? title;
  String? price;
  String? city;
  String? describe;
  String? expireDate;

  ClassList({this.classId,
    this.image,
    this.title,
    this.price,
    this.city,
    this.describe,
    this.expireDate});

  ClassList.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    image = json['image'];
    title = json['title'];
    price = json['price'];
    city = json['city'];
    describe = json['describe'];
    expireDate = json['expire_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_id'] = this.classId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['price'] = this.price;
    data['city'] = this.city;
    data['describe'] = this.describe;
    data['expire_date'] = this.expireDate;
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
class ViewSaleListModel {
  List<SaleList>? saleList;

  ViewSaleListModel({this.saleList});

  ViewSaleListModel.fromJson(Map<String, dynamic> json) {
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

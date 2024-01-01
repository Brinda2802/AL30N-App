class CategorysModel {
  List<Categorys>? categorys;

  CategorysModel({this.categorys});

  CategorysModel.fromJson(Map<String, dynamic> json) {
    if (json['categorys'] != null) {
      categorys = <Categorys>[];
      json['categorys'].forEach((v) {
        categorys!.add(new Categorys.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categorys != null) {
      data['categorys'] = this.categorys!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categorys {
  String? id;
  String? categoryId;
  String? cateId;
  String? parentId;
  String? title;
  String? arabicTitle;
  String? precedence;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  Categorys(
      {this.id,
        this.categoryId,
        this.cateId,
        this.parentId,
        this.title,
        this.arabicTitle,
        this.precedence,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  Categorys.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    cateId = json['cate_id'];
    parentId = json['parent_id'];
    title = json['title'];
    arabicTitle = json['arabic_title'];
    precedence = json['precedence'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['cate_id'] = this.cateId;
    data['parent_id'] = this.parentId;
    data['title'] = this.title;
    data['arabic_title'] = this.arabicTitle;
    data['precedence'] = this.precedence;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

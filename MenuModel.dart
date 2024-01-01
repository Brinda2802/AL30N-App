class MenuModel {
  List<Menu>? menu;

  MenuModel({this.menu});

  MenuModel.fromJson(Map<String, dynamic> json) {
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(new Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.menu != null) {
      data['menu'] = this.menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menu {
  String? id;
  String? catMenu;
  String? menu;
  String? image;
  String? status;
  String? createdAt;

  Menu(
      {this.id,
        this.catMenu,
        this.menu,
        this.image,
        this.status,
        this.createdAt});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catMenu = json['cat_menu'];
    menu = json['menu'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_menu'] = this.catMenu;
    data['menu'] = this.menu;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class SubMenuModel {
  List<SubMenu>? subMenu;

  SubMenuModel({this.subMenu});

  SubMenuModel.fromJson(Map<String, dynamic> json) {
    if (json['sub_menu'] != null) {
      subMenu = <SubMenu>[];
      json['sub_menu'].forEach((v) {
        subMenu!.add(new SubMenu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subMenu != null) {
      data['sub_menu'] = this.subMenu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubMenu {
  String? id;
  String? menu;
  String? subMenu;
  String? image;
  String? status;
  String? createdAt;

  SubMenu(
      {this.id,
        this.menu,
        this.subMenu,
        this.image,
        this.status,
        this.createdAt});

  SubMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menu = json['menu'];
    subMenu = json['sub_menu'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu'] = this.menu;
    data['sub_menu'] = this.subMenu;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

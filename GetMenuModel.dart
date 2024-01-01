class GetMenuModel {
  List<SubMenu>? subMenu;

  GetMenuModel({this.subMenu});

  GetMenuModel.fromJson(Map<String, dynamic> json) {
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
  String? subMenu;

  SubMenu({this.id, this.subMenu});

  SubMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subMenu = json['sub_menu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_menu'] = this.subMenu;
    return data;
  }
}

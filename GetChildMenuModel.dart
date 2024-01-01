class GetChildMenuModel {
  List<SubMenu>? subMenu;

  GetChildMenuModel({this.subMenu});

  GetChildMenuModel.fromJson(Map<String, dynamic> json) {
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
  String? childMenu;

  SubMenu({this.id, this.childMenu});

  SubMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    childMenu = json['child_menu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['child_menu'] = this.childMenu;
    return data;
  }
}

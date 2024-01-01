class PostAddModel {
  String? status;
  String? msg;
  List<Attributes>? attributes;

  PostAddModel({this.status, this.msg, this.attributes});

  PostAddModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  String? id;
  String? attributeName;
  String? type;
  List<AttrVal>? attrVal;
  String? requiredStatus;

  Attributes(
      {this.id,
        this.attributeName,
        this.type,
        this.attrVal,
        this.requiredStatus});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributeName = json['attribute_name'];
    type = json['type'];
    if (json['attr_val'] != null) {
      attrVal = <AttrVal>[];
      json['attr_val'].forEach((v) {
        attrVal!.add(new AttrVal.fromJson(v));
      });
    }
    requiredStatus = json['required_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attribute_name'] = this.attributeName;
    data['type'] = this.type;
    if (this.attrVal != null) {
      data['attr_val'] = this.attrVal!.map((v) => v.toJson()).toList();
    }
    data['required_status'] = this.requiredStatus;
    return data;
  }
}

class AttrVal {
  String? id;
  String? attributeValue;

  AttrVal({this.id, this.attributeValue});

  AttrVal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributeValue = json['attribute_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attribute_value'] = this.attributeValue;
    return data;
  }
}

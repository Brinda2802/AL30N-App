class PlanModel {
  Monthly? monthly;
  Monthly? yearly;

  PlanModel({this.monthly, this.yearly});

  PlanModel.fromJson(Map<String, dynamic> json) {
    monthly =
    json['monthly'] != null ? new Monthly.fromJson(json['monthly']) : null;
    yearly =
    json['yearly'] != null ? new Monthly.fromJson(json['yearly']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monthly != null) {
      data['monthly'] = this.monthly!.toJson();
    }
    if (this.yearly != null) {
      data['yearly'] = this.yearly!.toJson();
    }
    return data;
  }
}

class Monthly {
  String? id;
  String? plan;
  String? planName;
  String? amount;
  String? status;

  Monthly({this.id, this.plan, this.planName, this.amount, this.status});

  Monthly.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plan = json['plan'];
    planName = json['plan_name'];
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan'] = this.plan;
    data['plan_name'] = this.planName;
    data['amount'] = this.amount;
    data['status'] = this.status;
    return data;
  }
}

class LoginModel {
  UserDetails? userDetails;
  var status;
  String? msg;

  LoginModel({this.userDetails, this.status, this.msg});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    data['status'] = this.status;
    data['msg'] = this.msg;
    return data;
  }
}

class UserDetails {
  String? userId;
  String? email;

  UserDetails({this.userId, this.email});

  UserDetails.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email'] = this.email;
    return data;
  }
}

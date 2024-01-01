class ProfileModel {
  int? status;
  MyProfile? myProfile;

  ProfileModel({this.status, this.myProfile});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    myProfile = json['my_profile'] != null
        ? new MyProfile.fromJson(json['my_profile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.myProfile != null) {
      data['my_profile'] = this.myProfile!.toJson();
    }
    return data;
  }
}

class MyProfile {
  String? id;
  String? userId ;
  String? userType;
  String? userName;
  String? surname;
  String? userEmail;
  String? password;
  String? image;
  String? nationality;
  String? countryCode;
  String? phone;
  String? city;
  String? address;
  String? amountSpent;
  String? totalOrders;
  String? emailVerification;
  String? verificationCode;
  String? token;
  String? tokenCreatedAt;
  String? verifyMethod;
  String? familyBookNo;
  String? fatherName;
  String? tribe;
  String? hobbies;
  String? occupation;
  String? ambition;
  String? status;
  String? memberInteraction;
  String? device;
  String? fcmKey;
  String? deviceId;
  String? language;
  String? lastLogin;
  String? createdAt;
  String? updatedAt;
  String? paymentStatus;
  String? loginOauthUid;

  MyProfile(
      {this.id,
        this.userId,
        this.userType,
        this.userName,
        this.surname,
        this.userEmail,
        this.password,
        this.image,
        this.nationality,
        this.countryCode,
        this.phone,
        this.city,
        this.address,
        this.amountSpent,
        this.totalOrders,
        this.emailVerification,
        this.verificationCode,
        this.token,
        this.tokenCreatedAt,
        this.verifyMethod,
        this.familyBookNo,
        this.fatherName,
        this.tribe,
        this.hobbies,
        this.occupation,
        this.ambition,
        this.status,
        this.memberInteraction,
        this.device,
        this.fcmKey,
        this.deviceId,
        this.language,
        this.lastLogin,
        this.createdAt,
        this.updatedAt,
        this.paymentStatus,
        this.loginOauthUid});

  MyProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    userName = json['user_name'];
    surname = json['surname'];
    userEmail = json['user_email'];
    password = json['password'];
    image = json['image'];
    nationality = json['nationality'];
    countryCode = json['country_code'];
    phone = json['phone'];
    city = json['city'];
    address = json['address'];
    amountSpent = json['amount_spent'];
    totalOrders = json['total_orders'];
    emailVerification = json['email_verification'];
    verificationCode = json['verification_code'];
    token = json['token'];
    tokenCreatedAt = json['token_created_at'];
    verifyMethod = json['verify_method'];
    familyBookNo = json['family_book_no'];
    fatherName = json['father_name'];
    tribe = json['tribe'];
    hobbies = json['hobbies'];
    occupation = json['occupation'];
    ambition = json['ambition'];
    status = json['status'];
    memberInteraction = json['member_interaction'];
    device = json['device'];
    fcmKey = json['fcm_key'];
    deviceId = json['DeviceId'];
    language = json['Language'];
    lastLogin = json['last_login'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    paymentStatus = json['payment_status'];
    loginOauthUid = json['login_oauth_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['user_name'] = this.userName;
    data['surname'] = this.surname;
    data['user_email'] = this.userEmail;
    data['password'] = this.password;
    data['image'] = this.image;
    data['nationality'] = this.nationality;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['address'] = this.address;
    data['amount_spent'] = this.amountSpent;
    data['total_orders'] = this.totalOrders;
    data['email_verification'] = this.emailVerification;
    data['verification_code'] = this.verificationCode;
    data['token'] = this.token;
    data['token_created_at'] = this.tokenCreatedAt;
    data['verify_method'] = this.verifyMethod;
    data['family_book_no'] = this.familyBookNo;
    data['father_name'] = this.fatherName;
    data['tribe'] = this.tribe;
    data['hobbies'] = this.hobbies;
    data['occupation'] = this.occupation;
    data['ambition'] = this.ambition;
    data['status'] = this.status;
    data['member_interaction'] = this.memberInteraction;
    data['device'] = this.device;
    data['fcm_key'] = this.fcmKey;
    data['DeviceId'] = this.deviceId;
    data['Language'] = this.language;
    data['last_login'] = this.lastLogin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['payment_status'] = this.paymentStatus;
    data['login_oauth_uid'] = this.loginOauthUid;
    return data;
  }
}

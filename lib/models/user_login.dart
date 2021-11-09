class UserLoginModel {
  Data? data;
  String? status;

  UserLoginModel({this.data, this.status});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> tempData = <String, dynamic>{};
    if (data != null) {
      tempData['data'] = data!.toJson();
    }
    tempData['status'] = status;
    return tempData;
  }

  static Map<String, dynamic> post(String mobileNumber, String password) {
    return {'mobile': mobileNumber, 'password': password};
  }
}

class Data {
  int? id;
  String? accessToken;
  String? refreshToken;
  int? userId;
  String? expiresAt;
  String? updatedAt;
  String? createdAt;
  String? userUuid;

  Data(
      {this.id,
      this.accessToken,
      this.refreshToken,
      this.userId,
      this.expiresAt,
      this.updatedAt,
      this.createdAt,
      this.userUuid});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    userId = json['userId'];
    expiresAt = json['expiresAt'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    userUuid = json['userUuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['userId'] = userId;
    data['expiresAt'] = expiresAt;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['userUuid'] = userUuid;
    return data;
  }
}

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  String? email;
  String? pwd;
  String? confirmPwd;
  String? nickname;
  String? phone;

  RegisterModel({
    this.email,
    this.pwd,
    this.confirmPwd,
    this.nickname,
    this.phone,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        email: json["email"],
        pwd: json["pwd"],
        confirmPwd: json["confirmPwd"],
        nickname: json["nickname"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "pwd": pwd,
        "confirmPwd": confirmPwd,
        "nickname": nickname,
        "phone": phone,
      };

  @override
  String toString() {
    return "RegisterModel (email : $email, pwd: $pwd, confirmPwd : $confirmPwd, nickname : $nickname, phone : $phone)";
  }
}

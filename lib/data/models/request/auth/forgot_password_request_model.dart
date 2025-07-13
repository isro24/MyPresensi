import 'dart:convert';

class ForgotPasswordRequestModel {
    final String? email;

    ForgotPasswordRequestModel({
        this.email,
    });

    factory ForgotPasswordRequestModel.fromJson(String str) => ForgotPasswordRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ForgotPasswordRequestModel.fromMap(Map<String, dynamic> json) => ForgotPasswordRequestModel(
        email: json["email"],
    );

    Map<String, dynamic> toMap() => {
        "email": email,
    };
}

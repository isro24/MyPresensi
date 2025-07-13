import 'dart:convert';

class ResetPasswordRequestModel {
    final String? email;
    final String? token;
    final String? password;
    final String? passwordConfirmation;

    ResetPasswordRequestModel({
        this.email,
        this.token,
        this.password,
        this.passwordConfirmation,
    });

    factory ResetPasswordRequestModel.fromJson(String str) => ResetPasswordRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ResetPasswordRequestModel.fromMap(Map<String, dynamic> json) => ResetPasswordRequestModel(
        email: json["email"],
        token: json["token"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
    );

    Map<String, dynamic> toMap() => {
        "email": email,
        "token": token,
        "password": password,
        "password_confirmation": passwordConfirmation,
    };
}

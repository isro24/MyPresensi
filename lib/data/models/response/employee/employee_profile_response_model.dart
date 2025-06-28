import 'dart:convert';

class EmployeeProfileResponseModel {
  String message;
  int status;
  Data data;

  EmployeeProfileResponseModel({
    required this.message,
    required this.status,
    required this.data,
  });

  EmployeeProfileResponseModel copyWith({
    String? message,
    int? status,
    Data? data,
  }) =>
      EmployeeProfileResponseModel(
        message: message ?? this.message,
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory EmployeeProfileResponseModel.fromRawJson(String str) =>
      EmployeeProfileResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      EmployeeProfileResponseModel(
        message: json["message"],
        status: json["status_code"], 
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": status,
        "data": data.toJson(),
      };
}

class AttendanceSummary {
  final int hadir;
  final int telat;
  final int izin;
  final int sakit;
  final int alfa;
  final int cuti;

  AttendanceSummary({
    required this.hadir,
    required this.telat,
    required this.izin,
    required this.sakit,
    required this.alfa,
    required this.cuti,
  });

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) => AttendanceSummary(
        hadir: json['hadir'] ?? 0,
        telat: json['telat'] ?? 0,
        izin: json['izin'] ?? 0,
        sakit: json['sakit'] ?? 0,
        alfa: json['alfa'] ?? 0,
        cuti: json['cuti'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'hadir': hadir,
        'telat': telat,
        'izin': izin,
        'sakit': sakit,
        'alfa': alfa,
        'cuti': cuti,
      };
}

class Data {
  final int id;
  final int userId;
  final String name;
  final String email;
  final String nip;
  final String position;
  final String department;
  final String gender;
  final String phone;
  final String address;
  final String photo;
  final AttendanceSummary summary;

  Data({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.nip,
    required this.position,
    required this.department,
    required this.gender,
    required this.phone,
    required this.address,
    required this.photo,
    required this.summary,
  });

  Data copyWith({
    int? id,
    int? userId,
    String? name,
    String? email,
    String? nip,
    String? position,
    String? department,
    String? gender,
    String? phone,
    String? address,
    String? photo,
    AttendanceSummary? summary,
  }) =>
      Data(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        email: email ?? this.email,
        nip: nip ?? this.nip,
        position: position ?? this.position,
        department: department ?? this.department,
        gender: gender ?? this.gender,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        photo: photo ?? this.photo,
        summary: summary ?? this.summary,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        nip: json["nip"] ?? '',
        position: json["position"] ?? '',
        department: json["department"] ?? '',
        gender: json["gender"] ?? '',
        phone: json["phone"] ?? '',
        address: json["address"] ?? '',
        photo: json["photo"] ?? '',
        summary: AttendanceSummary.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "nip": nip,
        "position": position,
        "department": department,
        "gender": gender,
        "phone": phone,
        "address": address,
        "photo": photo,
        "summary": summary.toJson
      };
}

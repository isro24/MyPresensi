import 'dart:convert';

class AdminEmployeePermissionResponseModel {
  final String? message;
  final int? statusCode;
  final AdminEmployeePermissionData? adminEmployeePermissionData;

  AdminEmployeePermissionResponseModel({
    this.message,
    this.statusCode,
    this.adminEmployeePermissionData,
  });

  factory AdminEmployeePermissionResponseModel.fromJson(String str) =>
      AdminEmployeePermissionResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdminEmployeePermissionResponseModel.fromMap(Map<String, dynamic> json) =>
      AdminEmployeePermissionResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        adminEmployeePermissionData:
            json["AdminEmployeePermissionData"] == null
                ? null
                : AdminEmployeePermissionData.fromMap(json["AdminEmployeePermissionData"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "status_code": statusCode,
        "AdminEmployeePermissionData": adminEmployeePermissionData?.toMap(),
      };

  AdminEmployeePermissionResponseModel copyWith({
    String? message,
    int? statusCode,
    AdminEmployeePermissionData? adminEmployeePermissionData,
  }) {
    return AdminEmployeePermissionResponseModel(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      adminEmployeePermissionData:
          adminEmployeePermissionData ?? this.adminEmployeePermissionData,
    );
  }
}

class AdminEmployeePermissionData {
  final int? id;
  final int? employeeId;
  final String? type;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final String? reason;
  final String? attachment;
  final DateTime? approvedAt;
  final DateTime? rejectedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Employee? employee;

  AdminEmployeePermissionData({
    this.id,
    this.employeeId,
    this.type,
    this.startDate,
    this.endDate,
    this.status,
    this.reason,
    this.attachment,
    this.approvedAt,
    this.rejectedAt,
    this.createdAt,
    this.updatedAt,
    this.employee,
  });

  factory AdminEmployeePermissionData.fromJson(String str) =>
      AdminEmployeePermissionData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdminEmployeePermissionData.fromMap(Map<String, dynamic> json) =>
      AdminEmployeePermissionData(
        id: json["id"],
        employeeId: json["employee_id"],
        type: json["type"],
        startDate:
            json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        status: json["status"],
        reason: json["reason"],
        attachment: json["attachment"] as String?, 
        approvedAt:
            json["approved_at"] == null ? null : DateTime.parse(json["approved_at"]),
        rejectedAt: 
            json["rejected_at"] == null ? null : DateTime.parse(json["rejected_at"]),
        createdAt:
            json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt:
            json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        employee: json["employee"] == null ? null : Employee.fromMap(json["employee"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "employee_id": employeeId,
        "type": type,
        "start_date": startDate?.toIso8601String().split('T').first,
        "end_date": endDate?.toIso8601String().split('T').first,
        "status": status,
        "reason": reason,
        "attachment": attachment,
        "approved_at": approvedAt?.toIso8601String(),
        "rejected_at": rejectedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "employee": employee?.toMap(),
      };

  AdminEmployeePermissionData copyWith({
    int? id,
    int? employeeId,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? reason,
    String? attachment,
    DateTime? approvedAt,
    DateTime? rejectedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Employee? employee,
  }) {
    return AdminEmployeePermissionData(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      reason: reason ?? this.reason,
      attachment: attachment ?? this.attachment,
      approvedAt: approvedAt ?? this.approvedAt,
      rejectedAt: rejectedAt ?? this.rejectedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      employee: employee ?? this.employee,
    );
  }
}

class Employee {
    final int? id;
    final int? userId;
    final String? nip;
    final String? position;
    final String? department;
    final String? gender;
    final String? phone;
    final String? address;
    final String? photo;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final User? user;

    Employee({
        this.id,
        this.userId,
        this.nip,
        this.position,
        this.department,
        this.gender,
        this.phone,
        this.address,
        this.photo,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    factory Employee.fromJson(String str) => Employee.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        id: json["id"],
        userId: json["user_id"],
        nip: json["nip"],
        position: json["position"],
        department: json["department"],
        gender: json["gender"],
        phone: json["phone"],
        address: json["address"],
        photo: json["photo"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "nip": nip,
        "position": position,
        "department": department,
        "gender": gender,
        "phone": phone,
        "address": address,
        "photo": photo,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toMap(),
    };
}

class User {
    final int? id;
    final String? name;
    final String? email;
    final dynamic emailVerifiedAt;
    final int? roleId;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    User({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.roleId,
        this.createdAt,
        this.updatedAt,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role_id": roleId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

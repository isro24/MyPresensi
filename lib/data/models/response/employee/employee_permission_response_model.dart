import 'dart:convert';

class EmployeePermissionResponseModel {
  final String? message;
  final int? statusCode;
  final EmployeePermissionData? employeePermissionData;

  EmployeePermissionResponseModel({
    this.message,
    this.statusCode,
    this.employeePermissionData,
  });

  factory EmployeePermissionResponseModel.fromJson(String str) =>
      EmployeePermissionResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmployeePermissionResponseModel.fromMap(Map<String, dynamic> json) =>
      EmployeePermissionResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        employeePermissionData: json["EmployeePermissionData"] == null
            ? null
            : EmployeePermissionData.fromMap(json["EmployeePermissionData"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "status_code": statusCode,
        "EmployeePermissionData": employeePermissionData?.toMap(),
      };

  EmployeePermissionResponseModel copyWith({
    String? message,
    int? statusCode,
    EmployeePermissionData? employeePermissionData,
  }) {
    return EmployeePermissionResponseModel(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      employeePermissionData:
          employeePermissionData ?? this.employeePermissionData,
    );
  }
}

class EmployeePermissionData {
  final int? id;
  final int? employeeId;
  final String? type;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final String? reason;
  final dynamic attachment;
  final DateTime? approvedAt;
  final dynamic rejectedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EmployeePermissionData({
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
  });

  factory EmployeePermissionData.fromJson(String str) =>
      EmployeePermissionData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmployeePermissionData.fromMap(Map<String, dynamic> json) =>
      EmployeePermissionData(
        id: json["id"],
        employeeId: json["employee_id"],
        type: json["type"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        status: json["status"],
        reason: json["reason"],
        attachment: json["attachment"],
        approvedAt: json["approved_at"] == null
            ? null
            : DateTime.parse(json["approved_at"]),
        rejectedAt: json["rejected_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        "rejected_at": rejectedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  EmployeePermissionData copyWith({
    int? id,
    int? employeeId,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? reason,
    dynamic attachment,
    DateTime? approvedAt,
    dynamic rejectedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EmployeePermissionData(
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
    );
  }
}

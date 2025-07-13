import 'dart:convert';

class EmployeePermissionRequestModel {
    final int? employeeId;
    final String? type;
    final DateTime? startDate;
    final DateTime? endDate;
    final String? reason;
    final String? attachment;

    EmployeePermissionRequestModel({
        this.employeeId,
        this.type,
        this.startDate,
        this.endDate,
        this.reason,
        this.attachment,
    });

    factory EmployeePermissionRequestModel.fromJson(String str) => EmployeePermissionRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory EmployeePermissionRequestModel.fromMap(Map<String, dynamic> json) => EmployeePermissionRequestModel(
        employeeId: json["employee_id"],
        type: json["type"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        reason: json["reason"],
        attachment: json["attachment"],
    );

    Map<String, dynamic> toMap() => {
        "employee_id": employeeId,
        "type": type,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "reason": reason,
        "attachment": attachment,
    };
}

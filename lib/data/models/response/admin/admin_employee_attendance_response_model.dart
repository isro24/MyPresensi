import 'dart:convert';
import 'dart:typed_data';

class AdminEmployeeAttendanceResponseModel {
  final String message;
  final int status;
  final EmployeeAttendanceData data;

  AdminEmployeeAttendanceResponseModel({
    required this.message,
    required this.status,
    required this.data,
  });

  AdminEmployeeAttendanceResponseModel copyWith({
    String? message,
    int? status,
    EmployeeAttendanceData? data,
  }) =>
      AdminEmployeeAttendanceResponseModel(
        message: message ?? this.message,
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory AdminEmployeeAttendanceResponseModel.fromRawJson(String str) =>
      AdminEmployeeAttendanceResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdminEmployeeAttendanceResponseModel.fromJson(Map<String, dynamic> json) =>
      AdminEmployeeAttendanceResponseModel(
        message: json["message"] ?? '',
        status: json["status_code"] ?? 0,
        data: EmployeeAttendanceData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": status,
        "data": data.toJson(),
      };
}

class EmployeeAttendanceData {
  final int id;
  final String nip;
  final String name;
  final String location;
  final DateTime? clockIn;
  final String latitudeClockIn;
  final String longitudeClockIn;
  final DateTime? clockOut;
  final String latitudeClockOut;
  final String longitudeClockOut;
  final String photoClockIn;
  final String photoClockOut;
  final String status;
  final String? note;

  Uint8List? photoClockInBytes;
  Uint8List? photoClockOutBytes;

  EmployeeAttendanceData({
    required this.id,
    required this.nip,
    required this.name,
    required this.location,
    required this.clockIn,
    required this.latitudeClockIn,
    required this.longitudeClockIn,
    required this.clockOut,
    required this.latitudeClockOut,
    required this.longitudeClockOut,
    required this.photoClockIn,
    required this.photoClockOut,
    required this.status,
    this.note,
  });

  EmployeeAttendanceData copyWith({
    int? id,
    String? nip,
    String? name,
    String? location,
    DateTime? clockIn,
    String? latitudeClockIn,
    String? longitudeClockIn,
    DateTime? clockOut,
    String? latitudeClockOut,
    String? longitudeClockOut,
    String? photoClockIn,
    String? photoClockOut,
    String? status,
    String? note,
  }) =>
      EmployeeAttendanceData(
        id: id ?? this.id,
        nip: nip ?? this.nip,
        name: name ?? this.name,
        location: location ?? this.location,
        clockIn: clockIn ?? this.clockIn,
        latitudeClockIn: latitudeClockIn ?? this.latitudeClockIn,
        longitudeClockIn: longitudeClockIn ?? this.longitudeClockIn,
        clockOut: clockOut ?? this.clockOut,
        latitudeClockOut: latitudeClockOut ?? this.latitudeClockOut,
        longitudeClockOut: longitudeClockOut ?? this.longitudeClockOut,
        photoClockIn: photoClockIn ?? this.photoClockIn,
        photoClockOut: photoClockOut ?? this.photoClockOut,
        status: status ?? this.status,
        note: note ?? this.note,
      );

  factory EmployeeAttendanceData.fromRawJson(String str) => EmployeeAttendanceData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeAttendanceData.fromJson(Map<String, dynamic> json) => EmployeeAttendanceData(
        id: json["id"] ?? 0,
        nip: json["nip"] ?? '',
        name: json["name"] ?? '',
        location: json["location"] ?? '',
        clockIn: json["clock_in"] != null ? DateTime.parse(json["clock_in"]) : null,
        latitudeClockIn: json["latitude_clock_in"] ?? '',
        longitudeClockIn: json["longitude_clock_in"] ?? '',
        clockOut: json["clock_out"] != null ? DateTime.parse(json["clock_out"]) : null,
        latitudeClockOut: json["latitude_clock_out"] ?? '',
        longitudeClockOut: json["longitude_clock_out"] ?? '',
        photoClockIn: json["photo_clock_in"] ?? '',
        photoClockOut: json["photo_clock_out"] ?? '',
        status: json["status"] ?? '',
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nip": nip,
        "name": name,
        "location": location,
        "clock_in": clockIn?.toIso8601String(),
        "latitude_clock_in": latitudeClockIn,
        "longitude_clock_in": longitudeClockIn,
        "clock_out": clockOut?.toIso8601String(),
        "latitude_clock_out": latitudeClockOut,
        "longitude_clock_out": longitudeClockOut,
        "photo_clock_in": photoClockIn,
        "photo_clock_out": photoClockOut,
        "status": status,
        "note": note,
      };
}

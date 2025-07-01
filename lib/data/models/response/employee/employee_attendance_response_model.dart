import 'dart:convert';

class EmployeeAttendanceResponseModel {
  String message;
  int status;
  Data data;

  EmployeeAttendanceResponseModel({
    required this.message,
    required this.status,
    required this.data
  });

  EmployeeAttendanceResponseModel copyWith({
    String? message,
    int? status,
    Data? data,
  }) => EmployeeAttendanceResponseModel(
    message: message ?? this.message,
    status: status ?? this.status,
    data: data ?? this.data,
  );

  factory EmployeeAttendanceResponseModel.fromRawJson(String str) =>
    EmployeeAttendanceResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeAttendanceResponseModel.fromJson(Map<String, dynamic> json) => EmployeeAttendanceResponseModel(
    message: json["message"],
    status: json["status_code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  final int? id;
  final String? nip;
  final String? name;
  final int? scheduleId;
  final String? location;
  final DateTime? clockIn;
  final double? latitudeClockIn;
  final double? longitudeClockIn;
  final DateTime? clockOut;
  final double? latitudeClockOut;
  final double? longitudeClockOut;
  final String? photoClockIn;
  final String? photoClockOut;
  final String? status;
  final String? note;

  Data({
    this.id,
    this.nip,
    this.name,
    this.scheduleId,
    this.location,
    this.clockIn,
    this.latitudeClockIn,
    this.longitudeClockIn,
    this.clockOut,
    this.latitudeClockOut,
    this.longitudeClockOut,
    this.photoClockIn,
    this.photoClockOut,
    this.status,
    this.note,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data.fromMap(json);

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        nip: json["nip"],
        name: json["name"],
        scheduleId: json["schedule_id"],
        location: json["location"],
        clockIn: json["clock_in"] == null ? null : DateTime.parse(json["clock_in"]),
        latitudeClockIn: json["latitude_clock_in"] != null
              ? double.tryParse(json["latitude_clock_in"].toString())
              : null,
        longitudeClockIn: json["longitude_clock_in"] != null
              ? double.tryParse(json["longitude_clock_in"].toString())
              : null,
        clockOut: json["clock_out"] == null ? null : DateTime.parse(json["clock_out"]),
        latitudeClockOut: json["latitude_clock_out"] != null
            ? double.tryParse(json["latitude_clock_out"].toString())
            : null,
        longitudeClockOut: json["longitude_clock_out"] != null
            ? double.tryParse(json["longitude_clock_out"].toString())
            : null,
        photoClockIn: json["photo_clock_in"],
        photoClockOut: json["photo_clock_out"],
        status: json["status"],
        note: json["note"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nip": nip,
        "name": name,
        "schedule_id": scheduleId,
        "location": location,
        "clock_in": clockIn?.toIso8601String(),
        "latitude_clock_in": latitudeClockIn,
        "longitude_clock_in": longitudeClockIn,
        "clock_out": clockOut,
        "latitude_clock_out": latitudeClockOut,
        "longitude_clock_out": longitudeClockOut,
        "photo_clock_in": photoClockIn,
        "photo_clock_out": photoClockOut,
        "status": status,
        "note": note,
      };

  Data copyWith({
    int? id,
    String? nip,
    String? name,
    int? scheduleId,
    String? location,
    DateTime? clockIn,
    double? latitudeClockIn,
    double? longitudeClockIn,
    DateTime? clockOut,
    double? latitudeClockOut,
    double? longitudeClockOut,
    String? photoClockIn,
    String? photoClockOut,
    String? status,
    String? note,
  }) {
    return Data(
      id: id ?? this.id,
      nip: nip ?? this.nip,
      name: name ?? this.name,
      scheduleId: scheduleId ?? this.scheduleId,
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
  }
}

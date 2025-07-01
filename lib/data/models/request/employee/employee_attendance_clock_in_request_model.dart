import 'dart:convert';

class EmployeeAttendanceClockInRequestModel {
    final double? latitudeClockIn;
    final double? longitudeClockIn;
    final String? photoClockIn;
    final String? note;

    EmployeeAttendanceClockInRequestModel({
        this.latitudeClockIn,
        this.longitudeClockIn,
        this.photoClockIn,
        this.note,
    });

    factory EmployeeAttendanceClockInRequestModel.fromJson(String str) => EmployeeAttendanceClockInRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory EmployeeAttendanceClockInRequestModel.fromMap(Map<String, dynamic> json) => EmployeeAttendanceClockInRequestModel(
        latitudeClockIn: json["latitude_clock_in"],
        longitudeClockIn: json["longitude_clock_in"],
        photoClockIn: json["photo_clock_in"],
        note: json["note"],
    );

    Map<String, dynamic> toMap() => {
        "latitude_clock_in": latitudeClockIn,
        "longitude_clock_in": longitudeClockIn,
        "photo_clock_in": photoClockIn,
        "note": note,
    };
}

import 'dart:convert';

class EmployeeAttendanceClockOutRequestModel {
    final double? latitudeClockOut;
    final double? longitudeClockOut;
    final String? photoClockOut;

    EmployeeAttendanceClockOutRequestModel({
        this.latitudeClockOut,
        this.longitudeClockOut,
        this.photoClockOut,
    });

    factory EmployeeAttendanceClockOutRequestModel.fromJson(String str) => EmployeeAttendanceClockOutRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory EmployeeAttendanceClockOutRequestModel.fromMap(Map<String, dynamic> json) => EmployeeAttendanceClockOutRequestModel(
        latitudeClockOut: json["latitude_clock_out"],
        longitudeClockOut: json["longitude_clock_out"],
        photoClockOut: json["photo_clock_out"],
    );

    Map<String, dynamic> toMap() => {
        "latitude_clock_out": latitudeClockOut,
        "longitude_clock_out": longitudeClockOut,
        "photo_clock_out": photoClockOut,
    };
}

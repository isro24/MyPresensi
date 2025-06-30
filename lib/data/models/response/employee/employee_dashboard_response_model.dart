import 'dart:convert';

class DashboardResponseModel {
  String message;
  int status;
  Data data;

  DashboardResponseModel({
    required this.message, 
    required this.status, 
    required this.data
  });

  DashboardResponseModel copyWith({
    String? message,
    int? status,
    Data? data,
  }) => DashboardResponseModel(
    message: message ?? this.message,
    status: status ?? this.status,
    data: data ?? this.data,
  );

  factory DashboardResponseModel.fromRawJson(String str) =>
    DashboardResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) => DashboardResponseModel(
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

class Schedule {
  int id;
  String startTime;
  String endTime;

  Schedule({
    required this.id,
    required this.startTime,
    required this.endTime,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": startTime,
        "end_time": endTime,
      };
}

class Attendance {
  final DateTime? clockIn;
  final DateTime? clockOut;

  Attendance({
    this.clockIn,
    this.clockOut,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        clockIn: json["clock_in"] != null ? DateTime.parse(json["clock_in"]) : null,
        clockOut: json["clock_out"] != null ? DateTime.parse(json["clock_out"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "clock_in": clockIn?.toIso8601String(),
        "clock_out": clockOut?.toIso8601String(),
      };
}

class Data {
  int id;
  String name;
  String photo;
  String position;
  Schedule? schedule;
  Attendance? attendance;

  Data({
    required this.id,
    required this.name,
    required this.photo,
    required this.position,
    this.schedule,
    this.attendance,
  });

  Data copyWith({
    int? id,
    String? name,
    String? photo,
    String? position,
    Schedule? schedule,
    Attendance? attendance,
  }) => Data(
        id: id ?? this.id,
        name: name ?? this.name,
        photo: photo ?? this.photo,
        position: position ?? this.position,
        schedule: schedule ?? this.schedule,
        attendance: attendance ?? this.attendance,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        photo: json["photo"]?? "",
        position: json["position"],
        schedule: json["schedule"] != null
            ? Schedule.fromJson(json["schedule"])
            : null,
        attendance: json["attendance"] != null
            ? Attendance.fromJson(json["attendance"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "position": position,
        "schedule": schedule?.toJson(),
        "attendance": attendance?.toJson(),
      };
}

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

class Data {
  int id;
  String name;
  String photo;
  String position;
  Schedule? schedule;
  Data({
    required this.id,
    required this.name,
    required this.photo,
    required this.position,
    this.schedule
  });

  Data copyWith({
    int? id,
    String? name,
    String? photo,
    String? position,
    Schedule? schedule,
  }) => Data(
    id: id ?? this.id,
    name: name ?? this.name,
    photo: photo ?? this.photo,
    position: position ?? this.position,
    schedule: schedule ?? this.schedule,
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
    "position": position,
    "schedule": schedule?.toJson()
  };
}
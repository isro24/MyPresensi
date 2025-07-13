import 'dart:convert';

class AdminDashboardResponseModel {
  final String? message;
  final int? statusCode;
  final AdminDashboardData? data;

  AdminDashboardResponseModel({
    this.message,
    this.statusCode,
    this.data,
  });

  factory AdminDashboardResponseModel.fromJson(String str) =>
      AdminDashboardResponseModel.fromMap(json.decode(str));

  factory AdminDashboardResponseModel.fromMap(Map<String, dynamic> json) =>
      AdminDashboardResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: json["data"] == null ? null : AdminDashboardData.fromMap(json["data"]),
      );

  AdminDashboardResponseModel copyWith({
    String? message,
    int? statusCode,
    AdminDashboardData? data,
  }) {
    return AdminDashboardResponseModel(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      data: data ?? this.data,
    );
  }
}

class AdminDashboardData {
  final Admin? admin;
  final List<Schedule>? schedules;
  final List<Location>? locations;
  final int? attendanceTodayCount;
  final int? absentCount;
  final int? lateCount;
  final List<Attendance>? attendancesToday;
  final List<Attendance>? recentAttendances;
  final List<Employee>? lateEmployees;
  final List<Employee>? absentEmployees;
  final List<WeeklyAttendance>? weeklyAttendance;
  final List<Location>? activeLocations;
  final List<PendingPermission>? pendingPermissions;

  AdminDashboardData({
    this.admin,
    this.schedules,
    this.locations,
    this.attendanceTodayCount,
    this.absentCount,
    this.lateCount,
    this.attendancesToday,
    this.recentAttendances,
    this.lateEmployees,
    this.absentEmployees,
    this.weeklyAttendance,
    this.activeLocations,
    this.pendingPermissions,
  });

  factory AdminDashboardData.fromMap(Map<String, dynamic> json) => AdminDashboardData(
        admin: json["admin"] == null ? null : Admin.fromMap(json["admin"]),
        schedules: json["schedules"] == null
            ? []
            : List<Schedule>.from(json["schedules"].map((x) => Schedule.fromMap(x))),
        locations: json["locations"] == null
            ? []
            : List<Location>.from(json["locations"].map((x) => Location.fromMap(x))),
        attendanceTodayCount: json["attendance_today_count"],
        absentCount: json["absent_count"],
        lateCount: json["late_count"],
        attendancesToday: json["attendances_today"] == null
            ? []
            : List<Attendance>.from(json["attendances_today"].map((x) => Attendance.fromMap(x))),
        recentAttendances: json["recent_attendances"] == null
            ? []
            : List<Attendance>.from(json["recent_attendances"].map((x) => Attendance.fromMap(x))),
        lateEmployees: json["late_employees"] == null
            ? []
            : List<Employee>.from(json["absent_employees"].map((x) => Employee.fromMap(x))),
        absentEmployees: json["absent_employees"] == null
            ? []
            : List<Employee>.from(json["late_employees"].map((x) => Employee.fromMap(x))),
        weeklyAttendance: json["weekly_attendance"] == null
            ? []
            : List<WeeklyAttendance>.from(json["weekly_attendance"].map((x) => WeeklyAttendance.fromMap(x))),
        activeLocations: json["active_locations"] == null
            ? []
            : List<Location>.from(json["active_locations"].map((x) => Location.fromMap(x))),
        pendingPermissions: json["pending_permissions"] == null
            ? []
            : List<PendingPermission>.from(json["pending_permissions"].map((x) => PendingPermission.fromMap(x))),
      );

  AdminDashboardData copyWith({
    Admin? admin,
    List<Schedule>? schedules,
    List<Location>? locations,
    int? attendanceTodayCount,
    int? absentCount,
    int? lateCount,
    List<Attendance>? attendancesToday,
    List<Attendance>? recentAttendances,
    List<Employee>? lateEmployees,
    List<WeeklyAttendance>? weeklyAttendance,
    List<Location>? activeLocations,
    List<PendingPermission>? pendingPermissions,
  }) {
    return AdminDashboardData(
      admin: admin ?? this.admin,
      schedules: schedules ?? this.schedules,
      locations: locations ?? this.locations,
      attendanceTodayCount: attendanceTodayCount ?? this.attendanceTodayCount,
      absentCount: absentCount ?? this.absentCount,
      lateCount: lateCount ?? this.lateCount,
      attendancesToday: attendancesToday ?? this.attendancesToday,
      recentAttendances: recentAttendances ?? this.recentAttendances,
      lateEmployees: lateEmployees ?? this.lateEmployees,
      weeklyAttendance: weeklyAttendance ?? this.weeklyAttendance,
      activeLocations: activeLocations ?? this.activeLocations,
      pendingPermissions: pendingPermissions ?? this.pendingPermissions,
    );
  }
}


class Admin {
  final int? id;
  final String? name;
  final String? photo;

  Admin({this.id, this.name, this.photo});

  factory Admin.fromMap(Map<String, dynamic> json) => Admin(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
      );
}

class Schedule {
  final int? id;
  final String? startTime;
  final String? endTime;

  Schedule({this.id, this.startTime, this.endTime});

  factory Schedule.fromMap(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
      );
}

class Location {
  final int? id;
  final String? name;

  Location({this.id, this.name});

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
      );
}

class Attendance {
  final int? id;
  final String? clockIn;
  final String? clockOut;
  final Employee? employee;

  Attendance({this.id, this.clockIn, this.clockOut, this.employee});

  factory Attendance.fromMap(Map<String, dynamic> json) => Attendance(
        id: json["id"],
        clockIn: json["clock_in"],
        clockOut: json["clock_out"],
        employee: json["employee"] == null ? null : Employee.fromMap(json["employee"]),
      );
}

class Employee {
  final int? id;
  final String? name;
  final String? photo;
  final String? position;

  Employee({this.id, this.name, this.photo, this.position});

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        position: json["position"],
      );
}

class WeeklyAttendance {
  final String? date;
  final int? count;

  WeeklyAttendance({this.date, this.count});

  factory WeeklyAttendance.fromMap(Map<String, dynamic> json) => WeeklyAttendance(
        date: json["date"],
        count: json["count"],
      );
}

class PendingPermission {
  final String? name;
  final String? position;
  final String? type;
  final String? startDate;
  final String? endDate;
  final String? photo;

  PendingPermission({
    this.name,
    this.position,
    this.type,
    this.startDate,
    this.endDate,
    this.photo,
  });

  factory PendingPermission.fromMap(Map<String, dynamic> json) => PendingPermission(
        name: json["name"],
        position: json["position"],
        type: json["type"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        photo: json["photo"],
      );
}

class EmployeeManagementResponseModel {
  final String message;
  final int status;
  final EmployeeManagementData? user;
  final Employee? employee;

  EmployeeManagementResponseModel({
    required this.message,
    required this.status,
    this.user,
    this.employee,
  });

  factory EmployeeManagementResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return EmployeeManagementResponseModel(
      message: json["message"],
      status: json["status_code"],
      user: data["user"] != null ? EmployeeManagementData.fromJson(data["user"]) : null,
      employee: data["employee"] != null ? Employee.fromJson(data["employee"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": status,
        "user": user?.toJson(),
        "employee": employee?.toJson(),
      };
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
  final String? photoUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
    this.photoUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        userId: json["user_id"],
        nip: json["nip"],
        position: json["position"],
        department: json["department"],
        gender: json["gender"],
        phone: json["phone"],
        address: json["address"],
        photoUrl: json["photo_url"],
        photo: json["photo"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nip": nip,
        "position": position,
        "department": department,
        "gender": gender,
        "phone": phone,
        "address": address,
        "photo": photo,
        "photo_url": photoUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  Employee copyWith({
    int? id,
    int? userId,
    String? nip,
    String? position,
    String? department,
    String? gender,
    String? phone,
    String? address,
    String? photo,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Employee(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      nip: nip ?? this.nip,
      position: position ?? this.position,
      department: department ?? this.department,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      photo: photo ?? this.photo,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}


class EmployeeManagementData {
  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final int? roleId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Employee? employee;

  EmployeeManagementData({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.employee,
  });

  factory EmployeeManagementData.fromJson(Map<String, dynamic> json) =>
      EmployeeManagementData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        employee: json["employee"] != null
            ? Employee.fromJson(json["employee"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role_id": roleId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "employee": employee?.toJson(),
      };

  EmployeeManagementData copyWith({
    int? id,
    String? name,
    String? email,
    dynamic emailVerifiedAt,
    int? roleId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Employee? employee,
  }) {
    return EmployeeManagementData(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      roleId: roleId ?? this.roleId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      employee: employee ?? this.employee,
    );
  }
}


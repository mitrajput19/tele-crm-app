class Profile {
  final String id;
  final String userId;
  final String fullName;
  final String role;
  final String? phone;
  final String? managerId;
  final int hierarchyLevel;
  final String? department;
  final String? positionTitle;
  final bool canManageOthers;
  final String? orgUnitId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Profile({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.role,
    this.phone,
    this.managerId,
    this.hierarchyLevel = 0,
    this.department,
    this.positionTitle,
    this.canManageOthers = false,
    this.orgUnitId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json['id'],
    userId: json['user_id'],
    fullName: json['full_name'],
    role: json['role'],
    phone: json['phone'],
    managerId: json['manager_id'],
    hierarchyLevel: json['hierarchy_level'] ?? 0,
    department: json['department'],
    positionTitle: json['position_title'],
    canManageOthers: json['can_manage_others'] ?? false,
    orgUnitId: json['org_unit_id'],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'full_name': fullName,
    'role': role,
    'phone': phone,
    'manager_id': managerId,
    'hierarchy_level': hierarchyLevel,
    'department': department,
    'position_title': positionTitle,
    'can_manage_others': canManageOthers,
    'org_unit_id': orgUnitId,
  };
}


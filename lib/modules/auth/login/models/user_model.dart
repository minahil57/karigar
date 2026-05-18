class UserModel {
  final String id;
  final String name;
  final String email;
  final bool emailVerified;
  final String? image;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isProfileCompleted;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    this.image,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.isProfileCompleted,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      emailVerified: json['emailVerified'] ?? false,
      image: json['image'],
      role: json['role'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isProfileCompleted: json['isProfileCompleted'] ?? false ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'emailVerified': emailVerified,
      'image': image,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isProfileCompleted': isProfileCompleted,
    };
  }

   UserModel copyWith({
    String? id,
    String? name,
    String? email,
    bool? emailVerified,
    String? image,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isProfileCompleted,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      image: image ?? this.image,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
    );
  }
}

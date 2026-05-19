class ServiceModel {
  final String id;
  final String name;
  final String category;
  final String createdAt;

  const ServiceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.createdAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'createdAt': createdAt,
    };
  }
}

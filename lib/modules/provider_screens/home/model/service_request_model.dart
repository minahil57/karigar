import 'package:karigar/export.dart';

class ServiceRequestModel {
  final String id;
  final String scheduledTime;
  final String status;
  final String location;
  final String createdAt;
  final ProviderService providerService;

  ServiceRequestModel({
    required this.id,
    required this.scheduledTime,
    required this.status,
    required this.location,
    required this.createdAt,
    required this.providerService,
  });

  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestModel(
      id: json['id'] ?? '',
      scheduledTime: json['scheduledTime'] ?? '',
      status: json['status'] ?? '',
      location: json['location'] ?? '',
      createdAt: json['createdAt'] ?? '',
      providerService: ProviderService.fromJson(json['providerService'] ?? {}),
    );
  }
}

class ProviderService {
  final String id;
  final Services service;
  final ProviderModel provider;

  ProviderService({
    required this.id,
    required this.service,
    required this.provider,
  });

  factory ProviderService.fromJson(Map<String, dynamic> json) {
    return ProviderService(
      id: json['id'] ?? '',
      service: Services.fromJson(json['service'] ?? {}),
      provider: ProviderModel.fromJson(json['provider'] ?? {}),
    );
  }
}

class Services {
  final String id;
  final String name;

  Services({required this.id, required this.name});

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(id: json['id'] ?? '', name: json['name'] ?? '');
  }

  
}

class ProviderModel {
  final String id;
  final String businessName;
  final String avatar;

  ProviderModel({
    required this.id,
    required this.businessName,
    required this.avatar,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'] ?? '',
      businessName: json['businessName'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}
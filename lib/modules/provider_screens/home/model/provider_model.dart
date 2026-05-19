import 'package:karigar/export.dart';

class ProviderData {
  final String id;
  final String userId;
  final String businessName;
  final String? phone;
  final String? email;
  final String? avatar;
  final double lat;
  final double lng;
  final Location location;
  final Address address;
  final Availability availability;
  final dynamic priceRange;
  final int responseTime;
  final double rating;
  final int reviewCount;
  final bool isOnboarded;
  final dynamic specialty;
  final bool isVerified;
  final bool isAvailable;
  final dynamic about;
  final dynamic experienceYears;
  final List<String> languages;
  final int? totalBookings;
  final int? earnings;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProviderData({
    required this.id,
    required this.userId,
    required this.businessName,
    this.phone,
    this.email,
    this.avatar,
    required this.lat,
    required this.lng,
    required this.location,
    required this.address,
    required this.availability,
    this.priceRange,
    required this.responseTime,
    required this.rating,
    required this.reviewCount,
    required this.isOnboarded,
    this.specialty,
    required this.isVerified,
    required this.isAvailable,
    this.about,
    this.experienceYears,
    this.languages = const [],
    this.totalBookings,
    this.earnings,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProviderData.fromJson(Map<String, dynamic> json) {
    return ProviderData(
      id: json['id'],
      userId: json['userId'] ?? '',
      businessName: json['businessName'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      location: Location.fromJson(json['location']),
      address: Address.fromJson(json['address']),
      availability: Availability.fromJson(json['availability']),
      priceRange: json['priceRange'],
      responseTime: json['responseTime'] ?? 0,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'],
      isOnboarded: json['isOnboarded'],
      specialty: json['specialty'],
      isVerified: json['isVerified'],
      isAvailable: json['isAvailable'],
      about: json['about'],
      experienceYears: json['experienceYears'],
      languages: (json['languages'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      earnings: json['earnings'],
      totalBookings: json['totalBookings'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'businessName': businessName,
      'phone': phone,
      'email': email,
      'avatar': avatar,
      'lat': lat,
      'lng': lng,
      'location': location.toJson(),
      'address': address.toJson(),
      'availability': availability.toJson(),
      'priceRange': priceRange,
      'responseTime': responseTime,
      'rating': rating,
      'reviewCount': reviewCount,
      'isOnboarded': isOnboarded,
      'specialty': specialty,
      'isVerified': isVerified,
      'isAvailable': isAvailable,
      'about': about,
      'experienceYears': experienceYears,
      'languages': languages,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Location {
  final double lng;
  final double lat;

  Location({required this.lng, required this.lat});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lng: (json['lng'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'lng': lng, 'lat': lat};
  }
}

class Address {
  final String city;
  final String state;
  final String street;
  final String country;

  Address({
    required this.city,
    required this.state,
    required this.street,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      state: json['state'],
      street: json['street'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'city': city, 'state': state, 'street': street, 'country': country};
  }
}

class Availability {
  final Map<String, DayAvailability> days;

  Availability({required this.days});

  factory Availability.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Availability(days: {});

    final Map<String, DayAvailability> parsedDays = {};

    json.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        try {
          parsedDays[key] = DayAvailability.fromJson(value);
        } catch (e) {
          debugPrint("❌ Error parsing $key availability: $e");
        }
      }
    });

    return Availability(days: parsedDays);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    days.forEach((key, value) {
      json[key] = value.toJson();
    });

    return json;
  }

  // Optional helpers (VERY useful)
  DayAvailability? getDay(String day) => days[day];

  bool isOpenOn(String day) => days.containsKey(day);
}

class DayAvailability {
  final String open;
  final String close;

  DayAvailability({required this.open, required this.close});

  factory DayAvailability.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return DayAvailability(open: '', close: '');
    }

    return DayAvailability(
      open: json['open']?.toString() ?? '',
      close: json['close']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'open': open, 'close': close};
  }
}

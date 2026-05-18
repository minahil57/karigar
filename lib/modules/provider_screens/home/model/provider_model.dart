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
  final dynamic languages;
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
    this.languages,
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
      lat: (json['lat'] as num).toDouble() ,
      lng: (json['lng'] as num).toDouble(),
      location: Location.fromJson(json['location']),
      address: Address.fromJson(json['address']),
      availability: Availability.fromJson(json['availability']),
      priceRange: json['priceRange'],
      responseTime: json['responseTime'],
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'],
      isOnboarded: json['isOnboarded'],
      specialty: json['specialty'],
      isVerified: json['isVerified'],
      isAvailable: json['isAvailable'],
      about: json['about'],
      experienceYears: json['experienceYears'],
      languages: json['languages'],
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
  final DayAvailability monday;
  final DayAvailability tuesday;
  final DayAvailability wednesday;
  final DayAvailability thursday;
  final DayAvailability friday;
  final DayAvailability saturday;
  final DayAvailability sunday;

  Availability({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      monday: DayAvailability.fromJson(json['monday']),
      tuesday: DayAvailability.fromJson(json['tuesday']),
      wednesday: DayAvailability.fromJson(json['wednesday']),
      thursday: DayAvailability.fromJson(json['thursday']),
      friday: DayAvailability.fromJson(json['friday']),
      saturday: DayAvailability.fromJson(json['saturday']),
      sunday: DayAvailability.fromJson(json['sunday']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'monday': monday.toJson(),
      'tuesday': tuesday.toJson(),
      'wednesday': wednesday.toJson(),
      'thursday': thursday.toJson(),
      'friday': friday.toJson(),
      'saturday': saturday.toJson(),
      'sunday': sunday.toJson(),
    };
  }
}

class DayAvailability {
  final String open;
  final String close;

  DayAvailability({required this.open, required this.close});

  factory DayAvailability.fromJson(Map<String, dynamic> json) {
    return DayAvailability(open: json['open'], close: json['close']);
  }

  Map<String, dynamic> toJson() {
    return {'open': open, 'close': close};
  }
}

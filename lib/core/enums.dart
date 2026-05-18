import 'package:flutter/material.dart';

enum ItemsAlignment {
  row,
  column,
}

enum UserRole {
  customer,
  serviceProvider;

  /// Display text for UI
  String get title {
    switch (this) {
      case UserRole.customer:
        return 'Customer';

      case UserRole.serviceProvider:
        return 'Service Provider';
    }
  }

  /// Value sent to API/DB
  String get apiValue {
    switch (this) {
      case UserRole.customer:
        return 'user';

      case UserRole.serviceProvider:
        return 'provider';
    }
  }

  /// Convert API value to enum
  static UserRole fromApi(String value) {
    switch (value) {
      case 'provider':
        return UserRole.serviceProvider;

      case 'user':
      default:
        return UserRole.customer;
    }
  }
}

enum BookingStatus {
  requested,
  confirmed,
  reminded,
  completed,
  cancelled;

  /// Display text for UI
  String get title {
    switch (this) {
      case BookingStatus.requested:
        return 'Requested';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.reminded:
        return 'Reminded';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  /// Value sent to API/DB
  String get apiValue {
    switch (this) {
      case BookingStatus.requested:
        return 'requested';
      case BookingStatus.confirmed:
        return 'confirmed';
      case BookingStatus.reminded:
        return 'reminded';
      case BookingStatus.completed:
        return 'completed';
      case BookingStatus.cancelled:
        return 'cancelled';
    }
  }

  /// Color for status tag
  Color get color {
    switch (this) {
      case BookingStatus.requested:
        return Colors.orange;
      case BookingStatus.confirmed:
        return Colors.blue;
      case BookingStatus.reminded:
        return Colors.purple;
      case BookingStatus.completed:
        return Colors.green;
      case BookingStatus.cancelled:
        return Colors.red;
    }
  }

  /// Background color for status tag
  Color get backgroundColor {
    return color.withValues(alpha: 0.1);
  }

  /// Convert API value to enum
  static BookingStatus fromApi(String value) {
    switch (value.toLowerCase()) {
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'reminded':
        return BookingStatus.reminded;
      case 'completed':
        return BookingStatus.completed;
      case 'cancelled':
        return BookingStatus.cancelled;
      case 'requested':
      default:
        return BookingStatus.requested;
    }
  }
}

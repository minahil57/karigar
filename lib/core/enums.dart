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

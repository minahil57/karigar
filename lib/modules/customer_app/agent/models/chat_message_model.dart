// Enum for distinguishing message bubble types in the chat list
enum ChatMessageType {
  user,
  agentResponse,
  agentStep,
  bookingConfirmed,
  loading,
  error,
  agentThought,
  // ── HITL widget types ──
  providerList, // PROVIDER_LIST widget
  datePicker, // DATE_PICKER widget from provider:selected
  serviceList, // SERVICE_LIST widget
}

// ── AgentStep ──────────────────────────────────────────────────────────────

class AgentStep {
  final String agent;
  final String message;
  final String status; // 'running' | 'done'
  final DateTime? timestamp;

  AgentStep({
    required this.agent,
    required this.message,
    required this.status,
    this.timestamp,
  });

  factory AgentStep.fromJson(Map<String, dynamic> json) => AgentStep(
    agent: json['agent'] as String? ?? '',
    message: json['message'] as String? ?? '',
    status: json['status'] as String? ?? 'running',
    timestamp: json['timestamp'] != null
        ? DateTime.tryParse(json['timestamp'] as String)
        : null,
  );

  AgentStep copyWith({String? status, String? message}) => AgentStep(
    agent: agent,
    message: message ?? this.message,
    status: status ?? this.status,
    timestamp: timestamp,
  );
}

// ── BookingConfirmed ───────────────────────────────────────────────────────

class BookingProvider {
  final String businessName;
  final double rating;

  BookingProvider({required this.businessName, required this.rating});

  factory BookingProvider.fromJson(Map<String, dynamic> json) =>
      BookingProvider(
        businessName: json['businessName'] as String? ?? '',
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      );
}

class BookingConfirmed {
  final String id;
  final String status;
  final String scheduledTime;
  final BookingProvider? provider;
  final DateTime? reminderTime;

  BookingConfirmed({
    required this.id,
    required this.status,
    required this.scheduledTime,
    this.provider,
    this.reminderTime,
  });

  factory BookingConfirmed.fromJson(Map<String, dynamic> json) {
    final providerData =
        json['provider'] ??
        (json['providerService'] is Map
            ? (json['providerService'] as Map)['provider']
            : null);

    return BookingConfirmed(
      id: json['id'] as String? ?? '',
      status: json['status'] as String? ?? '',
      scheduledTime: json['scheduledTime'] as String? ?? '',
      provider: providerData != null
          ? BookingProvider.fromJson(
              Map<String, dynamic>.from(providerData as Map),
            )
          : null,
      reminderTime: json['reminderTime'] != null
          ? DateTime.tryParse(json['reminderTime'] as String)
          : null,
    );
  }
}

// ── RankedProvider ─────────────────────────────────────────────────────────
// Maps to each item in the PROVIDER_LIST widget data array returned by rankingTool.

class RankedProvider {
  final String providerId;
  final String providerServiceId;
  final String businessName;
  final String serviceName;
  final double rating;
  final int reviewCount;
  final String? experience;
  final double? pricePerHour;
  final double? distanceKm;
  final String? area;
  final String? avatar;
  final bool isAvailable;
  // Raw JSON preserved so we can pass extra fields forward if needed
  final Map<String, dynamic> raw;

  RankedProvider({
    required this.providerId,
    required this.providerServiceId,
    required this.businessName,
    required this.serviceName,
    required this.rating,
    required this.reviewCount,
    this.experience,
    this.pricePerHour,
    this.distanceKm,
    this.area,
    this.avatar,
    required this.isAvailable,
    required this.raw,
  });

  factory RankedProvider.fromJson(Map<String, dynamic> json) {
    // 1. Resolve provider map (could be nested under 'provider', or flat on root)
    final providerMap = json['provider'] as Map<String, dynamic>? ?? json;

    // 2. Resolve service map (could be nested under 'service', or inside first item of 'providerServices')
    final serviceList = json['providerServices'] as List?;
    final firstServiceEntry = serviceList != null && serviceList.isNotEmpty
        ? serviceList.first as Map<String, dynamic>
        : null;
    final serviceMap =
        json['service'] as Map<String, dynamic>? ??
        firstServiceEntry?['service'] as Map<String, dynamic>? ??
        {};

    // 3. Resolve business name
    final businessName =
        providerMap['businessName'] as String? ??
        json['businessName'] as String? ??
        'Unknown Provider';

    // 4. Resolve service name
    final serviceName =
        serviceMap['name'] as String? ??
        json['specialty'] as String? ??
        'Service';

    // 5. Resolve providerServiceId (the id of the specific provider-service row, or provider id if empty)
    final providerServiceId =
        firstServiceEntry?['id'] as String? ?? json['id'] as String? ?? '';

    // 6. Resolve rating and review count
    final rating =
        (providerMap['rating'] as num?)?.toDouble() ??
        (json['rating'] as num?)?.toDouble() ??
        0.0;

    final reviewCount =
        (providerMap['reviewCount'] as num?)?.toInt() ??
        (json['reviewCount'] as num?)?.toInt() ??
        0;

    // 7. Resolve price per hour (can be first service's price, or priceRange parsed)
    double? pricePerHour = (json['pricePerHour'] as num?)?.toDouble();
    if (pricePerHour == null && firstServiceEntry != null) {
      pricePerHour = (firstServiceEntry['price'] as num?)?.toDouble();
    }
    if (pricePerHour == null && json['priceRange'] != null) {
      final pr = json['priceRange'];
      if (pr is num) {
        pricePerHour = pr.toDouble();
      } else if (pr is String) {
        pricePerHour = double.tryParse(pr);
      }
    }

    // 8. Resolve distance
    final distanceKm =
        (json['distance_km'] as num?)?.toDouble() ??
        (json['distanceKm'] as num?)?.toDouble();

    // 9. Resolve availability
    final isAvailable =
        json['isAvailable'] as bool? ?? json['available'] as bool? ?? true;

    // 10. Resolve experience and area
    final experience = providerMap['experienceYears'] != null
        ? '${providerMap['experienceYears']} years'
        : providerMap['experience'] as String?;

    final addressMap = json['address'] as Map<String, dynamic>?;
    final area =
        providerMap['area'] as String? ?? addressMap?['city'] as String?;

    final avatar = json['avatar'] as String? ?? json['avatar'] as String? ?? '';

    // 11. Resolve providerId (the UUID of the provider)
    final providerId =
        providerMap['id'] as String? ?? json['id'] as String? ?? '';

    return RankedProvider(
      providerId: providerId,
      providerServiceId: providerServiceId,
      businessName: businessName,
      serviceName: serviceName,
      rating: rating,
      reviewCount: reviewCount,
      experience: experience,
      pricePerHour: pricePerHour,
      distanceKm: distanceKm,
      area: area,
      avatar: avatar,
      isAvailable: isAvailable,
      raw: json,
    );
  }
}

// ── DatePickerData ─────────────────────────────────────────────────────────
// Data for the DATE_PICKER widget emitted by the server.

class DatePickerData {
  final String providerServiceId;
  final String? providerName;

  DatePickerData({required this.providerServiceId, this.providerName});

  factory DatePickerData.fromJson(Map<String, dynamic> json) => DatePickerData(
    providerServiceId: json['providerServiceId'] as String? ?? '',
    providerName: json['providerName'] as String?,
  );
}

// ── ChatMessage ────────────────────────────────────────────────────────────

class ChatMessage {
  final String id;
  final ChatMessageType type;

  // text bubble (user or agent response)
  final String? text;

  // agent:step
  final AgentStep? step;

  // booking:confirmed
  final BookingConfirmed? booking;

  // PROVIDER_LIST widget
  final List<RankedProvider>? providers;

  // DATE_PICKER widget
  final DatePickerData? datePickerData;

  // SERVICE_LIST widget
  final List<String>? services;

  final DateTime createdAt;

  ChatMessage._({
    required this.id,
    required this.type,
    this.text,
    this.step,
    this.booking,
    this.providers,
    this.datePickerData,
    this.services,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // ── Factories ──────────────────────────────────────────────────────────────

  factory ChatMessage.user(String text) =>
      ChatMessage._(id: _uid(), type: ChatMessageType.user, text: text);

  factory ChatMessage.agentResponse(String text) => ChatMessage._(
    id: _uid(),
    type: ChatMessageType.agentResponse,
    text: text,
  );

  factory ChatMessage.loading() =>
      ChatMessage._(id: 'loading', type: ChatMessageType.loading);

  factory ChatMessage.agentStep(AgentStep step) => ChatMessage._(
    id: 'step_${step.agent}',
    type: ChatMessageType.agentStep,
    step: step,
  );

  factory ChatMessage.agentThought(String text) => ChatMessage._(
    id: 'agent_thought_${_uid()}',
    type: ChatMessageType.agentThought,
    text: text,
  );

  factory ChatMessage.bookingConfirmed(BookingConfirmed booking) =>
      ChatMessage._(
        id: _uid(),
        type: ChatMessageType.bookingConfirmed,
        booking: booking,
      );

  factory ChatMessage.error(String text) =>
      ChatMessage._(id: _uid(), type: ChatMessageType.error, text: text);

  factory ChatMessage.providerList(List<RankedProvider> providers) =>
      ChatMessage._(
        id: _uid(),
        type: ChatMessageType.providerList,
        providers: providers,
      );

  factory ChatMessage.datePicker(DatePickerData data) => ChatMessage._(
    id: 'date_picker_${data.providerServiceId}',
    type: ChatMessageType.datePicker,
    datePickerData: data,
  );

  factory ChatMessage.serviceList(List<String> services) => ChatMessage._(
    id: _uid(),
    type: ChatMessageType.serviceList,
    services: services,
  );

  ChatMessage copyWithId(String newId) => ChatMessage._(
    id: newId,
    type: type,
    text: text,
    step: step,
    booking: booking,
    providers: providers,
    datePickerData: datePickerData,
    services: services,
    createdAt: createdAt,
  );

  static String _uid() => DateTime.now().microsecondsSinceEpoch.toString();
}

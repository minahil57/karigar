// Enum for distinguishing message bubble types in the chat list
enum ChatMessageType { user, agentResponse, agentStep, bookingConfirmed, loading, error }

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

  factory BookingProvider.fromJson(Map<String, dynamic> json) => BookingProvider(
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

  factory BookingConfirmed.fromJson(Map<String, dynamic> json) => BookingConfirmed(
        id: json['id'] as String? ?? '',
        status: json['status'] as String? ?? '',
        scheduledTime: json['scheduledTime'] as String? ?? '',
        provider: json['provider'] != null
            ? BookingProvider.fromJson(json['provider'] as Map<String, dynamic>)
            : null,
        reminderTime: json['reminderTime'] != null
            ? DateTime.tryParse(json['reminderTime'] as String)
            : null,
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

  final DateTime createdAt;

  ChatMessage._({
    required this.id,
    required this.type,
    this.text,
    this.step,
    this.booking,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // ── Factories ──────────────────────────────────────────────────────────────

  factory ChatMessage.user(String text) => ChatMessage._(
        id: _uid(),
        type: ChatMessageType.user,
        text: text,
      );

  factory ChatMessage.agentResponse(String text) => ChatMessage._(
        id: _uid(),
        type: ChatMessageType.agentResponse,
        text: text,
      );

  factory ChatMessage.loading() => ChatMessage._(
        id: 'loading',
        type: ChatMessageType.loading,
      );

  factory ChatMessage.agentStep(AgentStep step) => ChatMessage._(
        id: 'step_${step.agent}',
        type: ChatMessageType.agentStep,
        step: step,
      );

  factory ChatMessage.bookingConfirmed(BookingConfirmed booking) => ChatMessage._(
        id: _uid(),
        type: ChatMessageType.bookingConfirmed,
        booking: booking,
      );

      factory ChatMessage.error(String text) => ChatMessage._(
        id: _uid(),
        type: ChatMessageType.error,
        text: text,
      );

  static String _uid() => DateTime.now().microsecondsSinceEpoch.toString();
}

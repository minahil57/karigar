import 'package:karigar/export.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService extends GetxService {
  late io.Socket _socket;
  bool _initialized = false;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  Future<SocketService> init() async {
    return this;
  }

  void connect(String token) {
    if (_initialized) return;

    _socket = io.io(
      EndPoints.baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({'token': token})
          .build(),
    );

    _socket.connect();
    _initialized = true;

    _socket.onConnect((_) => log('[Socket] Connected: ${_socket.id}'));
    _socket.onDisconnect((_) => log('[Socket] Disconnected'));
    _socket.onConnectError((e) => log('[Socket] Connection error: $e'));
  }

  void disconnect() {
    if (_initialized) {
      _socket.dispose();
      _initialized = false;
    }
  }

  // ── Emit ───────────────────────────────────────────────────────────────────

  void sendMessage({required String message, required String token}) {
    if (!_initialized) {
      log('[Socket] Not connected — cannot send message');
      return;
    }
    _socket.emit('message', {'message': message, 'token': token});
    log('[Socket] Emitted message: $message');
  }

  void cancelResponse() {
    if (!_initialized) {
      log('[Socket] Not connected — cannot cancel');
      return;
    }
    _socket.emit('cancel');
    log('[Socket] Emitted cancel');
  }

  /// Emits [provider:selected] to the server.
  ///
  /// If [scheduledTime], [requestedDay], and [requestedTime] are all provided,
  /// the server calls bookingTool directly (no Gemini re-run).
  /// If any are missing, the server responds with a [DATE_PICKER].
  void emitProviderSelected({
    String? providerId,
    required String providerServiceId,
    String? serviceName,
    required String token,
    String? scheduledTime,
    String? requestedDay,
    String? requestedTime,
    String? location,
  }) {
    if (!_initialized) {
      log('[Socket] Not connected — cannot emit provider:selected');
      return;
    }
    final payload = <String, dynamic>{
      'providerId': providerId,
      'providerServiceId': providerServiceId,
      'serviceName': serviceName,
      'token': token,
      'scheduledTime': scheduledTime,
      'requestedDay': requestedDay,
      'requestedTime': requestedTime,
      'location': location,
    };
    _socket.emit('provider:selected', payload);
    log('[Socket] Emitted provider:selected for $providerServiceId');
  }

  /// Emits [service:selected] to the server.
  /// Server synthesises "Show me providers for {serviceName}" → runs DISCOVERY flow.
  void emitServiceSelected({
    required String serviceName,
    required String token,
  }) {
    if (!_initialized) {
      log('[Socket] Not connected — cannot emit service:selected');
      return;
    }
    _socket.emit('service:selected', {'serviceName': serviceName, 'token': token});
    log('[Socket] Emitted service:selected: $serviceName');
  }

  // ── Listen ─────────────────────────────────────────────────────────────────

  void on(String event, Function(dynamic) handler) {
    if (!_initialized) {
      log('[Socket] Warning: Registering listener "$event" before connect()');
    }
    _socket.on(event, (data) {
      log('[Socket] Received event "$event" with data: $data');
      handler(data);
    });
  }

  void off(String event) {
    if (!_initialized) return;
    _socket.off(event);
  }
}

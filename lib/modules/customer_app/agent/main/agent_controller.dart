import 'package:karigar/export.dart';

class AgentController extends GetxController {
  // ── Dependencies ────────────────────────────────────────────────────────────
  late final SocketService _socketService;

  // ── Input ───────────────────────────────────────────────────────────────────
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final RxBool isIputEmpty = true.obs;

  // ── Reactive State ──────────────────────────────────────────────────────────
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isThinking = false.obs;

  // ── Suggestions ─────────────────────────────────────────────────────────────
  final List<Map<String, String>> suggestions = [
    {'title': "What is Karigar AI?", 'icon': 'electrician'},
    {'title': "Mujhe Ek Painter chahiye", 'icon': 'painter'},
    {'title': "Mujhe Ek Plumber chahiye", 'icon': 'plumber'},
  ];

  // ── Greeting ────────────────────────────────────────────────────────────────
  String get greeting {
    final hour = DateTime.now().hour;
    String g;
    if (hour < 12) {
      g = 'Good Morning';
    } else if (hour < 17) {
      g = 'Good Afternoon';
    } else {
      g = 'Good Evening';
    }
    return "$g, ${getUser()?.name ?? 'User'}!";
  }

  // ── Lifecycle ────────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _socketService = Get.find<SocketService>();
    messageController.addListener(_onMessageTextChanged);
    _initChat();
  }

  Future<void> _initChat() async {
    await _connectSocket();
    _registerEventListeners();
  }

  @override
  void onClose() {
    messageController.removeListener(_onMessageTextChanged);
    messageController.dispose();
    scrollController.dispose();
    _removeEventListeners();
    super.onClose();
  }

  // ── Socket Connection ────────────────────────────────────────────────────────
  Future<void> _connectSocket() async {
    final token = await getAccessToken();
    _socketService.connect(token);
  }

  void _registerEventListeners() {
    _socketService.on('agent:loading', _onAgentLoading);
    _socketService.on('agent:step', _onAgentStep);
    _socketService.on('agent:thought', _onAgentThought);
    _socketService.on('agent:response', _onAgentResponse);
    _socketService.on('booking:confirmed', _onBookingConfirmed);
    _socketService.on('agent:done', _onAgentDone);
    _socketService.on('agent:error', _onAgentError);
  }

  void _removeEventListeners() {
    _socketService.off('agent:loading');
    _socketService.off('agent:step');
    _socketService.off('agent:thought');
    _socketService.off('agent:response');
    _socketService.off('booking:confirmed');
    _socketService.off('agent:done');
    _socketService.off('agent:error');
  }

  // ── Event Handlers ───────────────────────────────────────────────────────────

  void _onAgentLoading(dynamic data) {
    isThinking.value = true;
    // Remove any stale loading bubble, then add fresh one
    messages.removeWhere((m) => m.type == ChatMessageType.loading);
    messages.add(ChatMessage.loading());
    _scrollToBottom();
  }

  void _onAgentThought(dynamic data) {
    if (data is! Map) return;
    final text = data['text'] as String? ?? '';
    if (text.isEmpty) return;

    // Insert before the loading bubble
    final loadingIdx = messages.indexWhere(
      (m) => m.type == ChatMessageType.loading,
    );
    if (loadingIdx >= 0) {
      messages.insert(loadingIdx, ChatMessage.agentThought(text));
    } else {
      messages.add(ChatMessage.agentThought(text));
    }
    _scrollToBottom();
  }

  void _onAgentStep(dynamic data) {
    if (data is! Map) return;
    final step = AgentStep.fromJson(Map<String, dynamic>.from(data));

    // Upsert step by agent key (step id = 'step_${step.agent}')
    final idx = messages.indexWhere((m) => m.id == 'step_${step.agent}');
    if (idx >= 0) {
      messages[idx] = ChatMessage.agentStep(step);
    } else {
      // Insert before the loading bubble
      final loadingIdx = messages.indexWhere(
        (m) => m.type == ChatMessageType.loading,
      );
      if (loadingIdx >= 0) {
        messages.insert(loadingIdx, ChatMessage.agentStep(step));
      } else {
        messages.add(ChatMessage.agentStep(step));
      }
    }
    _scrollToBottom();
  }

  void _onAgentResponse(dynamic data) {
    if (data is! Map) return;
    final text = data['message'] as String? ?? '';
    _removeLoading();

    // Find if we already have an active streaming response bubble
    final idx = messages.indexWhere((m) => m.id == 'agent_response');
    if (idx >= 0) {
      messages[idx] = ChatMessage.agentResponse(
        text,
      ).copyWithId('agent_response');
    } else {
      _freezeActiveThoughtsAndSteps();
      messages.add(
        ChatMessage.agentResponse(text).copyWithId('agent_response'),
      );
    }
    _scrollToBottom();
  }

  void _onBookingConfirmed(dynamic data) {
    if (data is! Map) return;
    final booking = BookingConfirmed.fromJson(Map<String, dynamic>.from(data));
    messages.add(ChatMessage.bookingConfirmed(booking));
    _scrollToBottom();
  }

  void _onAgentDone(dynamic _) {
    isThinking.value = false;
    _removeLoading();

    // Finalize the streaming response bubble by giving it a unique ID
    final idx = messages.indexWhere((m) => m.id == 'agent_response');
    if (idx >= 0) {
      messages[idx] = messages[idx].copyWithId(
        '${DateTime.now().microsecondsSinceEpoch}_agent_response',
      );
    }
  }

  void _onAgentError(dynamic data) {
    isThinking.value = false;
    _removeLoading();
    _freezeActiveThoughtsAndSteps();

    // Finalize any active streaming response
    final idx = messages.indexWhere((m) => m.id == 'agent_response');
    if (idx >= 0) {
      messages[idx] = messages[idx].copyWithId(
        '${DateTime.now().microsecondsSinceEpoch}_agent_response',
      );
    }

    final msg =
        (data is Map ? data['message'] : null) as String? ??
        'Something went wrong. Please try again.';

    // Add inline error bubble
    messages.add(ChatMessage.error(msg));
    _scrollToBottom();
  }

  // ── Send Message ─────────────────────────────────────────────────────────────
  Future<void> sendMessage({String? customText}) async {
    final text = (customText ?? messageController.text).trim();
    // close keyboard
    FocusScope.of(Get.context!).unfocus();
    if (text.isEmpty) return;

    _freezeActiveThoughtsAndSteps();

    // 1. Show user bubble immediately
    messages.add(ChatMessage.user(text));

    // Optimistic loading
    isThinking.value = true;
    messages.add(ChatMessage.loading());

    messageController.clear();
    _scrollToBottom();

    // 2. Emit to server
    final token = await getAccessToken();
    _socketService.sendMessage(message: text, token: token);
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────
  void _onMessageTextChanged() {
    isIputEmpty.value = messageController.text.trim().isEmpty;
    update();
  }

  void _freezeActiveThoughtsAndSteps() {
    for (int i = 0; i < messages.length; i++) {
      final msg = messages[i];
      if (msg.id == 'agent_thought' ||
          msg.id.startsWith('step_') ||
          msg.id == 'agent_response') {
        messages[i] = msg.copyWithId(
          '${DateTime.now().microsecondsSinceEpoch}_${msg.id}',
        );
      }
    }
  }

  void _removeLoading() {
    messages.removeWhere((m) => m.type == ChatMessageType.loading);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

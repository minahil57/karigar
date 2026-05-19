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
  String _accumulatedRawJson = '';
  String? selectedProviderId;
  String? selectedProviderServiceId;

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
    _syncFcmToken();
    PermissionHandlerService.requestAppPermissions().then((value) => fetchCurrentAddress());
    _socketService = Get.find<SocketService>();
    messageController.addListener(_onMessageTextChanged);
    _initChat();
  }

  Future<void> _syncFcmToken() async {
    try {
      await AuthRepository.syncFcmToken();
    } catch (e) {
      log('[AgentController] FCM token sync failed: $e');
    }
  }

  Future<void> fetchCurrentAddress() async {
    try {
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        await CustomerRepository.updateProfile({
          'lat': position.latitude,
          'lng': position.longitude,
        });
      }
    } catch (e) {
      log('[AgentController] Error updating location: $e');
    }
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
    _socketService.on('agent:done', _onAgentDone);
    _socketService.on('agent:error', _onAgentError);
    _socketService.on('booking:confirmed', _onBookingConfirmed);
  }

  void _removeEventListeners() {
    _socketService.off('agent:loading');
    _socketService.off('agent:step');
    _socketService.off('agent:thought');
    _socketService.off('agent:response');
    _socketService.off('agent:done');
    _socketService.off('agent:error');
    _socketService.off('booking:confirmed');
  }

  // ── Event Handlers ───────────────────────────────────────────────────────────

  void _onBookingConfirmed(dynamic data) {
    isThinking.value = false;
    _removeLoading();
    _freezeActiveThoughtsAndSteps();

    // Finalize any active streaming response bubble
    final idx = messages.indexWhere((m) => m.id == 'agent_response');
    if (idx >= 0) {
      messages[idx] = messages[idx].copyWithId(
        '${DateTime.now().microsecondsSinceEpoch}_agent_response',
      );
    }

    _accumulatedRawJson = ''; // Clear raw JSON

    if (data is! Map) return;
    try {
      final booking = BookingConfirmed.fromJson(Map<String, dynamic>.from(data));
      final alreadyShown = messages.any(
        (m) =>
            m.type == ChatMessageType.bookingConfirmed &&
            m.booking?.id == booking.id,
      );
      if (!alreadyShown) {
        messages.add(ChatMessage.bookingConfirmed(booking));
        _scrollToBottom();
      }
    } catch (e) {
      log('[AgentController] Error parsing booking confirmation: $e');
    }
  }

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
    final rawText = data['message'] as String? ?? '';
    _removeLoading();

    String cleanText = rawText;
    if (rawText.trim().startsWith('{')) {
      _accumulatedRawJson = rawText;

      // Extract the nested message field from streaming partial JSON using a robust regex
      final match = RegExp(
        r'"message"\s*:\s*"((?:[^"\\]|\\.)*?)(?:"|$)',
      ).firstMatch(rawText);
      if (match != null) {
        cleanText = match.group(1) ?? '';
        cleanText = cleanText
            .replaceAll(r'\"', '"')
            .replaceAll(r'\n', '\n')
            .replaceAll(r'\t', '\t')
            .replaceAll(r'\\', '\\');
      } else {
        cleanText = ''; // Hide raw JSON brackets until message content begins
      }
    }

    // Find if we already have an active streaming response bubble
    final idx = messages.indexWhere((m) => m.id == 'agent_response');
    if (idx >= 0) {
      messages[idx] = ChatMessage.agentResponse(
        cleanText,
      ).copyWithId('agent_response');
    } else {
      _freezeActiveThoughtsAndSteps();
      messages.add(
        ChatMessage.agentResponse(cleanText).copyWithId('agent_response'),
      );
    }
    _scrollToBottom();
  }

  void _onAgentDone(dynamic _) {
    isThinking.value = false;
    _removeLoading();

    // Find the streaming response bubble to finalize it
    final idx = messages.indexWhere((m) => m.id == 'agent_response');
    if (idx >= 0) {
      if (_accumulatedRawJson.isNotEmpty) {
        try {
          final parsed =
              jsonDecode(_accumulatedRawJson) as Map<String, dynamic>;
          final cleanText = parsed['message'] as String? ?? '';

          // Finalize text bubble with clean plain text
          messages[idx] = ChatMessage.agentResponse(cleanText).copyWithId(
            '${DateTime.now().microsecondsSinceEpoch}_agent_response',
          );

          // Extract and display the structured widget if present in the response
          if (parsed['widget'] is Map) {
            final wMap = parsed['widget'] as Map<String, dynamic>;
            final wType = wMap['type'] as String? ?? '';
            final wData = wMap['data'];

            _handleWidget(wType, wData);
          }
        } catch (e) {
          log('[AgentController] Error parsing final structured response: $e');
          // Fallback: finalize response as-is
          messages[idx] = messages[idx].copyWithId(
            '${DateTime.now().microsecondsSinceEpoch}_agent_response',
          );
        }
      } else {
        // Fallback: finalize response as-is
        messages[idx] = messages[idx].copyWithId(
          '${DateTime.now().microsecondsSinceEpoch}_agent_response',
        );
      }
    }

    // Reset state for next interaction
    _accumulatedRawJson = '';
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

    _accumulatedRawJson = ''; // Clear raw JSON on error

    final msg =
        (data is Map ? data['message'] : null) as String? ??
        'Something went wrong. Please try again.';

    // Add inline error bubble
    messages.add(ChatMessage.error(msg));
    _scrollToBottom();
  }

  /// Dispatches structured widget data extracted from response format
  void _handleWidget(String wType, dynamic wData) {
    switch (wType) {
      case 'providers':
      case 'PROVIDER_LIST':
        dynamic providersData = wData;
        if (wData is String) {
          try {
            providersData = jsonDecode(wData);
          } catch (e) {
            log('[AgentController] Error decoding providers string: $e');
          }
        }
        if (providersData is List) {
          final providers = providersData
              .whereType<Map>()
              .map((e) => RankedProvider.fromJson(Map<String, dynamic>.from(e)))
              .toList();
          if (providers.isNotEmpty) {
            messages.add(ChatMessage.providerList(providers));
            _scrollToBottom();
          }
        }

      case 'services':
      case 'SERVICE_LIST':
        dynamic servicesData = wData;
        if (wData is String) {
          try {
            servicesData = jsonDecode(wData);
          } catch (e) {
            log('[AgentController] Error decoding services string: $e');
          }
        }
        if (servicesData is List) {
          final services = servicesData.cast<String>();
          if (services.isNotEmpty) {
            messages.add(ChatMessage.serviceList(services));
            _scrollToBottom();
          }
        }

      case 'booking_confirmation':
      case 'BOOKING_CONFIRMATION':
        dynamic bookingData = wData;
        if (wData is String) {
          try {
            bookingData = jsonDecode(wData);
          } catch (e) {
            log('[AgentController] Error decoding booking string: $e');
          }
        }
        if (bookingData is Map) {
          final booking = BookingConfirmed.fromJson(
            Map<String, dynamic>.from(bookingData),
          );
          final alreadyShown = messages.any(
            (m) =>
                m.type == ChatMessageType.bookingConfirmed &&
                m.booking?.id == booking.id,
          );
          if (!alreadyShown) {
            messages.add(ChatMessage.bookingConfirmed(booking));
            _scrollToBottom();
          }
        }
    }
  }

  // ── HITL Actions ─────────────────────────────────────────────────────────────

  /// Called when the user taps a service card in [ServiceListWidget].
  Future<void> onServiceTap(String serviceName) async {
    if (selectedProviderId != null) {
      // 2-Step Booking Flow: User has selected a provider, now selected a service, so show the Date/Time Picker dialogs
      if (Get.context == null || !Get.context!.mounted) {
        log('[AgentController] Cannot show pickers - no active context available');
        return;
      }

      // 1. Show Date Picker
      final now = DateTime.now();
      final pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: now,
        firstDate: now,
        lastDate: now.add(const Duration(days: 60)),
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: kcSecondaryColor,
                ),
          ),
          child: child!,
        ),
      );

      if (pickedDate == null) {
        log('[AgentController] Date picking cancelled');
        return; // User cancelled
      }

      if (Get.context == null || !Get.context!.mounted) {
        log('[AgentController] Context unmounted after date picker');
        return;
      }

      // 2. Show Time Picker
      final pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: const TimeOfDay(hour: 10, minute: 0),
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: kcSecondaryColor,
                ),
          ),
          child: child!,
        ),
      );

      if (pickedTime == null) {
        log('[AgentController] Time picking cancelled');
        return; // User cancelled
      }

      // 3. Format date and time
      final weekday = _weekdayName(pickedDate.weekday);
      final hour = pickedTime.hour;
      final minute = pickedTime.minute;
      final h12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      final amPm = hour >= 12 ? 'PM' : 'AM';
      final minuteStr = minute.toString().padLeft(2, '0');

      final finalScheduledTime = '$weekday at $h12:$minuteStr $amPm';
      final finalRequestedDay = weekday.toLowerCase();
      final finalRequestedTime = '${hour.toString().padLeft(2, '0')}:$minuteStr';

      // Show optimistic loading
      isThinking.value = true;
      messages.add(ChatMessage.loading());
      _scrollToBottom();

      final token = await getAccessToken();
      _socketService.emitProviderSelected(
        providerId: selectedProviderId,
        providerServiceId: selectedProviderServiceId ?? '',
        serviceName: serviceName,
        token: token,
        scheduledTime: finalScheduledTime,
        requestedDay: finalRequestedDay,
        requestedTime: finalRequestedTime,
      );
      
      log('[AgentController] Emitted final provider:selected for booking. resetting state.');
      
      // Reset selected provider/service states
      selectedProviderId = null;
      selectedProviderServiceId = null;
      return;
    }

    // Fallback: If no provider is currently selected in state, we do the original flow
    isThinking.value = true;
    messages.add(ChatMessage.loading());
    _scrollToBottom();

    final token = await getAccessToken();
    _socketService.emitServiceSelected(serviceName: serviceName, token: token);
    log('[AgentController] Emitted service:selected for $serviceName');
  }

  Future<void> onProviderTap(
    RankedProvider provider, {
    String? scheduledTime,
    String? requestedDay,
    String? requestedTime,
  }) async {
    // Save selected provider references
    selectedProviderId = provider.providerId;
    selectedProviderServiceId = provider.providerServiceId;
    
    // Show optimistic loading
    isThinking.value = true;
    messages.add(ChatMessage.loading());
    _scrollToBottom();

    final token = await getAccessToken();
    // Emit provider:selected with no time info to get services
    _socketService.emitProviderSelected(
      providerId: provider.providerId,
      providerServiceId: provider.providerServiceId,
      token: token,
    );
    log(
      '[AgentController] Emitted provider:selected for service discovery: ${provider.businessName}',
    );
  }

  String _weekdayName(int weekday) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[(weekday - 1) % 7];
  }

  /// Called when the user confirms a date+time in [DatePickerWidget].
  ///
  /// [scheduledTime] — human-readable string, e.g. "Friday at 2:00 PM"
  /// [requestedDay]  — lowercase weekday, e.g. "friday"
  /// [requestedTime] — 24h time, e.g. "14:00"
  Future<void> onDateTimePicked({
    required String providerServiceId,
    required String scheduledTime,
    required String requestedDay,
    required String requestedTime,
  }) async {
    // Remove the date-picker card from the list
    messages.removeWhere(
      (m) =>
          m.type == ChatMessageType.datePicker &&
          m.datePickerData?.providerServiceId == providerServiceId,
    );

    // Show optimistic loading
    isThinking.value = true;
    messages.add(ChatMessage.loading());
    _scrollToBottom();

    final token = await getAccessToken();
    _socketService.emitProviderSelected(
      providerServiceId: providerServiceId,
      token: token,
      scheduledTime: scheduledTime,
      requestedDay: requestedDay,
      requestedTime: requestedTime,
    );
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

  void cancelResponse() {
    if (!isThinking.value) return;

    // 1. Emit cancel to the server
    _socketService.cancelResponse();

    // 2. Set isThinking to false immediately
    isThinking.value = false;

    // 3. Remove loading indicator
    _removeLoading();

    // 4. Finalize the active streaming response bubble by giving it a unique ID
    final idx = messages.indexWhere((m) => m.id == 'agent_response');
    if (idx >= 0) {
      messages[idx] = messages[idx].copyWithId(
        '${DateTime.now().microsecondsSinceEpoch}_agent_response',
      );
    }

    // 5. Add a friendly inline error/cancellation bubble
    messages.add(ChatMessage.error("You cancelled request"));
    _scrollToBottom();
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

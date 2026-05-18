import 'dart:ui';
import 'package:karigar/export.dart';

/// Renders an inline [DATE_PICKER] widget emitted by the server when a provider
/// is tapped but no time context is available.
///
/// Shows a material date + time picker flow. On confirmation, calls
/// [AgentController.onDateTimePicked] with structured time data.
class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key, required this.data});

  final DatePickerData data;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isConfirming = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: EdgeInsets.all(18.r),
            decoration: BoxDecoration(
              color: kcWhitecolor.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: kcWhitecolor.withValues(alpha: 0.9),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: kcBlackColor.withValues(alpha: 0.06),
                  blurRadius: 14.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ─────────────────────────────────────────────────
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: kcSecondaryColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Iconsax.calendar,
                        size: 16.r,
                        color: kcSecondaryColor,
                      ),
                    ),
                    horizontalSpace(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'When should they come?',
                          fontSize: 13,
                          variant: TextVariant.medium,
                          color: kcTextBlackcolor,
                        ),
                        if (widget.data.providerName != null)
                          CustomText(
                            text: widget.data.providerName!,
                            fontSize: 11,
                            color: kcTextGreyColor,
                          ),
                      ],
                    ),
                  ],
                ),

                verticalSpace(16),

                // ── Date selector ─────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _SelectorTile(
                        icon: Iconsax.calendar_1,
                        label: _selectedDate != null
                            ? _formatDate(_selectedDate!)
                            : 'Pick a date',
                        isSelected: _selectedDate != null,
                        onTap: _pickDate,
                      ),
                    ),
                    horizontalSpace(10),
                    Expanded(
                      child: _SelectorTile(
                        icon: Iconsax.clock,
                        label: _selectedTime != null
                            ? _selectedTime!.format(context)
                            : 'Pick a time',
                        isSelected: _selectedTime != null,
                        onTap: _pickTime,
                      ),
                    ),
                  ],
                ),

                verticalSpace(14),

                // ── Confirm button ────────────────────────────────────────
                _ConfirmButton(
                  enabled:
                      _selectedDate != null && _selectedTime != null && !_isConfirming,
                  isLoading: _isConfirming,
                  onTap: _confirm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
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
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
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
    if (picked != null) setState(() => _selectedTime = picked);
  }

  Future<void> _confirm() async {
    if (_selectedDate == null || _selectedTime == null) return;
    setState(() => _isConfirming = true);

    final controller = Get.find<AgentController>();

    // Build structured time strings expected by the server
    final weekday = _weekdayName(_selectedDate!.weekday);
    final hour = _selectedTime!.hour;
    final minute = _selectedTime!.minute;
    final h12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final amPm = hour >= 12 ? 'PM' : 'AM';
    final minuteStr = minute.toString().padLeft(2, '0');

    final scheduledTime = '$weekday at $h12:$minuteStr $amPm';
    final requestedDay = weekday.toLowerCase();
    final requestedTime =
        '${hour.toString().padLeft(2, '0')}:$minuteStr';

    await controller.onDateTimePicked(
      providerServiceId: widget.data.providerServiceId,
      scheduledTime: scheduledTime,
      requestedDay: requestedDay,
      requestedTime: requestedTime,
    );
  }

  String _formatDate(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${_weekdayName(dt.weekday)}, ${dt.day} ${months[dt.month - 1]}';
  }

  String _weekdayName(int weekday) {
    const days = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      'Friday', 'Saturday', 'Sunday',
    ];
    return days[(weekday - 1) % 7];
  }
}

// ── Sub-widgets ────────────────────────────────────────────────────────────

class _SelectorTile extends StatelessWidget {
  const _SelectorTile({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? kcSecondaryColor.withValues(alpha: 0.1)
              : kcBlackColor.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? kcSecondaryColor.withValues(alpha: 0.5)
                : kcTextGreyColor.withValues(alpha: 0.2),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 14.r,
              color: isSelected ? kcSecondaryColor : kcTextGreyColor,
            ),
            horizontalSpace(6),
            Expanded(
              child: CustomText(
                text: label,
                fontSize: 11,
                variant: isSelected ? TextVariant.medium : TextVariant.regular,
                color: isSelected ? kcSecondaryColor : kcTextGreyColor,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({
    required this.enabled,
    required this.isLoading,
    required this.onTap,
  });

  final bool enabled;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          gradient: enabled
              ? LinearGradient(
                  colors: [
                    kcSecondaryColor,
                    kcSecondaryColor.withValues(alpha: 0.8),
                  ],
                )
              : null,
          color: enabled ? null : kcTextGreyColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: kcSecondaryColor.withValues(alpha: 0.35),
                    blurRadius: 8.r,
                    offset: Offset(0, 3.h),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 18.r,
                  height: 18.r,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Iconsax.calendar_tick,
                      size: 14.r,
                      color: enabled ? Colors.white : kcTextGreyColor,
                    ),
                    horizontalSpace(6),
                    CustomText(
                      text: 'Confirm Booking',
                      fontSize: 13,
                      variant: TextVariant.medium,
                      color: enabled ? Colors.white : kcTextGreyColor,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

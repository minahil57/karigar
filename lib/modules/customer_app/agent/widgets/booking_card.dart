import 'package:karigar/export.dart';

/// Rich card shown when a booking is successfully confirmed by the server.
class BookingCard extends StatelessWidget {
  const BookingCard({super.key, required this.booking});

  final BookingConfirmed booking;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kcSecondaryColor,
              kcSecondaryColor.withValues(alpha: 0.75),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: kcSecondaryColor.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────────
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Iconsax.calendar_tick,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  horizontalSpace(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Booking Confirmed!',
                        fontSize: 16,
                        variant: TextVariant.medium,
                        color: Colors.white,
                      ),
                      CustomText(
                        text: booking.status.toUpperCase(),
                        fontSize: 10,
                        color: Colors.white.withValues(alpha: 0.75),
                        variant: TextVariant.medium,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),
              _divider(),
              const SizedBox(height: 16),

              // ── Provider ────────────────────────────────────────────────
              if (booking.provider != null) ...[
                _infoRow(
                  icon: Iconsax.user,
                  label: booking.provider!.businessName,
                ),
                const SizedBox(height: 10),
                _ratingRow(booking.provider!.rating),
                const SizedBox(height: 10),
              ],

              // ── Scheduled Time ───────────────────────────────────────────
              _infoRow(icon: Iconsax.clock, label: booking.scheduledTime),

              if (booking.reminderTime != null) ...[
                const SizedBox(height: 10),
                _infoRow(
                  icon: Iconsax.notification,
                  label: 'Reminder at ${_formatTime(booking.reminderTime!)}',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() =>
      Container(height: 1, color: Colors.white.withValues(alpha: 0.2));

  Widget _infoRow({required IconData icon, required String label}) => Row(
    children: [
      Icon(icon, size: 16, color: Colors.white.withValues(alpha: 0.85)),
      horizontalSpace(8),
      Expanded(
        child: CustomText(text: label, fontSize: 13, color: Colors.white),
      ),
    ],
  );

  Widget _ratingRow(double rating) => Row(
    children: [
      ...List.generate(5, (i) {
        final filled = i < rating.floor();
        final half = !filled && i < rating;
        return Icon(
          half ? Icons.star_half : (filled ? Icons.star : Icons.star_border),
          size: 14,
          color: Colors.amber,
        );
      }),
      horizontalSpace(6),
      CustomText(
        text: rating.toStringAsFixed(1),
        fontSize: 12,
        color: Colors.white.withValues(alpha: 0.9),
        variant: TextVariant.medium,
      ),
    ],
  );

  String _formatTime(DateTime dt) {
    final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour;
    final amPm = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${dt.minute.toString().padLeft(2, '0')} $amPm';
  }
}

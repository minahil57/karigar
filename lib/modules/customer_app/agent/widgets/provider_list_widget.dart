import 'dart:ui';

import 'package:karigar/export.dart';

/// Renders a [PROVIDER_LIST] widget — a horizontally scrollable row of
/// provider cards returned by the ranking tool.
///
/// Each card shows: name, service, rating, distance, price, availability.
/// Tapping a card calls [AgentController.onProviderTap].
class ProviderListWidget extends StatelessWidget {
  const ProviderListWidget({super.key, required this.providers});

  final List<RankedProvider> providers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section header ────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: kcSecondaryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Iconsax.people,
                    size: 14.r,
                    color: kcSecondaryColor,
                  ),
                ),
                horizontalSpace(8),
                CustomText(
                  text: '${providers.length} Providers Found',
                  fontSize: 13,
                  variant: TextVariant.medium,
                  color: kcTextBlackcolor,
                ),
              ],
            ),
          ),
          verticalSpace(10),

          // ── Horizontal cards list ─────────────────────────────────────────
          SizedBox(
            height: 220.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              physics: const BouncingScrollPhysics(),
              itemCount: providers.length,
              separatorBuilder: (context, index) => horizontalSpace(12),
              itemBuilder: (context, i) =>
                  _ProviderCard(provider: providers[i]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Individual provider card ───────────────────────────────────────────────

class _ProviderCard extends StatelessWidget {
  const _ProviderCard({required this.provider});

  final RankedProvider provider;

  @override
  Widget build(BuildContext context) {
    log(provider.avatar ?? "");
    final controller = Get.find<AgentController>();

    return GestureDetector(
      onTap: () => controller.onProviderTap(provider),
      child: SizedBox(
        width: 180.w,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: EdgeInsets.all(14.r),
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
                    blurRadius: 12.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Avatar + availability dot ────────────────────────────
                  Row(
                    children: [_avatar(), const Spacer(), _availabilityBadge()],
                  ),
                  verticalSpace(15),

                  // ── Name ─────────────────────────────────────────────────
                  CustomText(
                    text: provider.businessName,
                    fontSize: 13,
                    variant: TextVariant.medium,
                    color: kcTextBlackcolor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // ── Service ───────────────────────────────────────────────
                  CustomText(
                    text: provider.serviceName,
                    fontSize: 11,
                    color: kcTextGreyColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(15),

                  // ── Rating ────────────────────────────────────────────────
                  _ratingRow(),
                  verticalSpace(6),

                  // ── Distance + Price ──────────────────────────────────────
                  Row(
                    children: [
                      if (provider.distanceKm != null) ...[
                        Icon(
                          Iconsax.location,
                          size: 11.r,
                          color: kcTextGreyColor,
                        ),
                        horizontalSpace(3),
                        CustomText(
                          text: '${provider.distanceKm!.toStringAsFixed(1)} km',
                          fontSize: 10,
                          color: kcTextGreyColor,
                        ),
                        horizontalSpace(6),
                      ],
                      if (provider.pricePerHour != null) ...[
                        Icon(Iconsax.money, size: 11.r, color: kcTextGreyColor),
                        horizontalSpace(3),
                        CustomText(
                          text:
                              'Rs ${provider.pricePerHour!.toStringAsFixed(0)}/hr',
                          fontSize: 10,
                          color: kcTextGreyColor,
                        ),
                      ],
                    ],
                  ),

                  const Spacer(),

                  // ── Book CTA ──────────────────────────────────────────────
                  _bookButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatar() {
    return CustomCacheImage(
      imageUrl: provider.avatar ?? '',
      name: provider.businessName,
      height: 40.r,
      width: 40.r,
      borderRadius: BorderRadius.circular(50.r),
    );
  }

  Widget _availabilityBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: provider.isAvailable
            ? const Color(0xFF22C55E).withValues(alpha: 0.12)
            : kcTextGreyColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: provider.isAvailable
              ? const Color(0xFF22C55E).withValues(alpha: 0.4)
              : kcTextGreyColor.withValues(alpha: 0.2),
        ),
      ),
      child: CustomText(
        text: provider.isAvailable ? 'Available' : 'Busy',
        fontSize: 9,
        variant: TextVariant.medium,
        color: provider.isAvailable ? const Color(0xFF16A34A) : kcTextGreyColor,
      ),
    );
  }

  Widget _ratingRow() {
    return Row(
      children: [
        ...List.generate(5, (i) {
          final filled = i < provider.rating.floor();
          final half = !filled && i < provider.rating;
          return Icon(
            half ? Icons.star_half : (filled ? Icons.star : Icons.star_border),
            size: 11.r,
            color: Colors.amber,
          );
        }),
        horizontalSpace(4),
        CustomText(
          text:
              '${provider.rating.toStringAsFixed(1)} (${provider.reviewCount})',
          fontSize: 10,
          color: kcTextGreyColor,
        ),
      ],
    );
  }

  Widget _bookButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 7.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kcSecondaryColor, kcSecondaryColor.withValues(alpha: 0.8)],
        ),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: kcSecondaryColor.withValues(alpha: 0.35),
            blurRadius: 8.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Iconsax.calendar_add, size: 12.r, color: Colors.white),
            horizontalSpace(5),
            CustomText(
              text: 'Book Now',
              fontSize: 11,
              variant: TextVariant.medium,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

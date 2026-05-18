import 'dart:ui';
import 'package:karigar/export.dart';

/// Renders a [SERVICE_LIST] widget — a horizontally scrollable list of
/// available services returned by the structured response.
///
/// Each item displays a curated icon (mapping plumbing, electric, AC, painting, carpentry, etc.)
/// and service name. Tapping a service card calls [AgentController.onServiceTap].
class ServiceListWidget extends StatelessWidget {
  const ServiceListWidget({super.key, required this.services});

  final List<String> services;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AgentController>();

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
                    Iconsax.category,
                    size: 14.r,
                    color: kcSecondaryColor,
                  ),
                ),
                horizontalSpace(8),
                CustomText(
                  text: 'Available Services',
                  fontSize: 13,
                  variant: TextVariant.medium,
                  color: kcTextBlackcolor,
                ),
              ],
            ),
          ),
          verticalSpace(10),

          // ── Horizontal services list ──────────────────────────────────────
          SizedBox(
            height: 48.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              physics: const BouncingScrollPhysics(),
              itemCount: services.length,
              separatorBuilder: (context, index) => horizontalSpace(12),
              itemBuilder: (context, i) {
                final service = services[i];
                final lower = service.toLowerCase();

                IconData getIcon() {
                  if (lower.contains('electric') || lower.contains('bijli')) {
                    return Iconsax.flash;
                  } else if (lower.contains('paint') || lower.contains('rang')) {
                    return Iconsax.brush;
                  } else if (lower.contains('plumb') || lower.contains('pipe')) {
                    return Iconsax.drop;
                  } else if (lower.contains('ac') || lower.contains('cooling') || lower.contains('air')) {
                    return Iconsax.wind;
                  } else if (lower.contains('carpenter') || lower.contains('wood') || lower.contains('lakri')) {
                    return Iconsax.hierarchy;
                  }
                  return Iconsax.airdrop;
                }

                return FadeInRight(
                  delay: Duration(milliseconds: i * 80),
                  duration: const Duration(milliseconds: 300),
                  child: GestureDetector(
                    onTap: () => controller.onServiceTap(service),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                            color: kcWhitecolor.withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: kcWhitecolor.withValues(alpha: 0.9),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: kcBlackColor.withValues(alpha: 0.05),
                                blurRadius: 10.r,
                                offset: Offset(0, 3.h),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  getIcon(),
                                  size: 16.r,
                                  color: kcSecondaryColor,
                                ),
                                horizontalSpace(8),
                                CustomText(
                                  text: service,
                                  fontSize: 11,
                                  variant: TextVariant.medium,
                                  color: kcTextBlackcolor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

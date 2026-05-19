import 'package:karigar/export.dart';

class ServiceRequestCard extends StatefulWidget {
  final ServiceRequestModel request;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const ServiceRequestCard({
    super.key,
    required this.request,
    required this.onAccept,
    required this.onReject,
  });

  @override
  State<ServiceRequestCard> createState() => _ServiceRequestCardState();
}

class _ServiceRequestCardState extends State<ServiceRequestCard> {
  bool _isAcceptLoading = false;
  bool _isRejectLoading = false;

  bool get _isLoading => _isAcceptLoading || _isRejectLoading;

  Future<void> _updateStatus(String status, bool isAccept) async {
    if (_isLoading) return;

    setState(() {
      if (isAccept) {
        _isAcceptLoading = true;
      } else {
        _isRejectLoading = true;
      }
    });

    EasyLoading.show(
      status: isAccept
          ? AppStrings.acceptingRequest
          : AppStrings.rejectingRequest,
    );

    try {
      final success = await ProvidersRepository.updateBookingStatus(
        widget.request.id,
        status,
      );

      if (success) {
        EasyLoading.showSuccess(
          isAccept ? AppStrings.requestAccepted : AppStrings.requestRejected,
        );

        // Execute local triggers
        if (isAccept) {
          widget.onAccept();
        } else {
          widget.onReject();
        }

        // Dynamically refresh the Home controller requests to keep the UI in sync
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().fetchServiceRequests();
        }
      } else {
        EasyLoading.showError(AppStrings.somethingWentWrong);
      }
    } catch (e) {
      EasyLoading.showError(
        '${AppStrings.somethingWentWrong}: ${e.toString()}',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isAcceptLoading = false;
          _isRejectLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kcWhitecolor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kcborderColor.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: formatToLocalDate(widget.request.createdAt),
                            variant: TextVariant.bold,
                            fontSize: getResponsiveFontSize(
                              context,
                              fontSize: 14,
                              max: 16,
                            ),
                            color: kcBlackColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        horizontalSpaceSmall,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: kcSecondaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.magic_star,
                                color: kcSecondaryColor,
                                size: getResponsiveFontSize(
                                  context,
                                  fontSize: 12,
                                  max: 14,
                                ),
                              ),
                              horizontalSpaceTiny,
                              CustomText(
                                text: AppStrings.aiPerfectMatch,
                                variant: TextVariant.medium,
                                fontSize: getResponsiveFontSize(
                                  context,
                                  fontSize: 10,
                                  max: 12,
                                ),
                                color: kcSecondaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceTiny,
                    CustomText(
                      text: widget.request.providerService.service.name,
                      color: kcTextGreyColor,
                      fontSize: getResponsiveFontSize(
                        context,
                        fontSize: 11,
                        max: 13,
                      ),
                    ),
                    verticalSpaceSmall,
                    Row(
                      children: [
                        const Icon(
                          Iconsax.location,
                          size: 12,
                          color: kcTextLightGrey,
                        ),
                        horizontalSpaceTiny,
                        Expanded(
                          child: CustomText(
                            text: widget.request.location,
                            color: kcTextLightGrey,
                            fontSize: getResponsiveFontSize(
                              context,
                              fontSize: 10,
                              max: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              horizontalSpaceSmall,
            ],
          ),
          verticalSpaceSmall,
          Divider(color: kcborderColor),
          verticalSpaceSmall,
          Row(
            children: [
              const Icon(Iconsax.clock, size: 14, color: kcTextLightGrey),
              horizontalSpaceTiny,
              Expanded(
                child: CustomText(
                  text: widget.request.scheduledTime,
                  color: kcTextLightGrey,
                  fontSize: getResponsiveFontSize(
                    context,
                    fontSize: 10,
                    max: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          verticalSpaceMedium,
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _isLoading
                      ? null
                      : () => _updateStatus('confirmed', true),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: kcPrimaryColor.withValues(
                        alpha: _isLoading ? 0.6 : 1.0,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: _isAcceptLoading
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  kcWhitecolor,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: AppStrings.accept,
                                  variant: TextVariant.medium,
                                  color: kcWhitecolor,
                                  fontSize: 12,
                                ),
                                horizontalSpaceTiny,
                                const Icon(
                                  Icons.check,
                                  color: kcWhitecolor,
                                  size: 14,
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: GestureDetector(
                  onTap: _isLoading
                      ? null
                      : () => _updateStatus('cancelled', false),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: kcWhitecolor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: kcborderColor.withValues(
                          alpha: _isLoading ? 0.4 : 1.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: _isRejectLoading
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  kcDarkTextColor,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: AppStrings.reject,
                                  variant: TextVariant.medium,
                                  color: kcDarkTextColor,
                                  fontSize: 12,
                                ),
                                horizontalSpaceTiny,
                                const Icon(
                                  Icons.close,
                                  color: kcDarkTextColor,
                                  size: 14,
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

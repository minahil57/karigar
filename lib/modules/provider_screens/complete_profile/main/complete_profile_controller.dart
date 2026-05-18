import 'package:karigar/export.dart';
import 'complete_profile_mixins.dart';

class CompleteProfileController extends GetxController
    with
        CompleteProfileLocationMixin,
        CompleteProfileAvailabilityMixin,
        CompleteProfileSkillsLanguagesMixin {
  final formKey = GlobalKey<FormState>();

  // Text Form Controllers
  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final phoneController = TextEditingController();
  final aboutMeController = TextEditingController();
  final experienceController = TextEditingController();

  // Profile Image variables
  XFile? pickedImage;
  final ImagePicker _picker = ImagePicker();

  // Price Range
  final List<String> priceRangeOptions = ['low', 'medium', 'high'];
  String selectedPriceRange = 'medium';

  // Form Submission loading state
  bool isSubmitting = false;

  bool get isFormFilled {
    return pickedImage != null &&
        nameController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        professionController.text.trim().isNotEmpty &&
        aboutMeController.text.trim().isNotEmpty &&
        experienceController.text.trim().isNotEmpty &&
        selectedAreas.isNotEmpty &&
        selectedLanguages.isNotEmpty &&
        selectedSkills.isNotEmpty;
  }

  @override
  void onInit() {
    super.onInit();
    detectUserLocation();

    // Add text listeners for real-time Save Button enabling/disabling
    nameController.addListener(update);
    professionController.addListener(update);
    phoneController.addListener(update);
    aboutMeController.addListener(update);
    experienceController.addListener(update);
  }

  void setPriceRange(String value) {
    selectedPriceRange = value;
    update();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (image != null) {
        pickedImage = image;
        update();
      }
    } catch (e) {
      Snackbars.error('Failed to pick image: $e');
    }
  }

  @override
  void onClose() {
    nameController.removeListener(update);
    professionController.removeListener(update);
    phoneController.removeListener(update);
    aboutMeController.removeListener(update);
    experienceController.removeListener(update);

    nameController.dispose();
    professionController.dispose();
    phoneController.dispose();
    aboutMeController.dispose();
    skillInputController.dispose();
    experienceController.dispose();
    super.onClose();
  }

  Future<void> submitData() async {
    if (formKey.currentState?.validate() ?? false) {
      if (pickedImage == null) {
        Snackbars.warning('Please select a profile image');
        return;
      }
      if (selectedAreas.isEmpty) {
        Snackbars.warning('Please select at least one service area');
        return;
      }
      if (selectedLanguages.isEmpty) {
        Snackbars.warning('Please select at least one language');
        return;
      }
      if (selectedSkills.isEmpty) {
        Snackbars.warning('Please add at least one skill');
        return;
      }

      isSubmitting = true;
      update();

      try {
        EasyLoading.show();
        final String openTime = formatTimeOfDay(selectedStartTime);
        final String closeTime = formatTimeOfDay(selectedEndTime);

        // Map simplified Availability choices to strict weekly hours JSON format
        final Map<String, dynamic> availabilityJson = {};
        if (selectedAvailability == 'Full-Time') {
          for (var day in [
            'monday',
            'tuesday',
            'wednesday',
            'thursday',
            'friday',
          ]) {
            availabilityJson[day] = {"open": openTime, "close": closeTime};
          }
        } else if (selectedAvailability == 'Part-Time') {
          for (var day in [
            'monday',
            'tuesday',
            'wednesday',
            'thursday',
            'friday',
          ]) {
            availabilityJson[day] = {"open": openTime, "close": closeTime};
          }
        } else if (selectedAvailability == 'Weekends Only') {
          for (var day in ['saturday', 'sunday']) {
            availabilityJson[day] = {"open": openTime, "close": closeTime};
          }
        }

        // Upload picture if applicable
        String avatarUrl = "https://example.com/avatar.jpg";
        try {
          final uploadResponse = await DioHelper.uploadSingleFile(
            file: pickedImage!,
            endPoint: EndPoints.provider.uploadAvatar,
          );
          if (uploadResponse.statusCode == 200 ||
              uploadResponse.statusCode == 201) {
            avatarUrl = uploadResponse.data['url'] ?? avatarUrl;
          }
        } catch (e) {
          debugPrint('Image upload failed, falling back to dummy url: $e');
        }

        // Build request payload exactly matching backend specifications
        final Map<String, dynamic> requestData = {
          "businessName": nameController.text.trim(),
          "phone": phoneController.text.trim(),
          "email": getUser()?.email ?? "",
          "avatar": avatarUrl,
          "lat": lat ?? 33.6403, // fallback to Islamabad coordinates
          "lng": lng ?? 72.9842,
          "availability": availabilityJson,
          "priceRange": selectedPriceRange,
          "specialty": professionController.text.trim(),
          "about": aboutMeController.text.trim(),
          "experienceYears":
              int.tryParse(experienceController.text.trim()) ?? 0,
          "languages": selectedLanguages,
          "skills": selectedSkills,
          "isAvailable": true,
        };

        debugPrint('Submitting Profile PATCH Payload: $requestData');

        final result = await ProvidersRepository.updateProfile(requestData);

        if (result['error'] == null) {
          Snackbars.success('Profile completed successfully!');
          Get.back();
        } else {
          Snackbars.error(result['error'].toString());
        }
      } catch (e) {
        Snackbars.error('Failed to save profile: $e');
      } finally {
        isSubmitting = false;
        EasyLoading.dismiss();
        update();
      }
    }
  }
}

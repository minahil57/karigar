import 'package:karigar/export.dart';

// Handles all user Location, Geocoding, and Area selection logic
mixin CompleteProfileLocationMixin on GetxController {
  bool isLocationLoading = false;
  String? detectedCity;
  bool isCitySupported = true;
  String? selectedCityOverride;
  double? lat;
  double? lng;

  final Map<String, List<String>> cityAreas = {
    'Islamabad': ['F-6', 'F-7', 'F-8', 'F-10', 'F-11', 'G-6', 'G-7', 'G-8', 'G-9', 'G-10', 'G-11', 'I-8', 'I-9', 'I-10', 'E-11', 'DHA Phase 1', 'DHA Phase 2', 'Bahria Town'],
    'Rawalpindi': ['Saddar', 'Chaklala Scheme 3', 'Bahria Town', 'DHA Phase 1', 'DHA Phase 2', 'Adyala Road', 'Westridge', 'Satellite Town'],
    'Karachi': ['Clifton', 'DHA Phase 1-8', 'Gulshan-e-Iqbal', 'North Nazimabad', 'Federal B Area', 'Bahria Town Karachi', 'PECHS', 'Saddar', 'Korangi', 'Gulistan-e-Jauhar', 'Malir Cantt'],
    'Lahore': ['Gulberg', 'Johar Town', 'DHA Phase 1-6', 'Model Town', 'Samanabad', 'Faisal Town', 'Wapda Town', 'Cavalry Ground', 'Bahria Town Lahore', 'Allama Iqbal Town']
  };

  final List<String> supportedCities = ['Islamabad', 'Rawalpindi', 'Karachi', 'Lahore'];

  String? get activeCity => selectedCityOverride ?? detectedCity;

  final List<String> _selectedAreas = [];
  List<String> get selectedAreas => _selectedAreas;

  List<String> get availableAreas {
    final city = activeCity;
    if (city == null) return [];
    
    for (var key in cityAreas.keys) {
      if (city.toLowerCase().contains(key.toLowerCase())) {
        return cityAreas[key] ?? [];
      }
    }
    return [];
  }

  Future<void> detectUserLocation() async {
    isLocationLoading = true;
    update();
    try {
      Position? position = await LocationService.getCurrentLocation();
      if (position != null) {
        lat = position.latitude;
        lng = position.longitude;
        debugPrint('Detected GPS coords: $lat, $lng');

        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          final String? locality = placemarks.first.locality;
          debugPrint('User locality detected: $locality');
          if (locality != null && locality.isNotEmpty) {
            detectedCity = locality;
            
            bool foundSupported = false;
            for (var city in supportedCities) {
              if (locality.toLowerCase().contains(city.toLowerCase())) {
                detectedCity = city;
                foundSupported = true;
                break;
              }
            }
            isCitySupported = foundSupported;
          } else {
            isCitySupported = false;
          }
        } else {
          isCitySupported = false;
        }
      } else {
        isCitySupported = false;
      }
    } catch (e) {
      debugPrint('Error detecting user location: $e');
      isCitySupported = false;
    }
    isLocationLoading = false;
    update();
  }

  void toggleArea(String area, bool isSelected) {
    if (isSelected) {
      if (!_selectedAreas.contains(area)) {
        _selectedAreas.add(area);
      }
    } else {
      _selectedAreas.remove(area);
    }
    update();
  }

  void setCityOverride(String? city) {
    selectedCityOverride = city;
    _selectedAreas.clear();
    if (city != null) {
      isCitySupported = true;
    }
    update();
  }
}

// Handles Work hours, Availability Options, and Themed time pickers
mixin CompleteProfileAvailabilityMixin on GetxController {
  final List<String> availabilityOptions = ['Full-Time', 'Part-Time', 'Weekends Only'];
  String selectedAvailability = 'Full-Time';

  TimeOfDay selectedStartTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay selectedEndTime = const TimeOfDay(hour: 18, minute: 0);

  void setAvailability(String value) {
    selectedAvailability = value;
    update();
  }

  Future<void> pickStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kcPrimaryColor,
              onPrimary: kcWhitecolor,
              surface: kcWhitecolor,
              onSurface: kcBlackColor,
            ),
            timePickerTheme: const TimePickerThemeData(
              dialHandColor: kcSecondaryColor,
              dialBackgroundColor: kcPrimaryVeryLight,
              entryModeIconColor: kcSecondaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedStartTime = picked;
      update();
    }
  }

  Future<void> pickEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kcPrimaryColor,
              onPrimary: kcWhitecolor,
              surface: kcWhitecolor,
              onSurface: kcBlackColor,
            ),
            timePickerTheme: const TimePickerThemeData(
              dialHandColor: kcSecondaryColor,
              dialBackgroundColor: kcPrimaryVeryLight,
              entryModeIconColor: kcSecondaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedEndTime = picked;
      update();
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String formatTimeForUi(TimeOfDay time, BuildContext context) {
    return time.format(context);
  }
}

// Handles Skills adding/removing and Multi-select Spoken Languages
mixin CompleteProfileSkillsLanguagesMixin on GetxController {
  final List<String> availableLanguages = ['Urdu', 'English', 'Punjabi', 'Sindhi', 'Pashto', 'Balochi'];
  final List<String> _selectedLanguages = [];
  List<String> get selectedLanguages => _selectedLanguages;

  final List<String> _selectedSkills = [];
  List<String> get selectedSkills => _selectedSkills;

  final skillInputController = TextEditingController();

  void toggleLanguage(String language, bool isSelected) {
    if (isSelected) {
      if (!_selectedLanguages.contains(language)) {
        _selectedLanguages.add(language);
      }
    } else {
      _selectedLanguages.remove(language);
    }
    update();
  }

  void addSkill(String skill) {
    final cleanSkill = skill.trim();
    if (cleanSkill.isNotEmpty && !_selectedSkills.contains(cleanSkill)) {
      _selectedSkills.add(cleanSkill);
      skillInputController.clear();
      update();
    }
  }

  void removeSkill(String skill) {
    _selectedSkills.remove(skill);
    update();
  }
}

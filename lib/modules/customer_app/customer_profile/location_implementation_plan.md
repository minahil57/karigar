# Geolocator and Geocoding Integration Plan

This plan details the steps to implement Geolocator location permission checks on application startup (for both Android and iOS), package the location utility in a clean `LocationService`, resolve coordinates to human-readable addresses, and display this current address beautifully on the Customer Profile Screen with tap-to-refresh capability.

## User Review Required

> [!IMPORTANT]
> The implementation involves adding permissions to platform configuration files:
> - **Android**: `AndroidManifest.xml` (ACCESS_FINE_LOCATION and ACCESS_COARSE_LOCATION).
> - **iOS**: `Info.plist` (NSLocationWhenInUseUsageDescription and NSLocationAlwaysAndWhenInUseUsageDescription).
> - We will use the `geocoding` package to do reverse-geocoding (latitude/longitude -> Address). This requires network connection.

## Proposed Changes

### Configuration Files

#### pubspec.yaml
- Add `geocoding: ^3.0.0` under dependencies to convert coordinates into human-readable addresses. Note: `geolocator: ^14.0.2` is already added.

#### AndroidManifest.xml
- Add the following permissions:
  ```xml
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
  ```

#### Info.plist
- Add plist description strings for location keys:
  ```xml
  <key>NSLocationWhenInUseUsageDescription</key>
  <string>This app requires access to your location to show your address on the profile screen and connect you with nearby service providers.</string>
  <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
  <string>This app requires access to your location to show your address on the profile screen and connect you with nearby service providers.</string>
  ```

---

### Core Services

#### location_service.dart
Create a centralized location service managing permission status and fetching address details:
- `requestLocationPermission()`: Robust logic checking if location service is enabled, querying permission state, and asking for permission if undetermined.
- `getCurrentLocation()`: Fetches current Position.
- `getAddressFromLatLng(double latitude, double longitude)`: Resolves coordinates using `geocoding` placemarks to format a readable address string.

#### export.dart (lib/services/export.dart)
- Export `location_service.dart` to make it accessible app-wide.

---

### App Startup Layer

#### splash_controller.dart
- Modify the startup flow in `onInit` to trigger `LocationService.requestLocationPermission()`.
- Await the completion of the permission flow before routing to onboarding or dashboard layouts, ensuring the location dialog shows seamlessly when the app launches.

---

### Customer Profile Layer

#### customer_profile_controller.dart
- Introduce reactive/state variables:
  - `String currentAddress = 'Fetching location...'`
  - `bool isLoadingAddress = false`
- Add method `fetchCurrentAddress()`:
  - Sets `isLoadingAddress = true` and updates listeners.
  - Verifies permission; if granted, fetches GPS coordinates.
  - Performs reverse-geocoding to translate coordinates to address.
  - Falls back gracefully with informative states if permissions or services are disabled.
  - Resets `isLoadingAddress = false`.
- Call `fetchCurrentAddress()` automatically inside `onInit()` so the profile displays location information upon loading.

#### customer_profile_view.dart
- Inject a beautifully designed location display card below the user details:
  - Premium design: White card with smooth shadows, matching rounded corners, and clear branding.
  - Interactive: Incorporate a glassmorphic or accented Teal location icon background container (`kcSecondaryColor` / `kcPrimaryColor.withValues(...)`).
  - Dynamic loading state: Show a sleek mini-loader (`CircularProgressIndicator`) when updating.
  - Actionable: Allow clicking the location card or a custom refresh button to manually reload GPS coordinates (with soft-feedback UI).

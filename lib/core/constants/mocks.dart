import 'package:karigar/export.dart';

final dummyProvider =  ProviderData(
      id: 'edb9b2e5-38e1-4647-8539-8954cb0c2e06',
      userId: 'QdodLzvUBkSfL2b4T0zVeUmLQDoKP959',
      businessName: 'Ali AC Services',
      phone: null,
      email: null,
      avatar:
                  'https://storage.googleapis.com/karigar-6f923.firebasestorage.app/providers/QdodLzvUBkSfL2b4T0zVeUmLQDoKP959/avatar_1778872267494',

      lat: 33.6353,
      lng: 72.961,
      location: Location(
        lng: 72.961,
        lat: 33.6353,
      ),
      address: Address(
        city: 'Karachi South',
        state: 'Sindh',
        street: 'Chand Bibi Road',
        country: 'Pakistan',
      ),
      availability: Availability(
        monday: DayAvailability(
          open: '09:00',
          close: '18:00',
        ),
        tuesday: DayAvailability(
          open: '09:00',
          close: '18:00',
        ),
        wednesday: DayAvailability(
          open: '09:00',
          close: '18:00',
        ),
        thursday: DayAvailability(
          open: '09:00',
          close: '18:00',
        ),
        friday: DayAvailability(
          open: '09:00',
          close: '18:00',
        ),
        saturday: DayAvailability(
          open: '09:00',
          close: '18:00',
        ),
        sunday: DayAvailability(
          open: '09:00',
          close: '18:00',
        ),
      ),
      priceRange: null,
      responseTime: 10,
      rating: 4.8,
      reviewCount: 0,
      isOnboarded: true,
      specialty: null,
      isVerified: false,
      isAvailable: true,
      about: null,
      experienceYears: null,
      languages: null,
      createdAt: DateTime.parse('2026-05-15T18:28:34.772Z'),
      updatedAt: DateTime.parse('2026-05-15T21:15:51.032Z'),
    );

    final dummyProvidersList = List.generate(5, (index) => dummyProvider);
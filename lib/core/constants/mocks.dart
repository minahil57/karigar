import 'package:karigar/export.dart';

final dummyProvider = ProviderData(
  id: 'edb9b2e5-38e1-4647-8539-8954cb0c2e06',
  userId: 'QdodLzvUBkSfL2b4T0zVeUmLQDoKP959',
  businessName: 'Ali AC Services',
  phone: null,
  email: null,
  avatar:
      'https://storage.googleapis.com/karigar-6f923.firebasestorage.app/providers/QdodLzvUBkSfL2b4T0zVeUmLQDoKP959/avatar_1778872267494',

  lat: 33.6353,
  lng: 72.961,
  location: Location(lng: 72.961, lat: 33.6353),
  address: Address(
    city: 'Karachi South',
    state: 'Sindh',
    street: 'Chand Bibi Road',
    country: 'Pakistan',
  ),
  availability: Availability(
    days: {
      'monday': DayAvailability(open: '09:00', close: '18:00'),
      'tuesday': DayAvailability(open: '09:00', close: '18:00'),
      'wednesday': DayAvailability(open: '09:00', close: '18:00'),
      'thursday': DayAvailability(open: '09:00', close: '18:00'),
      'friday': DayAvailability(open: '09:00', close: '18:00'),
    },
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

final List<ServiceRequestModel> dummyServiceRequests = [
  ServiceRequestModel(
    id: '1',
    scheduledTime: 'Monday at 10:00 AM',
    status: 'confirmed',
    location: 'G-13, Islamabad',
    createdAt: '2026-05-17T18:11:07.598Z',
    providerService: ProviderService(
      id: 'ps1',
      service: Services(id: 's1', name: 'AC Repair'),
       provider: ProviderModel(
        id: 'p3',
        businessName: 'Spark Electric Solutions',
        avatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d',
      ),
    ),
  ),

  ServiceRequestModel(
    id: '2',
    scheduledTime: 'Tuesday at 2:30 PM',
    status: 'pending',
    location: 'DHA Phase 6, Karachi',
    createdAt: '2026-05-16T12:00:00.000Z',
    providerService: ProviderService(
      id: 'ps2',
      service: Services(id: 's2', name: 'Plumbing'),
      provider: ProviderModel(
        id: 'p3',
        businessName: 'Spark Electric Solutions',
        avatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d',
      ),
    ),
  ),

  ServiceRequestModel(
    id: '3',
    scheduledTime: 'Wednesday at 6:00 PM',
    status: 'completed',
    location: 'Johar Town, Lahore',
    createdAt: '2026-05-15T09:45:00.000Z',
    providerService: ProviderService(
      id: 'ps3',
      service: Services(id: 's3', name: 'Electrician'),
      provider: ProviderModel(
        id: 'p3',
        businessName: 'Spark Electric Solutions',
        avatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d',
      ),
    ),
  ),

  ServiceRequestModel(
    id: '4',
    scheduledTime: 'Friday at 11:15 AM',
    status: 'cancelled',
    location: 'Bahria Town, Rawalpindi',
    createdAt: '2026-05-14T15:20:00.000Z',
    providerService: ProviderService(
      id: 'ps4',
      service: Services(id: 's4', name: 'Home'),
      provider: ProviderModel(
        id: 'p3',
        businessName: 'Spark Electric Solutions',
        avatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d',
      ),
    ),
  ),
];

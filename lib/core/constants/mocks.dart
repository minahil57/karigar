// import 'package:dealer_talk/export.dart';

// final dummyPulses = PulsesModel(
//   id: "pulse_001",
//   user: "user_123",
//   isDealerSuggested: true,
//   startDate: "2026-02-15T08:00:00Z",
//   endDate: "2026-02-20T08:00:00Z",
//   content: "How satisfied are you with our service?",
//   status: "active",
//   optionsType: "single_choice",

//   options: [
//     OptionModel(
//       id: "opt_001",
//       optionText: "Very Satisfied",
//       createdAt: "2026-02-10T12:00:00Z",
//       updatedAt: "2026-02-10T12:00:00Z",
//     ),
//     OptionModel(
//       id: "opt_002",
//       optionText: "Satisfied",
//       createdAt: "2026-02-10T12:00:00Z",
//       updatedAt: "2026-02-10T12:00:00Z",
//     ),
//     OptionModel(
//       id: "opt_003",
//       optionText: "Neutral",
//       createdAt: "2026-02-10T12:00:00Z",
//       updatedAt: "2026-02-10T12:00:00Z",
//     ),
//     OptionModel(
//       id: "opt_004",
//       optionText: "Dissatisfied",
//       createdAt: "2026-02-10T12:00:00Z",
//       updatedAt: "2026-02-10T12:00:00Z",
//     ),
//   ],

//   scale: ScaleModel(
//     id: "scale_001",
//     minValue: 1,
//     maxValue: 5,
//     createdAt: "2026-02-10T12:00:00Z",
//     updatedAt: "2026-02-10T12:00:00Z",
//   ),

//   results: ResultsModel(
//     totalVotes: 100,
//     average: 3.8, // ✅ added because model contains average
//     options: [
//       ResultOptionModel(
//         id: "opt_001",
//         optionText: "Very Satisfied",
//         votes: 40,
//         percentage: 40.0,
//       ),
//       ResultOptionModel(
//         id: "opt_002",
//         optionText: "Satisfied",
//         votes: 30,
//         percentage: 30.0,
//       ),
//       ResultOptionModel(
//         id: "opt_003",
//         optionText: "Neutral",
//         votes: 20,
//         percentage: 20.0,
//       ),
//       ResultOptionModel(
//         id: "opt_004",
//         optionText: "Dissatisfied",
//         votes: 10,
//         percentage: 10.0,
//       ),
//     ],
//   ),

//   userSelectedOption: null,

//   createdAt: "2026-02-10T12:00:00Z",
//   updatedAt: "2026-02-12T12:00:00Z",
// );

// final dummyPulsesList = [dummyPulses, dummyPulses, dummyPulses, dummyPulses];
// final List<DiscussionModel> dummyDiscussions = [
//   DiscussionModel(
//     id: "1",
//     dealerName: "Ryan H.",
//     discussionTitle:
//         "Just taken this in as PX, doesn’t fit our profile and so I’m happy to trade it on. 25 plate with 11k on it. Feel free to shoot me a message if interested. Looking for £20,000",
//     discussionTopic: "advice",
//     media: [Media(fileUrl:  "https://media.gettyimages.com/id/1410180070/video/salesman-showing-a-car-to-a-mature-man-at-a-car-dealership.jpg?s=640x640&k=20&c=qnk3eDtbfoWIrPUPiCEMvd3thGEuhVCa7MLlbaVxS-w=",
//       )],
//     createdAt: DateTime.now()
//         .subtract(const Duration(hours: 3))
//         .toIso8601String(),
//     updatedAt: DateTime.now().toIso8601String(),
//     replyCount: 23,
//     isFollowing: false,
//     dealerType: "Independent",
//     country: "UK",
//     ownPost: true,
//   ),
//   DiscussionModel(
//     id: "2",
//     dealerName: "Anonymous Dealer",
//     discussionTitle:
//         "What do you think about the current used car market trends?",
//     discussionTopic: "general",
//     media: [
//       Media(
//         fileUrl:
//             "https://media.gettyimages.com/id/1410180070/video/salesman-showing-a-car-to-a-mature-man-at-a-car-dealership.jpg?s=640x640&k=20&c=qnk3eDtbfoWIrPUPiCEMvd3thGEuhVCa7MLlbaVxS-w=",
//       ),
//     ],
//     createdAt: DateTime.now()
//         .subtract(const Duration(days: 1))
//         .toIso8601String(),
//     updatedAt: DateTime.now().toIso8601String(),
//     replyCount: 8,
//     isFollowing: true,
//     dealerType: "Franchise",
//     country: "USA",
//     ownPost: false,
//   ),
//   DiscussionModel(
//     id: "3",
//     dealerName: "Premium Motors",
//     discussionTitle:
//         "Looking for recommendations on high-margin SUVs this quarter.",
//     discussionTopic: "recommendation",
//      media: [
//       Media(
//         fileUrl:
//             "https://media.gettyimages.com/id/1410180070/video/salesman-showing-a-car-to-a-mature-man-at-a-car-dealership.jpg?s=640x640&k=20&c=qnk3eDtbfoWIrPUPiCEMvd3thGEuhVCa7MLlbaVxS-w=",
//       ),
//     ],
//     createdAt: DateTime.now()
//         .subtract(const Duration(minutes: 45))
//         .toIso8601String(),
//     updatedAt: DateTime.now().toIso8601String(),
//     replyCount: 3,
//     isFollowing: false,
//     dealerType: "Independent",
//     country: "Canada",
//     ownPost: false,
//   ),
// ];

// final List<CouncilModel> mockCouncils = [
//   CouncilModel(
//     id: "1",
//     supportCount: 0,
//     councilImages: [
//       CouncilImageModel(
//         id: "img1",
//         isThumbnail: true,
//         mediaFile: MediaFileModel(
//           id: "media1",
//           fileUrl:
//               "https://media.gettyimages.com/id/1410180070/video/salesman-showing-a-car-to-a-mature-man-at-a-car-dealership.jpg?s=640x640&k=20&c=qnk3eDtbfoWIrPUPiCEMvd3thGEuhVCa7MLlbaVxS-w=",
//         ),
//       ),
//       CouncilImageModel(
//         id: "img2",
//         isThumbnail: false,
//         mediaFile: MediaFileModel(
//           id: "media2",
//           fileUrl:
//               "https://media.gettyimages.com/id/1410180070/video/salesman-showing-a-car-to-a-mature-man-at-a-car-dealership.jpg?s=640x640&k=20&c=qnk3eDtbfoWIrPUPiCEMvd3thGEuhVCa7MLlbaVxS-w=",
//         ),
//       ),
//     ],
//     isSupporting: false,
//     createdAt: DateTime.parse("2026-03-01T10:30:00.000Z"),
//     updatedAt: DateTime.parse("2026-03-01T10:30:00.000Z"),
//     isDealerSuggested: true,
//     ideaTitle: "Improve Delivery Speed",
//     shortDescription: "Reduce delivery time from 5 days to 2 days.",
//     status: "newidea",
//     isPublished: true,
//     publishedAt: DateTime.parse("2026-03-01T10:30:00.000Z"),
//     inProgressAt: DateTime.parse("2026-03-02T12:00:00.000Z"),
//     completedAt: DateTime.parse("2026-03-05T15:00:00.000Z"),

//     /// ✅ NEW FIELDS
//     whyItMatters:
//         "Faster delivery improves customer satisfaction and increases repeat business.",
//     keyPoints: [
//       KeyPointModel(
//         title: "Customer Satisfaction",
//         desc: "Shorter delivery times improve buyer trust.",
//       ),
//       KeyPointModel(
//         title: "Operational Efficiency",
//         desc: "Optimized logistics reduce overhead cost.",
//       ),
//     ],
//   ),

//   CouncilModel(
//     id: "2",
//     supportCount: 12,
//     councilImages: [
//       CouncilImageModel(
//         id: "img3",
//         isThumbnail: true,
//         mediaFile: MediaFileModel(
//           id: "media3",
//           fileUrl:
//               "https://media.gettyimages.com/id/1410180070/video/salesman-showing-a-car-to-a-mature-man-at-a-car-dealership.jpg?s=640x640&k=20&c=qnk3eDtbfoWIrPUPiCEMvd3thGEuhVCa7MLlbaVxS-w=",
//         ),
//       ),
//     ],
//     isSupporting: false,
//     createdAt: DateTime.parse("2026-02-25T09:00:00.000Z"),
//     updatedAt: DateTime.parse("2026-02-25T09:00:00.000Z"),
//     isDealerSuggested: false,
//     ideaTitle: "Add New Payment Method",
//     shortDescription: "Integrate EasyPaisa & JazzCash options.",
//     status: "inprogress",
//     isPublished: true,
//     publishedAt: DateTime.parse("2026-02-25T09:00:00.000Z"),
//     inProgressAt: DateTime.parse("2026-02-26T10:00:00.000Z"),
//     completedAt: DateTime.parse("2026-03-10T18:00:00.000Z"),

//     /// ✅ NEW FIELDS
//     whyItMatters:
//         "Faster delivery improves customer satisfaction and increases repeat business.",
//     keyPoints: [
//       KeyPointModel(
//         title: "Customer Satisfaction",
//         desc: "Shorter delivery times improve buyer trust.",
//       ),
//       KeyPointModel(
//         title: "Operational Efficiency",
//         desc: "Optimized logistics reduce overhead cost.",
//       ),
//     ],
//   ),

//   CouncilModel(
//     id: "3", // ⚠️ Fixed duplicate ID
//     supportCount: 8,
//     councilImages: [
//       CouncilImageModel(
//         id: "img3",
//         isThumbnail: true,
//         mediaFile: MediaFileModel(
//           id: "media3",
//           fileUrl:
//               "https://media.gettyimages.com/id/1410180070/video/salesman-showing-a-car-to-a-mature-man-at-a-car-dealership.jpg?s=640x640&k=20&c=qnk3eDtbfoWIrPUPiCEMvd3thGEuhVCa7MLlbaVxS-w=",
//         ),
//       ),
//     ],
//     isSupporting: true,
//     createdAt: DateTime.parse("2026-02-20T09:00:00.000Z"),
//     updatedAt: DateTime.parse("2026-02-20T09:00:00.000Z"),
//     isDealerSuggested: false,
//     ideaTitle: "Add Live Chat Support",
//     shortDescription: "Enable real-time dealer communication.",
//     status: "completed",
//     isPublished: true,
//     publishedAt: DateTime.parse("2026-02-20T09:00:00.000Z"),
//     inProgressAt: DateTime.parse("2026-02-21T10:00:00.000Z"),
//     completedAt: DateTime.parse("2026-02-28T18:00:00.000Z"),

//     /// ✅ NEW FIELDS
//     whyItMatters:
//         "Faster delivery improves customer satisfaction and increases repeat business.",
//     keyPoints: [
//       KeyPointModel(
//         title: "Customer Satisfaction",
//         desc: "Shorter delivery times improve buyer trust.",
//       ),
//       KeyPointModel(
//         title: "Operational Efficiency",
//         desc: "Optimized logistics reduce overhead cost.",
//       ),
//     ],
//   ),
// ];

// final councilDataMock = CouncilModel(
//   id: "3", // ⚠️ Fixed duplicate ID
//   supportCount: 8,
//   councilImages: [
//     CouncilImageModel(
//       id: "img3",
//       isThumbnail: true,
//       mediaFile: MediaFileModel(
//         id: "media3",
//         fileUrl:
//             "https://media.gettyimages.com/id/1410180070/video/salesman-showing-a-car-to-a-mature-man-at-a-car-dealership.jpg?s=640x640&k=20&c=qnk3eDtbfoWIrPUPiCEMvd3thGEuhVCa7MLlbaVxS-w=",
//       ),
//     ),
//   ],
//   isSupporting: true,
//   createdAt: DateTime.parse("2026-02-20T09:00:00.000Z"),
//   updatedAt: DateTime.parse("2026-02-20T09:00:00.000Z"),
//   isDealerSuggested: false,
//   ideaTitle: "Add Live Chat Support",
//   shortDescription: "Enable real-time dealer communication.",
//   status: "completed",
//   isPublished: true,
//   publishedAt: DateTime.parse("2026-02-20T09:00:00.000Z"),
//   inProgressAt: DateTime.parse("2026-02-21T10:00:00.000Z"),
//   completedAt: DateTime.parse("2026-02-28T18:00:00.000Z"),

//   /// ✅ NEW FIELDS
//   whyItMatters:
//       "Faster delivery improves customer satisfaction and increases repeat business.",
//   keyPoints: [
//     KeyPointModel(
//       title: "Customer Satisfaction",
//       desc: "Shorter delivery times improve buyer trust.",
//     ),
//     KeyPointModel(
//       title: "Operational Efficiency",
//       desc: "Optimized logistics reduce overhead cost.",
//     ),
//   ],
// );

// UserModel dummyUser = UserModel(
//   id: "12345",
//   email: "alex.smith@motormax.com",
//   businessName: "Percy's Motors",
//   websiteUrl: "https://percysmotors.com",
//   country: "USA",
//   dealerType: "Used Car Dealer",
//   preferredName: "Alex Smith",
//   role: "Dealer Principal",
//   status: "active",
//   suspendedAt: null,
//   suspendedReason: null,
//   createdAt: "2025-03-01T10:00:00Z",
//   updatedAt: "2025-03-04T12:30:00Z",
//   lastLogin: "2025-03-05T09:30:00Z",
//   pushNotifications: true,
//   verification: [
//     Verification(
//       id: "ver_001",
//       verificationChoice: "email",
//       dealershipEmail: "dealer@percysmotors.com",
//       questionnaireAnswers: "Verification completed",
//       fileUrl: "https://files.server.com/doc1.pdf",
//       createdAt: "2025-03-01",
//       updatedAt: "2025-03-01",
//     ),
//   ],
// );

// final ProfileActivityModel dummyProfileActivity = ProfileActivityModel(
//   discussionsStarted: 3,
//   ideasSubmitted: 5,
//   pulsesVoted: 7,
//   ideasSupported: 2,
// );

// final NotificationPreferencesModel dummyNotificationPreferences =
//     NotificationPreferencesModel(
//       id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
//       createdAt: DateTime.now(),
//       updatedAt: DateTime.now(),
//       verificationUpdates: false,
//       repliesToDiscussions: false,
//       mentions: false,
//       newPolls: false,
//       pollResults: false,
//       updatesOnIdeasVotedFor: false,
//       updatesOnIdeasSubmitted: false,
//       productUpdates: false,
//       maintenanceNotice: false,
//       user: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
//     );

// final List<LastCouncil> dummyLastCouncils = [
//   LastCouncil(
//     id: '1',
//     ideaTitle: 'Improve App Performance',
//     createdAt: DateTime.now().subtract(const Duration(days: 1)),
//     supportCount: 120,
//     userAction: 'supported',
//   ),
//   LastCouncil(
//     id: '2',
//     ideaTitle: 'Add Dark Mode Feature',
//     createdAt: DateTime.now().subtract(const Duration(days: 3)),
//     supportCount: 250,
//     userAction: 'voted',
//   ),
//   LastCouncil(
//     id: '3',
//     ideaTitle: 'Introduce Referral System',
//     createdAt: DateTime.now().subtract(const Duration(days: 5)),
//     supportCount: 75,
//     userAction: 'none',
//   ),
//   LastCouncil(
//     id: '4',
//     ideaTitle: 'Enable Multi-language Support',
//     createdAt: DateTime.now().subtract(const Duration(days: 7)),
//     supportCount: 180,
//     userAction: 'supported',
//   ),
// ];

// final List<LastPulse> dummyLastPulses = [
//   LastPulse(
//     id: '1',
//     content: 'Do you like the new UI update?',
//     status: 'active',
//     createdAt: DateTime.now().subtract(const Duration(hours: 5)),
//     optionsType: 'single',
//     userAction: 'voted',
//     userVoteDisplay: 'Yes',
//   ),
//   LastPulse(
//     id: '2',
//     content: 'Should we add more payment methods?',
//     status: 'closed',
//     createdAt: DateTime.now().subtract(const Duration(days: 2)),
//     optionsType: 'multiple',
//     userAction: 'none',
//     userVoteDisplay: '',
//   ),
//   LastPulse(
//     id: '3',
//     content: 'Rate your experience with our app',
//     status: 'active',
//     createdAt: DateTime.now().subtract(const Duration(days: 4)),
//     optionsType: 'rating',
//     userAction: 'voted',
//     userVoteDisplay: '4 Stars',
//   ),
//   LastPulse(
//     id: '4',
//     content: 'Would you recommend this app to others?',
//     status: 'active',
//     createdAt: DateTime.now().subtract(const Duration(days: 6)),
//     optionsType: 'single',
//     userAction: 'voted',
//     userVoteDisplay: 'Definitely',
//   ),
// ];

import 'package:karigar/export.dart';

final Map<String, String> rolesOptions = {
  'Dealer Principle / Owner': 'dealerprincipalowner',
  'Managing Director': 'managingdirector',
  'General Sales Manager (GSM)': 'generalsalesmanager',
  'Sales Manager': 'salesmanager',
  'Finance & Insurance': 'financeandinsurance',
  'Other': 'other',
};

final Map<String, String> dealerTypeOptions = {
  'Used Car Dealer': 'usedcar',
  'New Car Dealer': 'newcar',
  'New & Used Car Dealer': 'newandusedcar',

  'Used Van Dealer': 'usedvan',
  'New Van & Commercial Dealer': 'vansandcommercial',

  'Prestige & Performance': 'prestigeandperformance',
  'Specialist Vehicles (e.g. classic, modified)': 'specialistvehicles',

  'Dealer Group': 'dealergroup',
  'Motorbikes': 'motorbikes',
  'Motorhomes & Caravans': 'motorhomesandcaravans',

  'Other': 'other',
};

final Map<String, String> verificationMethodOptions = {
  'Dealership Email': 'dealership_email',
  'Questionnaire': 'questionnaire',
  'File Upload': 'file_upload',
};

final Map<String, String> pulsesTypeOptions = {
  'Single Select': 'singleselect',
  'Percentage Scale': 'scale',
  'Declined': 'declined',
};

final Map<String, String> userStatusOptions = {
  'Active': 'active',
  'Incomplete': 'incomplete',
  'Review': 'review',
  'Suspended': 'suspended',
  'Doc Requested': 'doc_requested',
  'Verified': 'verified',
};

final Map<String, String> discussionTopicOptions = {
  'All': '', // send nothing in query

  'Advice': 'advice',
  'General': 'general',
  'Concern': 'concern',
  'Recommendation': 'recommendation',
  'Rant': 'rant',
  'Question': 'question',
};

final Map<String, String> sortTypeOptions = {
  'Most Recent': '-created_at',
  'Oldest First': 'created_at',

  'Most Replied': '-reply_count',
  'Least Replied': 'reply_count',
};
Map<String, String> pulsesStatusOptions = {
  'Active': 'active',
  'Scheduled': 'scheduled',
  'Expired': 'expired',
  'New': 'new',
  'Archived': 'archived',
  'Approved': 'approved',
  'Rejected': 'rejected',
};

final Map<String, String> dealerTypeOptionDiscussion = {
  'Used Car': 'usedcar',
  'New Car': 'newcar',
  'New & Used Car': 'newandusedcar',

  'Used Van': 'usedvan',
  'New Van & Commercial': 'vansandcommercial',

  'Prestige & Performance': 'prestigeandperformance',
  'Specialist Vehicles': 'specialistvehicles',

  'Dealer Group': 'dealergroup',
  'Motorbikes': 'motorbikes',
  'Motorhomes & Caravans': 'motorhomesandcaravans',
};

final Map<String, String> councilStatucOptions = {
  'Most Voted': 'mostvoted',
  'New': 'newidea',
  'In Progress': 'workinprogress',
  'Delivered': 'completed',
};

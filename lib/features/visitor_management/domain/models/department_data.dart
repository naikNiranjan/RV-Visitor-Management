class Department {
  final String label;
  final String value;

  const Department({required this.label, required this.value});
}

class Staff {
  final String label;
  final String value;
  final String departmentCode;

  const Staff({
    required this.label,
    required this.value,
    required this.departmentCode,
  });
}

class DocumentType {
  final String label;
  final String value;

  const DocumentType({required this.label, required this.value});
}

// Department data
final departments = [
  Department(label: 'Admin Block', value: 'ADMIN'),
  Department(label: 'Aerospace Engineering', value: 'AE'),
  Department(
      label: 'Artificial Intelligence and Machine Learning', value: 'AIML'),
  Department(label: 'Biotechnology', value: 'BT'),
  Department(label: 'Chemical Engineering', value: 'CH'),
  Department(label: 'Civil Engineering', value: 'CV'),
  Department(label: 'Computer Science and Engineering', value: 'CSE'),
  Department(label: 'Electrical and Electronics Engineering', value: 'EEE'),
  Department(label: 'Electronics and Communication Engineering', value: 'ECE'),
  Department(
      label: 'Electronics and Instrumentation Engineering', value: 'EIE'),
  Department(label: 'Industrial Engineering and Management', value: 'IEM'),
  Department(label: 'Information Science and Engineering', value: 'ISE'),
  Department(label: 'Master of Computer Applications', value: 'MCA'),
  Department(label: 'Mechanical Engineering', value: 'ME'),
  Department(label: 'Telecommunication Engineering', value: 'TE'),
];

// Document types
final documentTypes = [
  DocumentType(label: 'National ID', value: 'NID'),
  DocumentType(label: 'Aadhar Card', value: 'AADHAR'),
  DocumentType(label: 'Driving License', value: 'DL'),
  DocumentType(label: 'Company ID', value: 'CID'),
  DocumentType(label: 'Other', value: 'OTHER'),
];

// Staff data organized by department
final Map<String, List<Staff>> departmentStaff = {
  'AE': [
    Staff(
      label: 'Dr. Ravindra S Kulkarni - Professor & Head',
      value: 'AE001',
      departmentCode: 'AE',
    ),
    Staff(
      label: 'Dr. Promio Charles F - Associate Professor',
      value: 'AE002',
      departmentCode: 'AE',
    ),
    // ... Add all AE staff
  ],
  'AIML': [
    Staff(
      label: 'Dr. B. Sathish Babu - Professor and HoD',
      value: 'AIML001',
      departmentCode: 'AIML',
    ),
    // ... Add all AIML staff
  ],
  // ... Add all departments
};

// Add this getter to get all staff in a single list
final allStaff = [
  // AE Department
  Staff(
    label: 'Dr. Ravindra S Kulkarni - Professor & Head',
    value: 'AE001',
    departmentCode: 'AE',
  ),
  Staff(
    label: 'Dr. Promio Charles F - Associate Professor',
    value: 'AE002',
    departmentCode: 'AE',
  ),
  // AIML Department
  Staff(
    label: 'Dr. B. Sathish Babu - Professor and HoD',
    value: 'AIML001',
    departmentCode: 'AIML',
  ),
  // Add all other staff here...
];

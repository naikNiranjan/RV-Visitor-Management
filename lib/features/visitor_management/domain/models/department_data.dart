class Faculty {
  final String name;
  final String role;
  final String areaOfInterest;
  final String email;

  const Faculty({
    required this.name,
    required this.role,
    required this.areaOfInterest,
    required this.email,
  });
}

class Department {
  final String label;
  final String value;
  final List<Faculty>? faculties;

  const Department({
    required this.label,
    required this.value,
    this.faculties,
  });
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

// Department data with faculty information
final departments = [
  Department(
    label: 'Admin Block',
    value: 'ADMIN',
    faculties: [
      Faculty(
        name: 'Dr. K N Subramanya',
        role: 'Principal',
        areaOfInterest: 'Administration',
        email: 'principal@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. B S Satyanarayana',
        role: 'Director',
        areaOfInterest: 'Administration',
        email: 'director@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. N S Narahari',
        role: 'Dean Academics',
        areaOfInterest: 'Academic Administration',
        email: 'deanacademics@rvce.edu.in',
      ),
      Faculty(
        name: 'Administrative Office',
        role: 'Administrative Section',
        areaOfInterest: 'Administration',
        email: 'admin@rvce.edu.in',
      ),
      Faculty(
        name: 'Accounts Section',
        role: 'Accounts Department',
        areaOfInterest: 'Finance and Accounts',
        email: 'accounts@rvce.edu.in',
      ),
      Faculty(
        name: 'Examination Section',
        role: 'Examination Department',
        areaOfInterest: 'Examination and Evaluation',
        email: 'examination@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Aerospace Engineering',
    value: 'AE',
    faculties: [
      Faculty(
        name: 'Dr. Ravindra S Kulkarni',
        role: 'Professor & Head',
        areaOfInterest:
            'Fluid Dynamics, Heat Transfer, Experimental Aerodynamics, Composite Material Technology',
        email: 'ravindraskulkarni@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Promio Charles F',
        role: 'Associate Professor',
        areaOfInterest: 'Aerostructure Analysis, Aeroelasticity',
        email: 'promiocharlesf@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. R Supreeth',
        role: 'Associate Professor',
        areaOfInterest: 'Aerodynamics, Aerospace Propulsion',
        email: 'supreethr@rvce.edu.in',
      ),
      Faculty(
        name: 'Bhaskar K',
        role: 'Assistant Professor',
        areaOfInterest:
            'Computational Fluid Dynamics, Aerodynamics, Gas Dynamics, Fluid Mechanics, Heat Transfer',
        email: 'bhaskark@rvce.edu.in',
      ),
      Faculty(
        name: 'Pranesh Kumar S R',
        role: 'Assistant Professor',
        areaOfInterest: 'Aircraft Propulsion, Gas Dynamics',
        email: 'praneshkumarsr@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Benjamin Rohit',
        role: 'Assistant Professor',
        areaOfInterest: 'Structural Mechanics',
        email: 'benjaminr@rvce.edu.in',
      ),
      Faculty(
        name: 'Srinivasan S',
        role: 'Assistant Professor',
        areaOfInterest:
            'Computational Fluid Dynamics, Aerodynamics, Gas Dynamics',
        email: 'srinivasans@rvce.edu.in',
      ),
      Faculty(
        name: 'Mukesh M',
        role: 'Assistant Professor',
        areaOfInterest: 'Gas Dynamics',
        email: 'mukeshm@rvce.edu.in',
      ),
      Faculty(
        name: 'Group Captain (Retd) Prof.Deepak Bana',
        role: 'Visiting Professor',
        areaOfInterest: 'Avionics, Aircraft Instrumentation',
        email: 'deepakbana@rvce.edu.in',
      ),
      Faculty(
        name: 'Mr Jitendra Singh',
        role: 'Professor of Practice',
        areaOfInterest: 'Flight Testing & Aircraft Propulsion',
        email: 'jitendrasingh@rvce.du.in',
      ),
      Faculty(
        name: 'Mr. Srinath Ramakrishnan',
        role: 'Assistant Professor',
        areaOfInterest: 'Aircraft Stability, Aerodynamics, Gas Dynamics',
        email: 'srinathr@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Artificial Intelligence & Machine Learning',
    value: 'AIML',
    faculties: [
      Faculty(
        name: 'Dr. B. Sathish Babu',
        role: 'Professor and HoD',
        areaOfInterest:
            'Artificial Intelligence, Computer Networks Security, HPC, Cloud Computing, Quantum Computing',
        email: 'bsbabu@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Vijayalakshmi M.N',
        role: 'Associate Professor',
        areaOfInterest: 'Data Mining and Image Processing, Soft Computing',
        email: 'vijayalakshmi@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. S. Anupama Kumar',
        role: 'Associate Professor',
        areaOfInterest: 'Data Mining',
        email: 'anupamakumar@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Narasimha Swamy S',
        role: 'Assistant Professor',
        areaOfInterest:
            'Artificial Intelligence, Internet of Things, Edge Computing/Intelligence',
        email: 'narasimhaswamys@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Somesh Nandi',
        role: 'Assistant Professor',
        areaOfInterest:
            'Robotics & Automation, Integrated Photonics, Optoelectronics',
        email: 'someshnandi@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. K. Vishwavardhan Reddy',
        role: 'Assistant Professor',
        areaOfInterest:
            'WSN, Body area networks, Networking, Wireless communication, BigData Analytics',
        email: 'viswavardhank@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Rajesh R M',
        role: 'Assistant Professor',
        areaOfInterest: 'Artificial Intelligence & Cyber Security',
        email: 'rajeshrm@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof Sonika CT',
        role: 'Assistant Professor',
        areaOfInterest: 'Artificial Intelligence, Networking',
        email: 'sonikact@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Manasa M',
        role: 'Assistant Professor',
        areaOfInterest: 'Artificial Intelligence, Computer Vision',
        email: 'manasam@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Biotechnology',
    value: 'BT',
    faculties: [
      Faculty(
        name: 'Dr. Vidya Niranjan',
        role: 'Professor & HOD',
        areaOfInterest: 'Computational Biology',
        email: 'vidya.n@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr A H Manjunatha Reddy',
        role: 'Associate Professor',
        areaOfInterest: 'Environmental Biotechnology',
        email: 'ahmanjunatha@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Neeta Shiva Kumar',
        role: 'Associate Professor',
        areaOfInterest: 'Agriculture Biotechnology',
        email: 'neeta@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Nagashree N Rao',
        role: 'Associate Professor',
        areaOfInterest: 'Functional Genomics',
        email: 'nagashreenrao@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. G Vijaya Kumar',
        role: 'Associate Professor',
        areaOfInterest: 'Computational Fluid Dynamics',
        email: 'vijayakg@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Lingayya Hiremath',
        role: 'Assistant Professor',
        areaOfInterest: 'Microbial Biotechnology',
        email: 'lingayah@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. M Rajeswari',
        role: 'Assistant Professor',
        areaOfInterest: 'Process Dynamics and Control',
        email: 'rajeshwarim@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Ajeet Kumar Srivastava',
        role: 'Assistant Professor',
        areaOfInterest: 'Renewable Energy',
        email: 'ajeeth@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shivandappa',
        role: 'Assistant Professor',
        areaOfInterest: 'Biotechnology & Computational Biology',
        email: 'shivandappa@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. S Narendra Kumar',
        role: 'Assistant Professor',
        areaOfInterest: 'Fermentation Technology',
        email: 'narendraks@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Praveen Kumar Gupta',
        role: 'Assistant Professor',
        areaOfInterest: 'Pharmaceutical Biotechnology',
        email: 'praveenkgupta@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Trilokchandran B',
        role: 'Assistant Professor',
        areaOfInterest: 'Bioprocess Technology',
        email: 'trilokc@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. H Raju',
        role: 'Assistant Professor',
        areaOfInterest: 'Animal Biotechnology',
        email: 'raju22aybt@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Sumathra M',
        role: 'Assistant Professor',
        areaOfInterest: 'Protein Biochemistry',
        email: 'sumathram@rvce.edu.in',
      ),
      // M.Tech (Biotechnology) Faculty
      Faculty(
        name: 'Dr. H G Ashok Kumar',
        role: 'Professor',
        areaOfInterest: 'Plant Biotechnology',
        email: 'hgashok@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. A V Narayan',
        role: 'Associate Professor',
        areaOfInterest: 'Downstream Processing',
        email: 'narayanav@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Ashwani Sharma',
        role: 'Assistant Professor',
        areaOfInterest: 'Molecular Biotechnology',
        email: 'ashwanisharma@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Chemical Engineering',
    value: 'CH',
    faculties: [
      Faculty(
        name: 'Dr. Vinod Kallur',
        role: 'Associate Professor and Head',
        areaOfInterest: 'Computational Chemical Engineering',
        email: 'vinodkallur@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. R Suresh',
        role: 'Professor and Associate Dean',
        areaOfInterest:
            'Transfer operations, Clean & Sustainable Technology, Nanomaterials',
        email: 'sureshr@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. D Ranganath',
        role: 'Associate Professor and Dean Placement',
        areaOfInterest: 'Herbal Drug molecules',
        email: 'ranganathd@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Jagadish H Patil',
        role: 'Associate Professor',
        areaOfInterest:
            'Bio-methanation of Organic wastes, Chemical Plant Design',
        email: 'jagadishhpatil@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Basavaraja R J',
        role: 'Associate Professor',
        areaOfInterest: 'Energy, Combustion, Computational Fluid Dynamics',
        email: 'basavarajarj@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. P L Muralidhara',
        role: 'Assistant Professor',
        areaOfInterest:
            'Petroleum Processing & Technology, Chemical Equipment Design',
        email: 'muralidharapl@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Vidya C',
        role: 'Assistant Professor',
        areaOfInterest:
            'Nanobiotechnology, Chemical Thermodynamics, Reaction Engineering',
        email: 'vidyac@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Rajalakshmi Mudbidre',
        role: 'Assistant Professor',
        areaOfInterest:
            'Fate and Transport of Chemicals, Membrane Technology, Environmental Technology',
        email: 'rajalakshmim@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Manjula Sarode',
        role: 'Assistant Professor',
        areaOfInterest: 'Separation Technology, Unit Operations',
        email: 'manjulasarode@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Ujwal Shreenag Meda',
        role: 'Assistant Professor',
        areaOfInterest:
            'Process and Product Design, Bulk Solids Handling, Alternate Fuels and Fuel Cells',
        email: 'ujwalshreenagm@rvce.edu.in',
      ),
      Faculty(
        name: 'Anupama V. Joshi',
        role: 'Assistant Professor',
        areaOfInterest: 'Computational Fluid Dynamics, Chemical Process Design',
        email: 'anupamavj@rvce.edu.in',
      ),
      Faculty(
        name: 'Vinutha Moses',
        role: 'Assistant Professor',
        areaOfInterest: 'Polymer composites, Bioremediation',
        email: 'vinuthamoses@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Civil Engineering',
    value: 'CV',
    faculties: [
      Faculty(
        name: 'Dr. Radhakrishna',
        role: 'Professor & Head',
        areaOfInterest: 'Structural Engineering',
        email: 'radhakrishna@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. M.V. Renukadevi',
        role: 'Professor',
        areaOfInterest: 'Structural Engineering',
        email: 'renukadevimv@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. V. Anantharama',
        role: 'Associate Professor & Deputy CoE',
        areaOfInterest: 'RS and GIS',
        email: 'anantharamav@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Vinod A R',
        role: 'Associate Professor',
        areaOfInterest: 'Environmental Engineering',
        email: 'vinodar@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. T. Raghavendra',
        role: 'Associate Professor',
        areaOfInterest: 'Structural Engineering',
        email: 'raghavendrat@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. M. Lokeshwari',
        role: 'Associate Professor',
        areaOfInterest: 'Environmental Engineering',
        email: 'lokeshwarim@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. S. Nethravathi',
        role: 'Assistant Professor',
        areaOfInterest: 'Geotechnical Engineering',
        email: 'nethravathis@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. L.Durga Prashanth',
        role: 'Assistant Professor',
        areaOfInterest: 'Pavement Engineering',
        email: 'durgaprashanthl@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Anand Kumar B.G',
        role: 'Assistant Professor',
        areaOfInterest: 'Prestressed Concrete',
        email: 'anandkumarbg@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. M. Varuna',
        role: 'Assistant Professor',
        areaOfInterest: 'Pavement Engineering',
        email: 'varunam@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Sindhu. D',
        role: 'Assistant Professor',
        areaOfInterest: 'Water Resource Engineering',
        email: 'sindhud@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Sunil S',
        role: 'Assistant Professor',
        areaOfInterest: 'Transportation Engineering',
        email: 'sunils@rvce.edu.in',
      ),
      // M.Tech Structural Engineering Faculty
      Faculty(
        name: 'Dr. B.C.UdayaShankar',
        role: 'Professor',
        areaOfInterest: 'Structural Engineering',
        email: 'udayashankar@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. R Ravindra',
        role: 'Associate Professor & Associate Dean',
        areaOfInterest:
            'Alternate Building Material Technology, Reliability Engineering',
        email: 'ravindrar@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. K. Madhavi',
        role: 'Assistant Professor',
        areaOfInterest: 'Structural Engineering',
        email: 'madhavik@rvce.edu.in',
      ),
      // M.Tech Highway Engineering Faculty
      Faculty(
        name: 'Dr. M S Nagakumar',
        role: 'Professor',
        areaOfInterest: 'Pavement Evaluation and Soil Dynamics',
        email: 'nagakumar@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Anjaneyappa',
        role: 'Associate Professor',
        areaOfInterest: 'Highway Engineering',
        email: 'anjaneyappa@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. M.R. Archana',
        role: 'Assistant Professor',
        areaOfInterest: 'Pavement Engineering',
        email: 'archanamr@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Computer Science and Engineering',
    value: 'CSE',
    faculties: [
      // Main CSE Faculty
      Faculty(
        name: 'Dr. Ramakanth Kumar P',
        role: 'Professor & Head',
        areaOfInterest: 'Pattern Recognition, NLP',
        email: 'ramakanthkp@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Krishnappa H K',
        role: 'Associate Professor',
        areaOfInterest: 'Graph Theory, Graphics',
        email: 'krishnappahk@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Deepamala N',
        role: 'Associate Professor',
        areaOfInterest: 'NLP, Computer Networks',
        email: 'deepamalan@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Sowmyarani C N',
        role: 'Associate Professor',
        areaOfInterest: 'Computer Security & Privacy',
        email: 'sowmyaranicn@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Hemavathy R',
        role: 'Associate Professor',
        areaOfInterest: 'Image processing',
        email: 'hemavathyr@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. K Badari Nath',
        role: 'Associate Professor',
        areaOfInterest: 'Embedded Systems',
        email: 'badarinath.kb@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Chethana R Murthy',
        role: 'Associate Professor',
        areaOfInterest: 'Wireless Cellular Networks',
        email: 'chethanamurthy@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Pratiba D',
        role: 'Assistant Professor',
        areaOfInterest: 'Web Technologies',
        email: 'pratibad@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Jyoti Shetty',
        role: 'Assistant Professor',
        areaOfInterest: 'Virtualization, Cloud computing',
        email: 'jyothis@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Praveena T',
        role: 'Assistant Professor',
        areaOfInterest: 'Computer Networks',
        email: 'praveenat@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Vishalakshi Prabhu H',
        role: 'Assistant Professor',
        areaOfInterest: 'Wireless Networks, Cloud computing, Algorithms',
        email: 'vishalaprabhu@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Ganashree K C',
        role: 'Assistant Professor',
        areaOfInterest: 'Image processing, Algorithms',
        email: 'ganashree@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Suma B',
        role: 'Assistant Professor',
        areaOfInterest: 'Data mining, image processing',
        email: 'sumab_rao@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Pavithra H',
        role: 'Assistant Professor',
        areaOfInterest: 'SDN, Software Engineering',
        email: 'pavithrah@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Prapulla S B',
        role: 'Assistant Professor',
        areaOfInterest: 'Computer Networks, WSN',
        email: 'prapullasb@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Sneha M',
        role: 'Assistant Professor',
        areaOfInterest: 'Network Security',
        email: 'sneham@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Manonmani S',
        role: 'Assistant Professor',
        areaOfInterest: 'Image Processing, Machine Learning, Deep Learning',
        email: 'manonmanis@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Deepika Dash',
        role: 'Assistant Professor',
        areaOfInterest: 'Compiler Design',
        email: 'deepikadash@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Smriti Srivastava',
        role: 'Assistant Professor',
        areaOfInterest: 'Wireless mesh networks',
        email: 'smritis@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Manas M N',
        role: 'Assistant Professor',
        areaOfInterest: 'Data Mining',
        email: 'manasmn@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr Veena Gadad',
        role: 'Assistant Professor',
        areaOfInterest: 'Data security & privacy',
        email: 'veenagadad@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Anitha Sandeep',
        role: 'Assistant Professor',
        areaOfInterest: 'Information Security',
        email: 'anithasandeep@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Apoorva Udaya Kumar Chate',
        role: 'Assistant Professor',
        areaOfInterest: 'Machine Learning',
        email: 'apoorvaukc@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Rajatha',
        role: 'Assistant Professor',
        areaOfInterest: 'Artificial Intelligence, Machine Learning',
        email: 'rajatha@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Savitri Kulkarni',
        role: 'Assistant Professor',
        areaOfInterest: 'Machine Learning, Deep Learning',
        email: 'savitrikulkarni@rvce.edu.in',
      ),

      // Data Science Faculty
      Faculty(
        name: 'Dr. Shanta Rangaswamy',
        role: 'Professor',
        areaOfInterest: 'Autonomic Computing, Data Mining',
        email: 'shantharangaswamy@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Soumya A',
        role: 'Associate Professor',
        areaOfInterest: 'Computer Cognition Technology',
        email: 'soumyaa@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Sindhu D V',
        role: 'Assistant Professor',
        areaOfInterest: 'NLP, Speech processing, Neural Networks',
        email: 'sindhudv@rvce.edu.in',
      ),

      // Cyber Security Faculty
      Faculty(
        name: 'Dr. Minal Moharir',
        role: 'Professor',
        areaOfInterest:
            'High Performance Computing, Networks & Information Security',
        email: 'minalmoharir@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Ashok Kumar A R',
        role: 'Associate Professor',
        areaOfInterest: 'Computer networks, Data Networks, Distributed Systems',
        email: 'ashokkumarar@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Mohana',
        role: 'Assistant Professor',
        areaOfInterest:
            'Cyber Security, Deep Learning & AI, Quantum Computing, Computer Vision, Signal & Image Processing',
        email: 'mohana@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Neethu S',
        role: 'Assistant Professor',
        areaOfInterest: 'SDN, Machine Learning, Embedded Systems',
        email: 'neethus@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Shweta Babu Prasad',
        role: 'Assistant Professor',
        areaOfInterest: 'Computer Networks, Blockchain',
        email: 'shwetababup@rvce.edu.in',
      ),

      // M.Tech CSE Faculty
      Faculty(
        name: 'Dr. Rajashree Shettar',
        role: 'Professor and Dean (PG Circuit Branches)',
        areaOfInterest: 'Information Retrieval, Data mining',
        email: 'rajashreeshettar@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Azra Nasreen',
        role: 'Associate Professor',
        areaOfInterest: 'Video Analytics',
        email: 'azranasreen@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Srividya M S',
        role: 'Assistant Professor',
        areaOfInterest: 'Computer Vision, Deep Learning, Machine Learning',
        email: 'srividyams@rvce.edu.in',
      ),

      // M.Tech CNE Faculty
      Faculty(
        name: 'Dr. G S Nagaraja',
        role: 'Professor and Associate Dean (PG CSE / PG CNE)',
        areaOfInterest: 'Computer Networks, Network Management',
        email: 'nagarajags@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Vinay Hegde',
        role: 'Associate Professor',
        areaOfInterest: 'Natural language processing, Networks',
        email: 'vinayvhegde@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Sandhya S',
        role: 'Assistant Professor',
        areaOfInterest: 'Networks and Virtualization',
        email: 'sandhya.sampangi@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Electrical and Electronics Engineering',
    value: 'EEE',
    faculties: [
      // UG Faculty
      Faculty(
        name: 'Dr. S. G. Srivani',
        role: 'Professor & (I/C) HOD, Associate PG Dean',
        areaOfInterest:
            'Power System Protection and control, Smart grid and Renewable Energy Technology, Industrial Drives, Power Electronics, Electric Vehicle',
        email: 'srivanisg@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. M. N. Dinesh',
        role: 'Professor',
        areaOfInterest:
            'Insulators for HV applications, control systems, power electronics',
        email: 'dineshmn@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Anitha G.S.',
        role: 'Associate Professor',
        areaOfInterest:
            'Renewable Energy sources, High Voltage Engineering, Power systems and Power electronics',
        email: 'anithags@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. C. Sunanda',
        role: 'Assistant Professor',
        areaOfInterest:
            'High Voltage Insulating Materials, Power system protection',
        email: 'sunandac@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Suresh C.',
        role: 'Assistant Professor',
        areaOfInterest: 'HV, Power Electronics, Embedded systems',
        email: 'sureshac@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Adinatha Jain',
        role: 'Assistant Professor',
        areaOfInterest:
            'Power Systems, Fuzzy Logic Microcontroller, embedded systems',
        email: 'adinatha@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Madhu B.R',
        role: 'Assistant Professor',
        areaOfInterest:
            'HVDC converters, Control Systems, Logic and Asic Design',
        email: 'madhubr@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Ajay K.M',
        role: 'Assistant Professor',
        areaOfInterest: 'VLSI Circuits, Nano Materials',
        email: 'ajaykm@rvce.edu.in',
      ),
      Faculty(
        name: 'Sushmita Sarkar',
        role: 'Assistant Professor',
        areaOfInterest: 'Power System, Photovoltaic System, Power Quality',
        email: 'sushmitasarkar@rvce.edu.in',
      ),
      Faculty(
        name: 'Raja Vidya',
        role: 'Assistant Professor',
        areaOfInterest: 'Wireless Power Transfer, VLSI & Embedded Systems',
        email: 'rajavidya@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Parth Sarathi Panigrahy',
        role: 'Assistant Professor',
        areaOfInterest: 'Condition monitoring of Electrical Machines',
        email: 'parthsarathip@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Pandry Narendra Rao',
        role: 'Assistant Professor',
        areaOfInterest:
            'Multi-level converters, High power factor converters, Grid connected renewable energy sources',
        email: 'pnrao@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Vandana Jha',
        role: 'Assistant Professor',
        areaOfInterest:
            'Solar Photovoltaics, Renewable Energy Sources, Artificial Intelligence in Renewable Energy Sources',
        email: 'vandanajha@rvce.edu.in',
      ),
      // PG Faculty (Power Electronics)
      Faculty(
        name: 'Dr. Hemalatha J.N.',
        role: 'Associate Professor',
        areaOfInterest: 'Power Electronics, Control Systems, Microcontrollers',
        email: 'hemalathajn@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Abhilash Krishna D G',
        role: 'Assistant Professor',
        areaOfInterest:
            'Power electronics applications for power quality improvement',
        email: 'abhilashkrishnadg@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Electronics and Communication Engineering',
    value: 'ECE',
    faculties: [
      // UG Program Faculty
      Faculty(
        name: 'Dr. H. V. Ravish Aradhya',
        role: 'Professor & Associate PG Dean & HOD(I/c)',
        areaOfInterest: 'VLSI & Embedded Systems',
        email: 'ravisharadhya@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. K.S. Geetha',
        role: 'Professor & Vice-Principal',
        areaOfInterest:
            'Signal Processing, Image processing, Flexible Electronics',
        email: 'geethaks@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. M. Uttara Kumari',
        role: 'Professor',
        areaOfInterest: 'Signal Processing',
        email: 'uttarakumari@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Usha Rani K. R',
        role: 'Professor',
        areaOfInterest: 'Signal Processing & Communication Engineering',
        email: 'usharani@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Veena Devi',
        role: 'Associate Professor',
        areaOfInterest: 'Image Processing & Signal Processing',
        email: 'veenadevi@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Nagamani K',
        role: 'Associate Professor',
        areaOfInterest: 'Signal Processing & Communication',
        email: 'nagamanik@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Rajani Katiyar',
        role: 'Associate Professor',
        areaOfInterest: 'Signal Processing & Communication',
        email: 'rajanikatiyar@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Anitha Patil',
        role: 'Associate Professor',
        areaOfInterest: 'Signal Processing & Communication',
        email: 'anithapatil@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Padmaja K V',
        role: 'Associate Professor',
        areaOfInterest: 'Signal Processing & Communication',
        email: 'padmajakv@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Sujatha B K',
        role: 'Associate Professor',
        areaOfInterest: 'Signal Processing & Communication',
        email: 'sujathabk@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Srividya B V',
        role: 'Associate Professor',
        areaOfInterest: 'Signal Processing & Communication',
        email: 'srividyabv@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shruthi K',
        role: 'Assistant Professor',
        areaOfInterest: 'Signal Processing & Communication',
        email: 'shruthik@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shilpa K R',
        role: 'Assistant Professor',
        areaOfInterest: 'Signal Processing & Communication',
        email: 'shilpakr@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shruthi T M',
        role: 'Assistant Professor',
        areaOfInterest: 'Signal Processing & Communication',
        email: 'shruthi.tm@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Mamatha K R',
        role: 'Assistant Professor',
        areaOfInterest: 'Signal Processing & Communication',
        email: 'mamathakr@rvce.edu.in',
      ),
      // M.Tech Communication Systems (MCS) Faculty
      Faculty(
        name: 'Dr. Prakash Biswagar',
        role: 'Professor',
        areaOfInterest: 'Communication Systems',
        email: 'prakashbiswagar@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Kiran V.',
        role: 'Associate Professor',
        areaOfInterest: 'Communication systems, Networking, Signal processing',
        email: 'kiranv@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Ramakrishna K',
        role: 'Associate Professor',
        areaOfInterest: 'Communication Systems',
        email: 'ramakrishnak@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shobha K R',
        role: 'Associate Professor',
        areaOfInterest: 'Communication Systems',
        email: 'shobhakr@rvce.edu.in',
      ),
      // M.Tech VLSI Design & Embedded Systems (MVE) Faculty
      Faculty(
        name: 'Dr. Uma B.V.',
        role: 'Professor & Dean(Student Affairs)',
        areaOfInterest:
            'VLSI Design, Broad band Communication, Microcontroller, IoTs',
        email: 'umabv@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Kariyappa B.S.',
        role: 'Professor',
        areaOfInterest: 'VLSI Design & Embedded Systems',
        email: 'kariyappabs@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. ShylaShree N',
        role: 'Associate Professor',
        areaOfInterest:
            'VLSI Design, Cryptography, Computer Networks, Image Processing',
        email: 'shylashreen@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Siva S Yellampalli',
        role: 'Professor',
        areaOfInterest: 'VLSI Design & Embedded Systems',
        email: 'sivayellampallis@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Roopa M',
        role: 'Associate Professor',
        areaOfInterest: 'VLSI Design & Embedded Systems',
        email: 'roopam@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Disha D N',
        role: 'Assistant Professor',
        areaOfInterest: 'VLSI Design & Embedded Systems',
        email: 'dishadn@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Rajesh K S',
        role: 'Assistant Professor',
        areaOfInterest: 'VLSI Design & Embedded Systems',
        email: 'rajeshks@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Electronics and Instrumentation Engineering',
    value: 'EIE',
    faculties: [
      Faculty(
        name: 'Dr. CH Renu Madhavi',
        role: 'Associate Professor and HOD',
        areaOfInterest: 'Electronics and Instrumentation',
        email: 'renumadhavich@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Padmaja K. V',
        role: 'Professor',
        areaOfInterest: 'Electronics and Instrumentation',
        email: 'padmajakv@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Prasanna Kumar S. C',
        role: 'Professor',
        areaOfInterest: 'Electronics and Instrumentation',
        email: 'prasannakumarsc@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Venkatesh S',
        role: 'Associate Professor',
        areaOfInterest: 'Electronics and Instrumentation',
        email: 'venkatesh@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. K B Ramesh',
        role: 'Associate Professor',
        areaOfInterest: 'Electronics and Instrumentation',
        email: 'rameshkb@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Anand Jatti',
        role: 'Associate Professor',
        areaOfInterest: 'Electronics and Instrumentation',
        email: 'anandjatti@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Sudarshan B. G',
        role: 'Associate Professor',
        areaOfInterest: 'Electronics and Instrumentation',
        email: 'sudarshanbg@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Rachana S. Akki',
        role: 'Assistant Professor',
        areaOfInterest: 'Electronics and Instrumentation',
        email: 'rachanasakki@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Deepashree Devaraj',
        role: 'Assistant Professor',
        areaOfInterest: 'Electronics and Instrumentation',
        email: 'deepashreedevaraj@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Harsha',
        role: 'Assistant Professor',
        areaOfInterest: 'Electronics and Instrumentation',
        email: 'harsha@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Tabitha Janumala',
        role: 'Assistant Professor',
        areaOfInterest: 'Electronics and Instrumentation',
        email: 'tabithajanumala@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Rajasree P. M',
        role: 'Assistant Professor',
        areaOfInterest: 'Electronics and Instrumentation',
        email: 'rajasreepm@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Kendaganna Swamy S',
        role: 'Assistant Professor',
        areaOfInterest: 'Electronics and Instrumentation',
        email: 'kendagannaswamys@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Veena Divya K',
        role: 'Assistant Professor',
        areaOfInterest: 'Electronics and Instrumentation',
        email: 'veenadivyak@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Industrial Engineering and Management',
    value: 'IEM',
    faculties: [
      Faculty(
        name: 'Dr. C K Nagendra Gupta',
        role: 'Associate Professor & Head',
        areaOfInterest: 'Reverse Supply Chain Management',
        email: 'nagendragupta@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. K N Subramanya',
        role: 'Principal & Professor',
        areaOfInterest: 'Supply Chain Mgmt. & Human Resource Mgmt.',
        email: 'subramanyakn@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. N S Narahari',
        role: 'Professor',
        areaOfInterest: 'System Dynamics in HR & Reliability Engg.',
        email: 'naraharins@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Rajeswara Rao K V S',
        role: 'Associate Professor',
        areaOfInterest: 'Manufacturing Mgmt. & Human Resource Mgmt.',
        email: 'rajeswararao@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Vijayakumar M N',
        role: 'Associate Professor',
        areaOfInterest: 'Quality Management',
        email: 'vijayakumar@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Ramaa A',
        role: 'Associate Professor',
        areaOfInterest: 'Supply Chain Management',
        email: 'ramaa@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shobha N S',
        role: 'Assistant Professor',
        areaOfInterest: 'Production Engg. & System Technology',
        email: 'shobhans@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Vivekanand S Gogi',
        role: 'Assistant Professor',
        areaOfInterest: 'Production Technology',
        email: 'vivekanands@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Vikram N Bahadurdesai',
        role: 'Assistant Professor',
        areaOfInterest: 'Production Management',
        email: 'vikramnb@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Chitra B T',
        role: 'Assistant Professor',
        areaOfInterest: 'Constitutional Law',
        email: 'chitrabt@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Shruthi M N',
        role: 'Assistant Professor',
        areaOfInterest: 'Tool Engineering',
        email: 'shruthimn@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Nandini B',
        role: 'Assistant Professor',
        areaOfInterest: 'Engineering Management',
        email: 'nandinibiem@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Bhaskar M G',
        role: 'Assistant Professor',
        areaOfInterest: 'Tool Engineering',
        email: 'bhaskarmg@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Information Science and Engineering',
    value: 'ISE',
    faculties: [
      // UG Faculty
      Faculty(
        name: 'Dr. B.M. Sagar',
        role: 'Professor & HOD',
        areaOfInterest: 'Natural Language Processing, Algorithms',
        email: 'sagarbm@rvce.edu.in',
      ),
      Faculty(
        name: 'S. G. Raghavendra Prasad',
        role: 'Assistant Professor',
        areaOfInterest:
            'Discrete Mathematics, Graph theory, Automata theory, Applied Mathematics, Multicore Programming, Computer System Performance Analysis, Fault Tolerance',
        email: 'raghavendrap@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Kavitha S.N.',
        role: 'Assistant Professor',
        areaOfInterest: 'Image Processing, Neural Networks',
        email: 'kavithasn@rvce.edu.in',
      ),
      Faculty(
        name: 'Rekha B.S.',
        role: 'Assistant Professor',
        areaOfInterest: 'Image Processing and Neural Networks',
        email: 'rekhabs@rvce.edu.in',
      ),
      Faculty(
        name: 'Swetha S',
        role: 'Assistant Professor',
        areaOfInterest: 'Data Mining',
        email: 'shwetha.ise@rvce.edu.in',
      ),
      Faculty(
        name: 'B K Srinivas',
        role: 'Assistant Professor',
        areaOfInterest: 'Cloud Computing, Natural Language Processing',
        email: 'bksrinivas@rvce.edu.in',
      ),
      Faculty(
        name: 'Sharadadevi S Kaganurmath',
        role: 'Assistant Professor',
        areaOfInterest: 'Wireless Sensor Networks',
        email: 'sharadadeviks@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Vanishree K',
        role: 'Assistant Professor',
        areaOfInterest: 'Wireless Sensor networks, Data Analytics',
        email: 'vanishreek@rvce.edu.in',
      ),
      Faculty(
        name: 'Sushmitha N',
        role: 'Assistant Professor',
        areaOfInterest:
            'Brain Computer Interface, Operating Systems, Computer Networks',
        email: 'sushmithan@rvce.edu.in',
      ),
      Faculty(
        name: 'Merin Meleet',
        role: 'Assistant Professor',
        areaOfInterest: 'Data Mining, Bioinformatics, Machine Learning',
        email: 'merinmeleet@rvce.edu.in',
      ),
      // M.Tech Software Engineering Faculty
      Faculty(
        name: 'Dr. G S Mamatha',
        role: 'Professor & Associate Dean (PG Studies)',
        areaOfInterest:
            'Adhoc Networks, Network Security, IOT, Cloud Computing, Software Engineering',
        email: 'mamathags@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Ashwini K.B',
        role: 'Associate Professor',
        areaOfInterest: 'Wireless Sensor Networks',
        email: 'ashwinikb@rvce.edu.in',
      ),
      Faculty(
        name: 'Rashmi R.',
        role: 'Assistant Professor',
        areaOfInterest: 'Software Engineering',
        email: 'rashmir@rvce.edu.in',
      ),
      // M.Tech Information Technology Faculty
      Faculty(
        name: 'Dr. Anala M R',
        role: 'Professor',
        areaOfInterest: 'Networks, Parallel Computing',
        email: 'analamr@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Padmashree T',
        role: 'Associate Professor',
        areaOfInterest: 'Wireless Sensor Networks, Internet of Things',
        email: 'padmashreet@rvce.edu.in',
      ),
      Faculty(
        name: 'Poornima Kulkarni',
        role: 'Assistant Professor',
        areaOfInterest: 'Big Data Analytics, Software Engineering',
        email: 'poornimapk@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Master of Computer Applications',
    value: 'MCA',
    faculties: [
      Faculty(
        name: 'Dr. Andhe Dharani',
        role: 'Professor & Director',
        areaOfInterest: 'Image Processing & Machine Learning',
        email: 'andhedharani@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Usha J',
        role: 'Professor',
        areaOfInterest: 'Mobile & Cloud Computing, Networking, Cyber Security',
        email: 'ushaj@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. K.S. Jasmine',
        role: 'Associate Professor',
        areaOfInterest: 'Software Reuse',
        email: 'jasmineks@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. B. Renuka Prasad',
        role: 'Associate Professor & Associate Dean',
        areaOfInterest: 'Computer Network Security',
        email: 'renukaprasadb@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. B.H. Chandrashekar',
        role: 'Associate Professor',
        areaOfInterest: 'Information Retrieval',
        email: 'chandrashekarbh@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Mohan Aradhya',
        role: 'Assistant Professor',
        areaOfInterest: 'Wireless Sensor Networks',
        email: 'mohanaradhya@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Divya T.L',
        role: 'Assistant Professor',
        areaOfInterest: 'Data Mining',
        email: 'divyatl@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Saravanan C',
        role: 'Assistant Professor',
        areaOfInterest: 'Image Processing',
        email: 'saravananc@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Chandrani Chakravorty',
        role: 'Assistant Professor',
        areaOfInterest: 'Mobile Computing',
        email: 'chandrani@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Savita Sheelavant',
        role: 'Assistant Professor',
        areaOfInterest: 'Image Processing',
        email: 'savitas.sheelavant@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Deepika K',
        role: 'Assistant Professor',
        areaOfInterest:
            'Internet of Things (IoT) & Intelligent Sensor Networks',
        email: 'deepikak@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Prashanth K',
        role: 'Assistant Professor',
        areaOfInterest: 'Wireless Sensor Networks & Internet of Things (IoT)',
        email: 'prashanthk@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Preethi N. Patil',
        role: 'Assistant Professor',
        areaOfInterest: 'Pattern Recognition & Image Processing',
        email: 'preethinpatil@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. R. Savitha',
        role: 'Assistant Professor',
        areaOfInterest: 'Image Processing',
        email: 'savithar@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Mechanical Engineering',
    value: 'ME',
    faculties: [
      // UG Program Faculty
      Faculty(
        name: 'Dr. Krishna M',
        role: 'Professor and Head',
        areaOfInterest: 'Materials Science',
        email: 'krishnam@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shanmukha N',
        role: 'Professor and Dean Academics',
        areaOfInterest: 'Machine Design',
        email: 'shanmukhan@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Nanjundaradhya N V',
        role: 'Professor',
        areaOfInterest: 'Composite Materials',
        email: 'nanjundaradhya@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Gopala Krishna H D',
        role: 'Professor and Associate Dean',
        areaOfInterest: 'Computer Integrated Manufacturing',
        email: 'gopalakrishnahd@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Srihari P V',
        role: 'Associate Professor',
        areaOfInterest: 'Machine Design',
        email: 'sriharipv@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Suresh B S',
        role: 'Associate Professor',
        areaOfInterest: 'Mechanical Vibrations',
        email: 'sureshbs@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Harisha S K',
        role: 'Associate Professor',
        areaOfInterest: 'Robotics Engineering',
        email: 'harishask@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Mahendra Kumar S',
        role: 'Associate Professor',
        areaOfInterest: 'Material Science',
        email: 'mahendrak@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Ratna Pal',
        role: 'Assistant Professor',
        areaOfInterest: 'Metallurgy',
        email: 'ratnapal@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Nagesh S',
        role: 'Assistant Professor',
        areaOfInterest: 'Computer Integrated Manufacturing',
        email: 'nageshs@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Prashanth B N',
        role: 'Assistant Professor',
        areaOfInterest: 'Manufacturing Technology',
        email: 'prashanthbn@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shivakumar B P',
        role: 'Assistant Professor',
        areaOfInterest: 'Manufacturing Engineering',
        email: 'shivakumarbp@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Madhu K S',
        role: 'Assistant Professor',
        areaOfInterest: 'Thermal Engineering',
        email: 'madhuks@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shashidhar K',
        role: 'Assistant Professor',
        areaOfInterest: 'Thermal Power Engineering',
        email: 'shashidhark@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Ravi Kumar M',
        role: 'Assistant Professor',
        areaOfInterest: 'Manufacturing Technology',
        email: 'ravikumarm@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shivaprakash K S',
        role: 'Assistant Professor',
        areaOfInterest: 'Manufacturing Engineering',
        email: 'shivaprakashks@rvce.edu.in',
      ),
      // M.Tech Product Design and Manufacturing Faculty
      Faculty(
        name: 'Dr. H N Narasimha Murthy',
        role: 'Professor and Dean (R&D)',
        areaOfInterest: 'Material Science',
        email: 'narasimhamurthyhn@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Nataraj J R',
        role: 'Associate Professor',
        areaOfInterest: 'Materials Science',
        email: 'natarajjr@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Rajkumar G R',
        role: 'Associate Professor',
        areaOfInterest: 'Production',
        email: 'rajkumargr@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shridhar Deshpande',
        role: 'Associate Professor',
        areaOfInterest: 'Product Design',
        email: 'shridhardeshpande@rvce.edu.in',
      ),
      // M.Tech Machine Design Faculty
      Faculty(
        name: 'Dr. Ramesh S Sharma',
        role: 'Professor',
        areaOfInterest: 'Machine Design',
        email: 'rameshssharma@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Kirthan L J',
        role: 'Associate Professor',
        areaOfInterest: 'Design Engineering',
        email: 'kirthanlj@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Jagannatha Guptha V L',
        role: 'Assistant Professor',
        areaOfInterest: 'Machine Design',
        email: 'jagannathagvl@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Pradeep Kumar K V',
        role: 'Assistant Professor',
        areaOfInterest: 'Machine Design',
        email: 'pradeepkumarkv@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Channakeshava K R',
        role: 'Assistant Professor',
        areaOfInterest: 'Design Engineering',
        email: 'channakeshavakr@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shashidhara S M',
        role: 'Assistant Professor',
        areaOfInterest: 'Machine Design',
        email: 'shashidharasm@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Electronics and Telecommunication Engineering',
    value: 'ECT',
    faculties: [
      Faculty(
        name: 'Dr. K. Sreelakshmi',
        role: 'Professor and HOD',
        areaOfInterest: 'RF circuit design',
        email: 'sreelakshmik@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. H.V. Kumaraswamy',
        role: 'Professor & Associate Dean',
        areaOfInterest: 'Signal processing',
        email: 'kumaraswamyhv@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. P. Nagaraju',
        role: 'Associate Professor & Warden',
        areaOfInterest: 'Analog and Digital communication',
        email: 'nagarajup@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Bhagya R',
        role: 'Associate Professor',
        areaOfInterest: 'MIMO Systems',
        email: 'bhagyar@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. B. Roja Reddy',
        role: 'Associate Professor',
        areaOfInterest: 'MIMO Radar signals processing',
        email: 'rojareddyb@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Premananda B S',
        role: 'Associate Professor',
        areaOfInterest: 'Signal Processing, VLSI',
        email: 'premanandabs@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shanthi P.',
        role: 'Associate Professor',
        areaOfInterest: 'RF VLSI',
        email: 'shanthip@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Usha Padma',
        role: 'Assistant Professor',
        areaOfInterest: 'Computer Networks',
        email: 'kamakshimb@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. T. P. Mithun',
        role: 'Assistant Professor',
        areaOfInterest: 'Wired/Wireless networks',
        email: 'mithuntp@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Pawankumar B',
        role: 'Assistant Professor',
        areaOfInterest: 'CMOS VLSI',
        email: 'pawankumarb@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shambulinga M.',
        role: 'Assistant Professor',
        areaOfInterest: 'Wireless Communication',
        email: 'shambulingam@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Nagendra N N',
        role: 'Assistant Professor',
        areaOfInterest: 'RF & Microwave',
        email: 'nagendrann@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Mahalakshmi. M. N',
        role: 'Assistant Professor',
        areaOfInterest: 'Signal processing',
        email: 'mahalakshmimn@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Sandya H B',
        role: 'Assistant Professor',
        areaOfInterest: 'Analog & digital Communication',
        email: 'sandhyahb@rvce.edu.in',
      ),
      Faculty(
        name: 'Prof. Rakesh K R',
        role: 'Assistant Professor',
        areaOfInterest: 'Communication',
        email: 'rakeshkr@rvce.edu.in',
      ),
      // Post Graduate - Digital Communication Engineering Faculty
      Faculty(
        name: 'Dr. Nagamani K',
        role: 'Professor',
        areaOfInterest: 'Wireless communication',
        email: 'nagamanik@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. K. Saraswathi',
        role: 'Associate Professor',
        areaOfInterest: 'Wireless communication',
        email: 'ksaraswathi@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Ranjani G',
        role: 'Assistant Professor',
        areaOfInterest: 'Signal processing',
        email: 'ranjanig@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Department of Chemistry',
    value: 'CHEM',
    faculties: [
      Faculty(
        name: 'Dr. Raviraj Kusanur',
        role: 'Associate Professor & HOD',
        areaOfInterest:
            'Medicinal Chemistry, Organic Synthesis, Organic Materials Synthesis',
        email: 'ravirajak@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Mahesh. R.',
        role: 'Assistant Professor',
        areaOfInterest: 'Coordination Chemistry, Heterostructures',
        email: 'maheshr@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. C. Manjunatha',
        role: 'Assistant Professor',
        areaOfInterest: 'Inorganic Nanomaterials',
        email: 'manjunathac@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Divakara S. G.',
        role: 'Assistant Professor',
        areaOfInterest: 'Nanomaterials, Thin Films, Catalysis',
        email: 'divakarsg@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Sham Aan M. P.',
        role: 'Assistant Professor',
        areaOfInterest:
            'Electrospun Polymeric Materials, Elastomeric Nanocomposites',
        email: 'shamaan.mp@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. M. Sridharan',
        role: 'Assistant Professor',
        areaOfInterest:
            'Synthetic Organic Chemistry, Total Synthesis, X-ray Crystallography',
        email: 'sridharanm@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Swarna M Patra',
        role: 'Assistant Professor',
        areaOfInterest:
            'Computational Biology/Chemistry, Chemical Graph Theory, Molecular Dynamics',
        email: 'swarnamp@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Vishnumurthy K. A.',
        role: 'Assistant Professor',
        areaOfInterest: 'Conjugated Polymers, Organic Electronics, Sensors',
        email: 'vishnumurthyka@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Girish Kumar S',
        role: 'Assistant Professor',
        areaOfInterest: 'Materials chemistry',
        email: 'girishkumars@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Swetha S. M',
        role: 'Assistant Professor',
        areaOfInterest:
            'Photoelectrochemical water splitting, photocatalysis, batteries, and nanomaterial synthesis',
        email: 'swethasm@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Rita Hemanth Shankar',
        role: 'Assistant Professor',
        areaOfInterest: '',
        email: '',
      ),
    ],
  ),
  Department(
    label: 'Department of Physics',
    value: 'PHY',
    faculties: [
      Faculty(
        name: 'Dr. Sudha Kamath M K',
        role: 'Associate Professor & HOD',
        areaOfInterest:
            'Polymer composites and thin films, Energy storage devices- Supercapacitors',
        email: 'sudhakamath@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Bhuvaneswara Babu T.',
        role: 'Professor',
        areaOfInterest: 'Thin Films',
        email: 'bhuvaneswarbt@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Avadhani D.N.',
        role: 'Associate Professor',
        areaOfInterest:
            'Radiation Physics, Nano Materials, Conducting polymers',
        email: 'avadhanidn@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. G. Shireesha',
        role:
            'Associate Professor & Associate Dean (Extra-Curricular Activities)',
        areaOfInterest: 'Thin films and Polymer nanocomposites',
        email: 'shireeshag@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shubha S',
        role: 'Assistant Professor (Selection Grade)',
        areaOfInterest: 'Physics Education Research, Computational Physics',
        email: 'shubhas@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Tribikram Gupta',
        role: 'Assistant Professor (Senior scale)',
        areaOfInterest: 'Condensed matter theory',
        email: 'tgupta@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. B M Rajesh',
        role: 'Assistant Professor (Senior scale)',
        areaOfInterest:
            'Condensed Matter Physics, Density Functional Theory, Computational Physics',
        email: 'rajeshbm@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Ramya P',
        role: 'Assistant Professor (Senior scale)',
        areaOfInterest:
            'Polymer Nano Composites, gas sensors and Positron Annihilation Spectroscopy',
        email: 'ramyap@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Karthik Shastry',
        role: 'Assistant Professor (Senior scale)',
        areaOfInterest:
            'Auger Spectroscopy, X-ray photoelectron spectroscopy, Positron Annihilation Spectroscopy, Topological Insulators',
        email: 'karthikshastry@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Niranjana K M',
        role: 'Assistant Professor',
        areaOfInterest: 'Nuclear Physics, Computational Physics',
        email: 'niranjanakm@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Dileep MS',
        role: 'Assistant Professor',
        areaOfInterest: 'Solid State Physics',
        email: 'dileepms@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Shwetha K P',
        role: 'Assistant Professor',
        areaOfInterest: 'Solid State Physics',
        email: 'shwethakp@rvce.edu.in',
      ),
    ],
  ),
  Department(
    label: 'Department of Mathematics',
    value: 'MATH',
    faculties: [
      Faculty(
        name: 'Dr. G. Jayalatha',
        role: 'Professor and Incharge HOD',
        areaOfInterest: 'Fluid Mechanics, Numerical Techniques',
        email: 'jayalathag@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Neeti Ghiya',
        role: 'Associate Professor',
        areaOfInterest:
            'Special functions, Fractional Calculus, Numerical Methods',
        email: 'neethighiya@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. C. Nandeesh kumar',
        role: 'Associate Professor',
        areaOfInterest: 'Graph Theory, Number Theory, Applied Mathematics',
        email: 'nandeeshkumarc@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Savithri Shashidhar',
        role: 'Associate Professor',
        areaOfInterest: 'Differential Geometry, Numerical Methods',
        email: 'savithrishashidhar@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Prakash.R',
        role: 'Associate Professor',
        areaOfInterest: 'Discrete Structures, Graph Theory, Fluid Mechanics',
        email: 'prakashr@rvce.edu.in',
      ),
      Faculty(
        name: 'Mr. P.L. Rajashekhar',
        role: 'Assistant Professor',
        areaOfInterest: 'Fractional Differential Equations',
        email: 'rajashekarpl@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Y. Sailaja',
        role: 'Assistant Professor',
        areaOfInterest: 'Complex analysis, Numerical methods',
        email: 'sailajay@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Sujatha. A.',
        role: 'Assistant Professor',
        areaOfInterest: 'Linear Algebra, Fuzzy Reliability theory',
        email: 'sujathaa@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Vidya Patil',
        role: 'Assistant Professor',
        areaOfInterest:
            'Special functions, Fractional Calculus, Mathematical Modelling',
        email: 'vidyapatil@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Nivya Muchikel',
        role: 'Assistant Professor',
        areaOfInterest:
            'Fluid Mechanics, Numerical Analysis, Operation Research',
        email: 'nivyamuchikel@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Ravi K. M',
        role: 'Assistant Professor',
        areaOfInterest:
            'Fuzzy Automata, Extended Fuzzy Sets, Pattern Recognition',
        email: 'drravikm@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Sowmya M',
        role: 'Assistant Professor',
        areaOfInterest: 'Fractional Differential Equations, Numerical Analysis',
        email: 'sowmyam@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Satish V. Motammanavar',
        role: 'Assistant Professor',
        areaOfInterest: 'Graph Theory Combinatorial Designs',
        email: 'satishvm@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Harish M',
        role: 'Assistant Professor',
        areaOfInterest:
            "Special Functions, Ramanujan's Theta Functions, Modular Equations",
        email: 'harishm@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Suman N P',
        role: 'Assistant Professor',
        areaOfInterest: 'Number Theory, Special Functions, Continued Fractions',
        email: 'sumannp@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Kiran Kumar D L',
        role: 'Assistant Professor',
        areaOfInterest: 'Differential Geometry',
        email: 'kirankumardl@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Venugopal K',
        role: 'Assistant Professor',
        areaOfInterest: 'Graph Theory',
        email: 'venugopalk@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Niranjan P. K',
        role: 'Assistant Professor',
        areaOfInterest: 'Graph Theory',
        email: 'niranjanpk@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Suma N Manjunath',
        role: 'Assistant Professor',
        areaOfInterest: 'Fluid mechanics, Graph Theory',
        email: 'sumanm@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Prasanna Kumar. T',
        role: 'Assistant Professor',
        areaOfInterest: 'Fluid dynamics, viscous flows',
        email: 'prasannakt@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Sakshath T N',
        role: 'Assistant Professor',
        areaOfInterest:
            'Fluid mechanics, hydrodynamic stabilities, Convection, flow problems',
        email: 'sakshath.tn@gmail.com',
      ),
      Faculty(
        name: 'Dr. Hemanthkumar B',
        role: 'Assistant Professor',
        areaOfInterest:
            'Number Theory, Special functions, q-series, partition theory',
        email: 'hemanthkumarb@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Kirthiga M',
        role: 'Assistant Professor',
        areaOfInterest:
            'Differential Equations, Biochemistry, Mathematical Modelling, Biosensor',
        email: 'kirthigam@rvce.edu.in',
      ),
      Faculty(
        name: 'Dr. Vyshnavi D',
        role: 'Assistant Professor',
        areaOfInterest: 'Graph Theory, Number Theory, Linear Algebra',
        email: 'vyshnavid@rvce.edu.in',
      ),
    ],
  ),
];

// Convert faculty list to staff list for dropdowns
final Map<String, List<Staff>> departmentStaff = Map.fromEntries(
  departments.where((dept) => dept.faculties != null).map((dept) {
    return MapEntry(
      dept.value,
      dept.faculties!
          .map((faculty) => Staff(
                label: '${faculty.name} (${faculty.role})',
                value: faculty.email,
                departmentCode: dept.value,
              ))
          .toList(),
    );
  }),
);

// Document types
final documentTypes = [
  DocumentType(label: 'National ID', value: 'NID'),
  DocumentType(label: 'Aadhar Card', value: 'AADHAR'),
  DocumentType(label: 'Driving License', value: 'DL'),
  DocumentType(label: 'Company ID', value: 'CID'),
  DocumentType(label: 'Other', value: 'OTHER'),
];

🎓 Degree Validation System — Prolog
This project implements a Degree Validation System using Prolog, aimed at verifying degrees based on HEC (Higher Education Commission) accreditation guidelines. It evaluates the validity of academic degrees against officially established standards and provides real-time feedback to the user.

✅ Features
🔍 HEC Accreditation Check
Validates degrees based on predefined HEC rules and accreditation criteria.

📋 Rule-Based Evaluation
Developed logic-based algorithms in Prolog that simulate expert decision-making.

📢 User Feedback System
Provides users with detailed messages regarding the status and authenticity of their degrees.

🔄 Easily Extendable
The knowledge base and rule set can be updated as HEC policies evolve.

🛠️ Technologies Used
Language: Prolog

Environment: SWI-Prolog or compatible Prolog interpreter

💡 How It Works
The system takes input regarding the degree type, issuing university, program accreditation, and year.

It then checks:

Whether the university is recognized.

If the program is accredited.

If the degree meets HEC guidelines.

Based on rules defined in Prolog, it outputs whether the degree is:

✅ Valid

❌ Invalid

⚠️ Partially compliant (if applicable)

📂 File Structure
degree_validation_system/
│
├── degree_validator.pl        # Main Prolog source file containing all rules
├── README.md                  # Project documentation
└── sample_queries.txt         # Example queries to test the system
▶️ Sample Query

?- is_valid_degree(bachelors, "FAST NUCES", cs, 2021).
Output:
Degree is valid according to HEC guidelines.
🚀 Getting Started
1. Install SWI-Prolog
Download and install from: https://www.swi-prolog.org/

2. Run the Program
swipl
?- [degree_validator].
3. Test a Query
Use the sample queries or create your own based on degree parameters.

🔧 Future Improvements
Integration with real-time HEC datasets.

Web-based interface for easier input.

Multilingual support (e.g., Urdu interface).

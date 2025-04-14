% Library for reading CSV files
:- use_module(library(csv)).

% HEC Requirement Categories and Percentages
category(general_education, 19).
category(university_electives, 12).
category(math_foundation, 12).
category(computing_core, 39).
category(domain_cs_core, 24).
category(domain_cs_electives, 15).
category(domain_cs_supporting, 9).

% Dynamic facts to store student transcripts
:- dynamic student_transcript/2.
:- discontiguous process_student_transcript/1.

% Consult the course requirements file
:- consult('C:\\Users\\nujoodk\\Documents\\Prolog\\course_requirements.pl').


% Function to process a single student's transcript
process_student_transcript(File) :-
    retractall(student_transcript(_, _)),
    csv_read_file(File, Rows, [functor(row), arity(7)]),
    forall(member(Row, Rows), (
        parse_transcript_row(Row, CourseName, CreditHours),
        assert(student_transcript(CourseName, CreditHours)),
        (course(CourseName, _, _) -> true ; writeln('Course not in knowledge base. Add it: ' + CourseName)) %to check which courses in std transcript are not in kb, if not in kb it will print a message to add it
    )),
    meets_hec_requirements.


% Function to parse data from each CSV row
parse_transcript_row(row(_, CourseName, CreditHours, _, _, _,_), CourseName, CreditHours).

% Rule to check if HEC requirements are met
meets_hec_requirements :-
    writeln('Checking if HEC requirements are met'),
    nl,
    findall(CategoryName, (
        category(CategoryName, Requiredcrd),
        total_credits_in_category(CategoryName, StudentCredits),
        HecRequiredCredits is Requiredcrd,
        check_category_completion(StudentCredits, HecRequiredCredits, CategoryName, RequirementStatus),
        RequirementStatus = not_met  % To check how many catogeries are not met and which ones
    ), NotMetCategories),
    length(NotMetCategories, NotMetCount),
    TotalCategories is 7,

    nl,
    format('Not Met ~w out of ~w categories.~n', [NotMetCount, TotalCategories]),
    nl,
    format('Not Met Categories: ~w~n', [NotMetCategories]),
    nl,
    (NotMetCount = 0 ->

        writeln('Degree validation requirement met!');
        writeln('Degree validation requirement not met.')
    ).



% Rule to calculate total student credits in a category
total_credits_in_category(Category, TotalCredits) :-
    findall(Credits, (
        student_transcript(CourseName, CreditHours),
        course(CourseName, Category, RequiredCredits),
        Credits is min(CreditHours, RequiredCredits) %this ensures that if a course has more credit hours than required so only the required credits are considered.
    ), CreditList),
    sumlist(CreditList, TotalCredits).%calculating std credits in each catogery


% Rule to check completion for each category
check_category_completion(StudentCredits, HecRequiredCredits, CategoryName, RequirementStatus) :-
    nl,
    writeln('Category: '),
    writeln(CategoryName),
    nl,
    writeln('Student Credits (in Transcript): '),
    writeln(StudentCredits),
    nl,
    writeln('Credits required by HEC: '),
    writeln(HecRequiredCredits),
    nl,
    (StudentCredits >= HecRequiredCredits ->
        writeln('Category requirement met!'),
        RequirementStatus = met;
        writeln('Category requirement not met.'),
        RequirementStatus = not_met
    ).

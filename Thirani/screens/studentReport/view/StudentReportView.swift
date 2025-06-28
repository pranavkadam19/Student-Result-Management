//
//  StudentReportView.swift
//  Thirani
//
//  Created by indianrenters on 15/06/25.
//
import SwiftUI

struct StudentReportView: View {
    @State private var selectedClass: SchoolClass = .class1
    @State private var selectedDivision: Division = .a
    @State private var students: [StudentEntryModel] = demoStudents
    
    var filtered: [StudentEntryModel] {
        students.filter {
            $0.className == selectedClass.rawValue &&
            $0.divsion.lowercased() == selectedDivision.rawValue
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    
                    Picker("Class", selection: $selectedClass) {
                        ForEach(SchoolClass.allCases, id: \.self) { schoolClass in
                            Text("Class \(schoolClass.rawValue)")
                        }
                    }
                    .pickerStyle(.menu)

                    Picker("Division", selection: $selectedDivision) {
                        ForEach(Division.allCases, id: \.self) { division in
                            Text("Division \(division.rawValue.uppercased())")
                        }
                    }
                    .pickerStyle(.menu)
                    
                    // CSV placeholder button
                    Button(action: {
                        // export logic can be added here
                    }) {
                        HStack {
                            Image(systemName: "doc.text")
                            Text("Export CSV")
                        }
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                    }
                    
                    Divider()
                    
                    // Details table per student
                    ForEach(filtered) { student in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(student.name).font(.headline)
                            
                            HStack {
                                Text("Subject").bold().frame(maxWidth: .infinity, alignment: .leading)
                                Text("Marks").bold().frame(width: 60, alignment: .center)
                                Text("%").bold().frame(width: 40, alignment: .center)
                                Text("Grade").bold().frame(width: 50, alignment: .center)
                            }
                            
                            ForEach(Subject.allCases, id: \.self) { subject in
                                if let marks = student.subjectMarks[subject] {
                                    let pct = subject.percentage(for: marks)
                                    HStack {
                                        Text(subject.rawValue.capitalized)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text("\(marks)").frame(width: 60)
                                        Text(String(format: "%.0f%%", pct)).frame(width: 40)
                                        Text(subject.grade(for: marks)).frame(width: 50)
                                    }
                                }
                            }
                            
                            if let fb = student.feedback {
                                Text("Feedback: \(fb)")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            
                            Divider()
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 40)
                }
            }
            .navigationTitle("Student Report")
        }
    }
}

let demoStudents: [StudentEntryModel] = [
    StudentEntryModel(
        name: "Alice Sharma",
        dateOfBirth: Calendar.current.date(from: DateComponents(year: 2012, month: 5, day: 10))!,
        className: 1,
        divsion: "A",
        subjectMarks: [
            .maths: 95,
            .english: 88,
            .marathi: 92,
            .science: 90,
            .history: 45,
            .geography: 48,
            .hindi: 85,
            .sanskrit: 40,
        ],
        feedback: "Excellent participation and consistent high scores."
    ),
    StudentEntryModel(
        name: "John Patel",
        dateOfBirth: Calendar.current.date(from: DateComponents(year: 2011, month: 8, day: 22))!,
        className: 1,
        divsion: "A",
        subjectMarks: [
            .maths: 75,
            .english: 80,
            .marathi: 78,
            .science: 72,
            .history: 40,
            .geography: 43,
            .hindi: 70,
            .sanskrit: 35,
        ],
        feedback: "Shows promise; needs extra support in maths and history."
    ),
    StudentEntryModel(
        name: "Bob Joshi",
        dateOfBirth: Calendar.current.date(from: DateComponents(year: 2012, month: 3, day: 15))!,
        className: 2,
        divsion: "B",
        subjectMarks: [
            .maths: 85,
            .english: 78,
            .marathi: 82,
            .science: 80,
            .history: 48,
            .geography: 46,
            .hindi: 88,
            .sanskrit: 45,
        ],
        feedback: "Good overall performance; excels in languages."
    ),
    StudentEntryModel(
        name: "Diana Rao",
        dateOfBirth: Calendar.current.date(from: DateComponents(year: 2011, month: 11, day: 30))!,
        className: 1,
        divsion: "A",
        subjectMarks: [
            .maths: 98,
            .english: 95,
            .marathi: 90,
            .science: 93,
            .history: 50,
            .geography: 49,
            .hindi: 92,
            .sanskrit: 48,
        ],
        feedback: "Top performer in science and maths; very focused."
    ),
    StudentEntryModel(
        name: "Emma Kulkarni",
        dateOfBirth: Calendar.current.date(from: DateComponents(year: 2012, month: 12, day: 5))!,
        className: 3,
        divsion: "C",
        subjectMarks: [
            .maths: 65,
            .english: 70,
            .marathi: 68,
            .science: 60,
            .history: 35,
            .geography: 38,
            .hindi: 75,
            .sanskrit: 30,
        ],
        feedback: "Needs improvement in social studies and Sanskrit."
    ),
    StudentEntryModel(
        name: "Rahul Desai",
        dateOfBirth: Calendar.current.date(from: DateComponents(year: 2011, month: 6, day: 20))!,
        className: 2,
        divsion: "B",
        subjectMarks: [
            .maths: 55,
            .english: 60,
            .marathi: 58,
            .science: 62,
            .history: 42,
            .geography: 45,
            .hindi: 50,
            .sanskrit: 28,
        ],
        feedback: "Average performance; could benefit from tutoring."
    )
]

//
//  StudentEntryView.swift
//  Thirani
//
//  Created by indianrenters on 14/06/25.
//

import SwiftUI

struct StudentEntryView: View {
    @StateObject var viewModel: StudentEntryViewModel = StudentEntryViewModel()
    
    @State private var name: String = ""
    @State private var dateOfBirth: Date? = nil
    @State private var className: String = ""
    @State private var division: String = ""
    @State private var feedback: String = ""
    @State private var errorMessage: String = ""
    
    @State private var subjectMarks: [Subject: String] = {
        var dict: [Subject: String] = [:]
        for subject in Subject.allCases {
            dict[subject] = ""
        }
        return dict
    }()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Enter Student Details")
                    .font(.title2)
                    .bold()

                VStack {
                    TextField("Name", text: $name)
                    TextField("Class (e.g. 9)", text: $className)
                        .keyboardType(.numberPad)
                    TextField("Division (e.g. A)", text: $division)
                    DatePicker("Date of Birth", selection: Binding(get: { dateOfBirth ?? Date()}, set: { dateOfBirth = $0}), displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .padding()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())

                Divider()

                Text("Enter Marks for Subjects")
                    .font(.headline)

                ForEach(Subject.allCases, id: \.self) { subject in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(subject.rawValue.capitalized)
                            .font(.subheadline)
                            .bold()

                        TextField("Marks out of \(subject.totalMarks)", text: Binding(
                            get: { subjectMarks[subject] ?? "" },
                            set: { subjectMarks[subject] = $0 }
                        ))
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                        if let markStr = subjectMarks[subject], let marks = Int(markStr) {
                            let percentage = subject.percentage(for: marks)
                            let grade = subject.grade(for: marks)
                            Text("→ Percentage: \(String(format: "%.1f", percentage))%, Grade: \(grade)")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }

                Divider()

                Text("Feedback (Optional)")
                    .font(.headline)
                TextField("Enter feedback here...", text: $feedback)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Divider()
                if viewModel.errorMessage != "" {
                    Text(viewModel.errorMessage)
                        .fontWeight(.medium)
                        .font(.subheadline)
                        .foregroundStyle(.red)
                }
                
                Button(action: {
                    
                    guard let dob = dateOfBirth else {
                        errorMessage = "please select a date of birth"
                        return
                    }
                    
                    viewModel.saveStudent(name: name, dateOfBirth: dob, className: className, division: division, subjectMarks: subjectMarks, feedback: feedback)
                }) {
                    Text("Save Student Entry")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 12)
            }
            .padding()
        }
    }
}
#Preview {
    StudentEntryView()
}

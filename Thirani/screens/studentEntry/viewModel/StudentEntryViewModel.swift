//
//  Viewmodel.swift
//  Thirani
//
//  Created by indianrenters on 14/06/25.
//

import Foundation

class StudentEntryViewModel: ObservableObject {
    @Published var studentEntry: StudentEntryModel?
    @Published var errorMessage: String = ""
    
    func saveStudent(name: String, dateOfBirth: Date, className: String, division: String, subjectMarks: [Subject: String], feedback: String?){
        
        guard let classInt = Int(className) else {
            errorMessage = "Invalid class"
            return
        }
        
        if name.isEmpty {
            errorMessage = "Please enter a name"
        }
        
        if division.isEmpty {
            errorMessage = "Please enter a division"
        }
        
        var marksDict: [Subject: Int] = [:]
        for (subject, markStr) in subjectMarks{
            if let markInt = Int(markStr){
                marksDict[subject] = markInt
            } else {
                errorMessage = "please enter valid marks"
            }
        }
        
        let newStudentEntry = StudentEntryModel(name: name, dateOfBirth: dateOfBirth, className: classInt, divsion: division, subjectMarks: marksDict, feedback: feedback?.isEmpty == false ? feedback: nil)
        
        print("new Student record: \(newStudentEntry)")
    }
}

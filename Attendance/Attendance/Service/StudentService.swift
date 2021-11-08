//
//  StudentService.swift
//  Attendance
//
//  Created by Eth Os on 03/04/1443 AH.
//

import UIKit
import FirebaseFirestore

class StudentService{
    
    static let shared = StudentService()
    
    let studentCollecrtion = Firestore.firestore().collection("students")
    
    /// Add New Student
    func addNewStudent(student: Student){
        studentCollecrtion.document(student.id).setData([
            "id": student.id,
            "name": student.studentName
        ])
    }
    
    
    /// Delete Student
    func deleteStudent(studentId: String){
        studentCollecrtion.document(studentId).delete()
    }
    
    
    /// Listen to student
    func studentListenr(compeletion: @escaping (([Student]) -> Void)){
        studentCollecrtion.addSnapshotListener { querySnapshot, error in
            if error != nil {
                return
            }
            let uuid = UUID().uuidString
            guard let documents = querySnapshot?.documents else { return }
            var students = [Student]()
            for document in documents {
                let data = document.data()
                let id = (data["id"] as? String ) ?? uuid
                let name = (data["name"] as? String) ?? "No Name"
                let student = Student(id: id, studentName: name)
                students.append(student)
            }
            compeletion(students)
        }
    }
    
    
    /// Get Student Count
    func listenToStudentCount(compeletion: @escaping ((Int) -> Void)){
        studentListenr { students in
            compeletion(students.count)
        }
    }

}

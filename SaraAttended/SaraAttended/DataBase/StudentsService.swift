//
//  StudentsService.swift
//  SaraAttended
//
//  Created by sara saud on 11/8/21.
//

import UIKit
import FirebaseFirestore

class StudentsService {
    
    //add student
    static let shared = StudentsService()
    
    let studentsCollection = Firestore.firestore().collection("students")
    
    func addStudent(student: Student) {
        //firestore
        studentsCollection.document(student.id).setData([
            "name": student.name,
            "id": student.id
        ])
   
    }
    
    //delete student
    
    func deleteStudent(studentId : String) {
        //firbase
        studentsCollection.document(studentId).delete()

    }
//    switch student status
    
//    lessson to students
    
    func listenToStudents(completion: @escaping (([Student]) -> Void)) {
        
        //fairbase
        
        studentsCollection.addSnapshotListener { snapshot, error in
            if error != nil {
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            var students: Array<Student> = []
            for document in documents {
                let data = document.data()
                let student = Student(
                    name: (data["name"] as? String) ?? "No name",
                    id: (data["id"] as? String) ?? "No id"
                )
                students.append(student)
            }
            
            completion(students)
        }
    }
    
//    get students cunt
    func listenToStudentCount(completion: @escaping ((Int) -> Void)) {
        listenToStudents { students in
            completion(students.count)
        }
    }
    
}

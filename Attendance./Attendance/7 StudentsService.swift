//
//  File7.swift
//  Attendance
//
//  Created by Fawaz on 08/11/2021.
//

import UIKit
import FirebaseFirestore
//==========================================================================
class StudentsService {
  
  static let shared = StudentsService()
  
  let studentsCollection = Firestore.firestore().collection("students")
  //==========================================================================
  func addStudent(student: Students) {
    studentsCollection.document(student.id).setData([
      "name": student.name!, "id": student.id])
  }
  //==========================================================================
  func deleteStudent(studentId: String) {
    studentsCollection.document(studentId).delete()
  }
  //==========================================================================
  func listenToStudents(completion: @escaping (([Students]) -> Void)) {
    
    studentsCollection.addSnapshotListener { snapshot, error in
      if error != nil {
        return
      }
      
      guard let documents = snapshot?.documents else { return }
      
      var students: Array<Students> = []
      
      for document in documents {
        
        let data = document.data()
        
        let student = Students(
          name: (data["name"] as? String) ?? "No name",
          id: (data["id"] as? String) ?? "No id"
        )
        students.append(student)
      }
      completion(students)
    }
  }
  //==========================================================================
  func listenToStudentCount(completion: @escaping ((Int) -> Void)) {
    listenToStudents { students in completion(students.count)
    }
  }
}

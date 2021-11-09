//
//  Days.swift
//  Attendance App-Afnan
//
//  Created by Fno Khalid on 03/04/1443 AH.
//

import UIKit
import FirebaseFirestore

class DaysService {
    
    static let shared = DaysService()
    
    let daysCollection = Firestore.firestore().collection("days")
    
    func listenToDays(completion: @escaping (([Day]) -> Void)) {
        daysCollection.addSnapshotListener { snapshot, error in
            if error != nil {
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            var days: Array<Day> = []
            for document in documents {
                let data = document.data()
                let day = Day(
                    id: (data["id"] as? String) ?? "No id",
                    time: (data["timestamp"] as? Timestamp) ?? Timestamp(),
                    presentStudent: (data["presentStudents"] as? [String]) ?? []
                )
                days.append(day)
            }
            completion(days)
        }
    }
    
    func listenToDay(dayId: String, completion: @escaping ((Day?) -> Void)) {
        daysCollection.document(dayId).addSnapshotListener { document, error in
            if error != nil {
                completion(nil)
                return
            }
            guard let data = document?.data() else {
                completion(nil)
                return
            }
            
            let day = Day(
                id: (data["id"] as? String) ?? "No id",
                time: (data["timestamp"] as? Timestamp) ?? Timestamp(),
                presentStudent: (data["presentStudents"] as? [String]) ?? []
            )
            completion(day)
        }
    }
    
   
    func addDay(day: Day) {
        daysCollection.document(day.id).setData([
            "timestamp": day.time,
            "id": day.id,
            "presebtStudents": day.presentStudent,
        ])
    }
    

    func deleteDay(dayId: String) {
        daysCollection.document(dayId).delete()
    }
    
    
    // Switch Student Status
    func switchStudentStatus(day: Day, studentId: String) {
        let isStudentPresent = day.presentStudent.contains(studentId)
        
        if isStudentPresent {
            let newPStudents = day.presentStudent.filter { id in id != studentId }
            
            daysCollection.document(day.id).updateData([
                "presentStudents": newPStudents
            ])
        } else {
            var newPStudents = day.presentStudent
            newPStudents.append(studentId)
            
            daysCollection.document(day.id).updateData([
                "presentStudents": newPStudents
            ])
        }
    }
    
    
    
    
}

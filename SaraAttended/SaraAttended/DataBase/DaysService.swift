//
//  DaysService.swift
//  SaraAttended
//
//  Created by sara saud on 11/8/21.
//

import UIKit
import FirebaseFirestore

class DaysService {
    static let shared = DaysService()
    
    let daysCollection = Firestore.firestore().collection("days")
    
    // swich student status
    func switchStudentStatus(day: Day, studentId: String) {
        let isStudentPresent = day.pStudents.contains(studentId)
        
        if isStudentPresent {
            let newPStudents = day.pStudents.filter { id in id != studentId }
            
            daysCollection.document(day.id).updateData([
                "pStudents": newPStudents
            ])
        } else {
            var newPStudents = day.pStudents
            newPStudents.append(studentId)
            
            daysCollection.document(day.id).updateData([
                "pStudents": newPStudents
            ])
        }
    }
    
    
    //listn to days
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
                    timestamp: (data["timestamp"] as? Timestamp) ?? Timestamp(),
                    pStudents: (data["pStudents"] as? [String]) ?? []
                )
                days.append(day)
            }
            completion(days)
        }
    }
    
    //listn to a day
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
                timestamp: (data["timestamp"] as? Timestamp) ?? Timestamp(),
                pStudents: (data["pStudents"] as? [String]) ?? []
            )
            completion(day)
        }
    }
    
    //add day
    func addDay(day: Day) {
        daysCollection.document(day.id).setData([
            "timestamp": day.timestamp,
            "id": day.id,
            "pStudents": day.pStudents,
        ])
    }
    
//    delet day
    func deleteDay(dayId: String) {
        daysCollection.document(dayId).delete()
    }
    
}

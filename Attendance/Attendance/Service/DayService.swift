//
//  DayService.swift
//  Attendance
//
//  Created by Eth Os on 03/04/1443 AH.
//

import UIKit
import FirebaseFirestore

class DayService {
    
    let dayCollection = Firestore.firestore().collection("days")
    
    
    static let shared = DayService()
    
    /// Add New Day
    func addNewDay(day: Day){
        dayCollection.document(day.id).setData([
            
            "id":         day.id,
            "date":       day.date,
            "attendence": day.attendenc
            
        ])
    }
    
    
    /// Listen to Day
    func dayListenr(dayId: String, compeltion: @escaping ((Day?) -> Void)){
        dayCollection.document(dayId).addSnapshotListener { documnt, error in
            if error != nil {
                compeltion(nil)
                return
            }
            
            guard let data = documnt?.data() else {
                compeltion(nil)
                return
            }
            
            let id          = (data["id"] as? String) ?? "No ID"
            let date        = ((data["date"] as? Timestamp) ?? Timestamp()).dateValue()
            let attendenc   = (data["attendence"] as? [String]) ?? []
            let day         = Day(id: id, date: date, attendenc: attendenc)
            
            compeltion(day)
        }
    }
    
    /// Listen to Days
    func allDaysListenr(compeletion: @escaping (([Day]) -> Void)){
        dayCollection.addSnapshotListener { querySnapshot, error in
            if error != nil {
                return
            }
            
            guard let documents = querySnapshot?.documents else { return }
            
            var days    = [Day]()
            
            for document in documents {
                
                let data        = document.data()
                let id          = (data["id"] as? String) ?? "No ID"
                let date        = ((data["date"] as? Timestamp) ?? Timestamp()).dateValue()
                let attendenc   = (data["attendence"] as? [String]) ?? []
                let newDay      = Day(id: id, date: date, attendenc: attendenc)
                
                days.append(newDay)
            }
            compeletion(days)
        }
    }
    
    /// Delete Day
    func deleteDay(dayID: String){
        dayCollection.document(dayID).delete()
    }
    
    /// Switch Student State
    func switchStudentState(day: Day, studentId: String){
        
        let isStudentPresent = day.attendenc.contains(studentId)
        
        if isStudentPresent {
            let newPStudent = day.attendenc.filter { $0 != studentId }
        
            dayCollection.document(day.id).updateData([
                "attendence": newPStudent
            ])
        }else{
            var newPStudent = day.attendenc
            newPStudent.append(studentId)
            
            dayCollection.document(day.id).updateData([
                "attendence": newPStudent
            ])
        }
    }
    
    
    
    
}

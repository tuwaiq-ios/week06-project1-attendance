//
//  File9.swift
//  Attendance
//
//  Created by Fawaz on 08/11/2021.
//

import UIKit
import Firebase
import Foundation
import FirebaseFirestore

//==========================================================================
struct Day {
  var timestamp : Timestamp
  var pStudents : Array<String>
  var id : String
  //==========================================================================
  func getNiceDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    
    return dateFormatter.string(from: timestamp.dateValue())
  }
}
//==========================================================================
var Addnews : Array<Students> = []

struct Students {
  let name : String!
  var id : String
}
//==========================================================================

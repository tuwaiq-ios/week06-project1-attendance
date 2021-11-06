//
//  structs.swift
//  attended
//
//  Created by sara saud on 11/3/21.
//

import Foundation
import FirebaseFirestore

struct Student {
    var name: String
    var attendance: Bool
}

 struct Days {
    let name : String?
     var Date1 : Timestamp
    var id : Int?
   
//    let attendStudent : [Student]
}

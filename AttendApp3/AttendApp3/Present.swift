//
//  Present.swift
//  AttendApp3
//
//  Created by Ahmed Assiri on 04/04/1443 AH.
//

import Foundation
import UIKit


class PrsentPage: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    var dayId: String
    var day: Day?
    var students: Array<Students> = []
    
    init (dayId: String) {
        self.dayId = dayId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.dayId = ""
        super.init(coder: coder)
    }
    lazy var pStudentsLabel = UILabel()
    lazy var aStudentsLabel = UILabel()
    lazy var labelStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            pStudentsLabel, aStudentsLabel
        ])
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    
    let TV2 = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DaysService.shared.listenToDay(dayId: dayId) { newDay in
            self.day = newDay
            self.title = newDay?.getNiceDate()
            self.updateViews()
        }
        
        
        StudentsService.shared.listenToStudents { newStudents in
            self.students = newStudents
            self.updateViews()
        }
        
        view.backgroundColor = .white
        TV2.dataSource = self
        TV2.delegate = self
        TV2.register(Cell2.self, forCellReuseIdentifier: "cell")
        TV2.backgroundColor = .white
        TV2.rowHeight = 80
        TV2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(TV2)
        NSLayoutConstraint.activate([
            TV2.leftAnchor.constraint(equalTo: view.leftAnchor),
            TV2.rightAnchor.constraint(equalTo: view.rightAnchor),
            TV2.topAnchor.constraint(equalTo: view.topAnchor),
            TV2.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 500 )
        ])
        
        
        view.addSubview(labelStack)
        NSLayoutConstraint.activate([
            labelStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            labelStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            labelStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! Cell2
        
        let student = students[indexPath.row]
        cell.textLabel?.text = student.name
        
        let isStudentPresent = checkStudentPresent(studentId: student.id)
        if isStudentPresent {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = students[indexPath.row]
        
        DaysService.shared.switchStudentStatus(
            day: day!,
            studentId: student.id
        )
    }
    
//        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//            let student = students[indexPath.row]
//            if editingStyle == .delete {
//                students.remove(at: indexPath.row)
//                StudentsService.shared.deleteStudent(studentId: student.id)
//                deleteonestudent()
//                TV2.reloadData()
//            }
//        }
//
    func checkStudentPresent(studentId: String) -> Bool {
        return day?.pStudents.contains(studentId) ?? false
    }
    
    
//    func deleteonestudent() -> Int {
//       var a = day?.pStudents.count ??
//        return a-=1
//    }
    
    
    
    func getPStudentsCount() -> Int {
        return day?.pStudents.count ?? 0
    }
    
    func getAStudentsCount() -> Int {
        let pStudentsCount = getPStudentsCount()
        return students.count - pStudentsCount
    }
    
    func updateViews() {
        TV2.reloadData()
        pStudentsLabel.text = "P: \(getPStudentsCount())"
        aStudentsLabel.text = "A: \(getAStudentsCount())"
    }
    

    
}

class Cell2: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style , reuseIdentifier: reuseIdentifier )
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}



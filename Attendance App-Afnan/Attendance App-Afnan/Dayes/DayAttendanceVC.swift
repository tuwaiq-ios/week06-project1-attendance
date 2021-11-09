//
//  DayAttendanceVC.swift
//  Attendance App-Afnan
//
//  Created by Fno Khalid on 02/04/1443 AH.
//

import UIKit


class DayAttendanceVC: UIViewController {
    
    
    var dayId: String
    let cellId = "AttendanceCell"
    var day: Day?
    var students: Array<Student> = []
    
    init (dayId: String) {
        self.dayId = dayId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.dayId = ""
        super.init(coder: coder)
    }
    
    
    lazy var studentsTV: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return tv
    }()
    
    lazy var presentStudentsLabel = UILabel()
    
    lazy var absentStudentsLabel = UILabel()
    
    lazy var labelStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            presentStudentsLabel, absentStudentsLabel
        ])
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    

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
        
        view.backgroundColor = .yellow
        
        view.addSubview(studentsTV)
        view.addSubview(labelStack)
        
        
        NSLayoutConstraint.activate([
            studentsTV.topAnchor.constraint(equalTo: view.topAnchor),
            studentsTV.leftAnchor.constraint(equalTo: view.leftAnchor),
            studentsTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            studentsTV.bottomAnchor.constraint(equalTo: labelStack.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            labelStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            labelStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
    }
    
    func checkStudentPresent(studentId: String) -> Bool {
        return day?.presentStudent.contains(studentId) ?? false
    }
    
    func getPresentStudentsCount() -> Int {
        return day?.presentStudent.count ?? 0
    }
    
    func getAbsentStudentsCount() -> Int {
        let PresentStudentsCount = getPresentStudentsCount()
        return students.count - PresentStudentsCount
    }
    
    func updateViews() {
        studentsTV.reloadData()
        presentStudentsLabel.text = "P: \(getPresentStudentsCount())"
        absentStudentsLabel.text = "A: \(getAbsentStudentsCount())"
    }
}

extension DayAttendanceVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let student = students[indexPath.row]
        cell.textLabel?.text = student.name
        
        
        let isStudentPresent = checkStudentPresent(studentId: student.id)
        if isStudentPresent {
            cell.backgroundColor = .systemGreen
        }else {
            cell.backgroundColor = .systemRed
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        
        let cell = students[indexPath.row]
        
        let alertcontroller = UIAlertController(title: "Alert"
                                                , message: "Are you sure you want to delete all the tasks?"
                                                , preferredStyle: UIAlertController.Style.alert
        )
        
        alertcontroller.addAction(
            UIAlertAction(title: "cancel", style: UIAlertAction.Style.default, handler: { Action in print("...")
            })
            
        )
        
        alertcontroller.addAction(
            UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { Action in
                if editingStyle == .delete {
                    self.students.remove(at: indexPath.row)
                    self.studentsTV.deleteRows(at: [indexPath], with: .fade)
                }
                self.studentsTV.reloadData()
            })
            
        )
        
        
        self.present(alertcontroller, animated: true, completion: nil)
        
    }
    
}

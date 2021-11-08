//
//  NewDay.swift
//  attendance app
//
//  Created by Ahmed Assiri on 04/04/1443 AH.
//

import UIKit
import FirebaseFirestore


class NewDay: UIViewController {

    lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        dp.datePickerMode = .date
        return dp
    }()
    
    lazy var addDayBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemCyan
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        btn.setTitle("Add day", for: .normal)
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(addDay), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        view.addSubview(addDayBtn)
        NSLayoutConstraint.activate([
            addDayBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addDayBtn.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
            addDayBtn.heightAnchor.constraint(equalToConstant: 48),
            addDayBtn.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48)
        ])
    }
    
    @objc func dateChanged() {
        
        print("New date = \(datePicker.date)")
    }
    
    @objc func addDay() {
        let date = datePicker.date
        let uuid = UUID().uuidString
        
        DaysS.shared.addDay(
            day: Day(
                id: uuid,
                timestamp: Timestamp(date: date),
                pStudents: []
            )
        )
        
        dismiss(animated: true, completion: nil)
    }
} //end




class DayAttendanceVC: UIViewController {

    var dayId: String
    let cellId = "StudentAttendanceCell"
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
    lazy var pStudentsLabel = UILabel()
    lazy var aStudentsLabel = UILabel()
    lazy var labelStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            pStudentsLabel, aStudentsLabel
        ])
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DaysS.shared.listenToDay(dayId: dayId) { newDay in
            self.day = newDay
            self.title = newDay?.getNiceDate()
            self.updateViews()
        }
        
        StudentsService.shared.listenToStudents { newStudents in
            self.students = newStudents
            self.updateViews()
        }
        
        view.backgroundColor = .yellow
        
        view.addSubview(labelStack)
        NSLayoutConstraint.activate([
            labelStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            labelStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            labelStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])
        
        view.addSubview(studentsTV)
        NSLayoutConstraint.activate([
            studentsTV.topAnchor.constraint(equalTo: view.topAnchor),
            studentsTV.leftAnchor.constraint(equalTo: view.leftAnchor),
            studentsTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            studentsTV.bottomAnchor.constraint(equalTo: labelStack.topAnchor),
        ])
    }
    
    func checkStudentPresent(studentId: String) -> Bool {
        return day?.pStudents.contains(studentId) ?? false
    } //end
    
    func getPStudentsCount() -> Int {
        return day?.pStudents.count ?? 0
    } //end
    
    func getAStudentsCount() -> Int {
        let pStudentsCount = getPStudentsCount()
        return students.count - pStudentsCount
    } //end
    
    func updateViews() {
        studentsTV.reloadData()
        pStudentsLabel.text = "P: \(getPStudentsCount())"
        aStudentsLabel.text = "A: \(getAStudentsCount())"
    }//end
}


// تابعه للكلاس
extension DayAttendanceVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
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
        
        DaysS.shared.switchStudentStatus(
            day: day!,
            studentId: student.id
        )
    }
}


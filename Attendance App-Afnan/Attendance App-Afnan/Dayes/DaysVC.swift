//
//  DaysVC.swift
//  Attendance App-Afnan
//
//  Created by Fno Khalid on 02/04/1443 AH.
//

import UIKit

class DaysVC: UIViewController {
    
    
    
    var days: Array<Day> = []
    var studentCount = 0
    
    var daysTV: UITableView {
        let tableV = UITableView()
        tableV.translatesAutoresizingMaskIntoConstraints = false
        tableV.delegate = self
        tableV.dataSource = self
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: "dayCell")
        tableV.isHidden = false
        
        return tableV
    }
    
    lazy var addDayButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addDay), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .systemMint
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(daysTV)
        daysTV.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        daysTV.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        daysTV.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        daysTV.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
                view.addSubview(addDayButton)
                NSLayoutConstraint.activate([
                    addDayButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                    addDayButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
                    addDayButton.widthAnchor.constraint(equalToConstant: 100),
                    addDayButton.heightAnchor.constraint(equalToConstant: 100),
                ])
        
        DaysService.shared.listenToDays { newDays in
            self.days = newDays
            self.daysTV.reloadData()
        }
        StudentsService.shared.listenToStudentCount { newStudentCount in
            self.studentCount = newStudentCount
            self.daysTV.reloadData()
        }
    }
    
    @objc func addDay() {
        let newDayVC = NewDayVC()
        present(newDayVC, animated: true, completion: nil)
    }}


extension DaysVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "DayCell")
        
        let day = days[indexPath.row]
        let presentStudentCount = day.presentStudent.count
        let absentStudentCount = studentCount - presentStudentCount
        
        cell.textLabel?.text = day.getNiceDate()
        cell.detailTextLabel?.text = "P: \(presentStudentCount), A: \(absentStudentCount)"
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let day = days[indexPath.row]
        
        let navigationController = UINavigationController(
            rootViewController: DayAttendanceVC(dayId: day.id)
        )
        navigationController.navigationBar.prefersLargeTitles = true
        
        present(navigationController, animated: true, completion: nil)
    }
    
}

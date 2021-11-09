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
    
  lazy  var daysTV: UITableView = {
        let tableV = UITableView()
        tableV.translatesAutoresizingMaskIntoConstraints = false
        tableV.delegate = self
        tableV.dataSource = self
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: "dayCell")
        tableV.isHidden = false
        
        return tableV
    }()
    
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
        
        view.reloadInputViews()
        
        view.addSubview(daysTV)
        NSLayoutConstraint.activate([
            daysTV.leftAnchor.constraint(equalTo: view.leftAnchor),
            daysTV.topAnchor.constraint(equalTo: view.topAnchor),
            daysTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            daysTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
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
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "dayCell")
        
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
    
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//
//        let cell = days[indexPath.row]
//
//        let alertcontroller = UIAlertController(title: "Alert"
//                                                , message: "Are you sure you want to delete all the tasks?"
//                                                , preferredStyle: UIAlertController.Style.alert
//        )
//
//        alertcontroller.addAction(
//            UIAlertAction(title: "cancel", style: UIAlertAction.Style.default, handler: { Action in print("...")
//            })
//
//        )
//
//        alertcontroller.addAction(
//            UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { Action in
//                if editingStyle == .delete {
//                    self.days.remove(at: indexPath.row)
//                    self.daysTV.deleteRows(at: [indexPath], with: .fade)
//                }
//                self.daysTV.reloadData()
//            })
//
//        )
//
//
//        self.present(alertcontroller, animated: true, completion: nil)
//
//    }
    
}

//
//  DaysVC.swift
//  Attendance2
//
//  Created by Tsnim Alqahtani on 02/04/1443 AH.
//

import Foundation
import UIKit


class DaysVC: UIViewController {
    var days: Array<Day> = []
    var studentCount = 0
    
    lazy var daysTV: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "DayCell")
        return tv
    }()
    
    lazy var addDayButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(addDay), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Add", for: .normal)
        b.backgroundColor = .orange
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DaysService.shared.listenToDays { newDays in
            self.days = newDays
            self.daysTV.reloadData()
        }
        StudentsService.shared.listenToStudentCount { newStudentCount in
            self.studentCount = newStudentCount
            self.daysTV.reloadData()
        }
        
        tabBarItem = UITabBarItem(title: "Days", image: UIImage(systemName: "calendar"), selectedImage: nil)
        view.backgroundColor = .gray
        
        view.addSubview(daysTV)
        NSLayoutConstraint.activate([
            daysTV.topAnchor.constraint(equalTo: view.topAnchor),
            daysTV.leftAnchor.constraint(equalTo: view.leftAnchor),
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
    }
    
    @objc func addDay() {
        let newDayVC = NewDayVC()
        present(newDayVC, animated: true, completion: nil)
    }
}


extension DaysVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "DayCell")
        
        let day = days[indexPath.row]
        let pStudentCount = day.pStudents.count
        let aStudentCount = studentCount - pStudentCount
        
        cell.textLabel?.text = day.getNiceDate()
        cell.detailTextLabel?.text = "P: \(pStudentCount), A: \(aStudentCount)"
        
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

//
//  DaysViewController.swift
//  Students Attendance
//
//  Created by PC on 01/04/1443 AH.
//

import UIKit
import Firebase

class DaysViewController : UITableViewController, UIPickerViewDelegate {
    
    static var days = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.selectionFollowsFocus = false
        
        let addDayButton = UIBarButtonItem(image: UIImage(systemName: "plus.app.fill"), style: .plain, target: self, action: #selector(addNewDayAction))
        navigationItem.rightBarButtonItem = addDayButton
        
        getDays()
    }
    
    func getDays() {
        
        Firestore.firestore().collection("Days").addSnapshotListener { snapshot, error in
            DaysViewController.days.removeAll()
            if error == nil {
                for document in snapshot!.documents{
                    let data = document.documentID
                    DaysViewController.days.append(data)
                }
                self.tableView.reloadData()
                
            } else {
                print("ERROR")
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    @objc func addNewDayAction() {
        let vc = DatePickerViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DaysViewController.days.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = DaysViewController.days[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AttendanceViewController()
        vc.selectedDay = DaysViewController.days[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

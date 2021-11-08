//
// AttendanceScreen.swift
//  attendanccc
//
//  Created by sally asiri on 28/03/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AttendanceScreen: UIViewController {

    let daysButton = UIButton(type: .system)
    
    let studentsScreenButton = UIButton(type: .system)
    
    let addDataButton = UIButton(type: .system)
    
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let db = Firestore.firestore()
    
    var attendance: [AttendanceFinal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Attendance"
        
        view.backgroundColor = .systemGray6
        self.navigationItem.setHidesBackButton(true, animated: true)
       
        setupTableView()
        setupStackView()
        setupButton()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAttendance()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupStackView() {
        
        
        daysButton.setTitle("Days", for: .normal)
        daysButton.setTitleColor(.white, for: .normal)
        
        studentsScreenButton.setTitle("Student", for: .normal)
        studentsScreenButton.setTitleColor(.white, for: .normal)
        
        studentsScreenButton.addTarget(self, action: #selector(studentsButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [studentsScreenButton, daysButton])
        stackView.backgroundColor = .systemPink.withAlphaComponent(0.9)
        stackView.layer.cornerRadius = 20
        stackView.clipsToBounds = true
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    private func setupTableView() {
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.register(AttendanceCell.self, forCellReuseIdentifier: AttendanceCell.cellID)
        tableView.rowHeight = 50
        view.addSubview(tableView)
    }
    
    private func setupButton() {
        addDataButton.circularButton()
        
        addDataButton.translatesAutoresizingMaskIntoConstraints = false
        
        addDataButton.addTarget(self, action: #selector(addDateButtonTapped), for: .touchUpInside)
        
        view.addSubview(addDataButton)
        
        addDataButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        addDataButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        addDataButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        addDataButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
    }
    @objc private func studentsButtonTapped() {
        
        self.navigationController?.popViewController(animated: true)

        print("Go to Student")
    }
    
    @objc private func addDateButtonTapped() {
        print("add date")
        let vc = AddAttendanceScreen()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getAttendance() {
        guard let user = Auth.auth().currentUser else {print("no user was found~");return}
        db
            .collection("Attendance")
            .whereField("teacherID", isEqualTo: user.uid)
            .order(by: "date")
            .getDocuments { querySnapshot, error in
                
                self.attendance = []
                
                if let error = error {
                    print("There was an issue retrieving Students Information form FireStore. \(error)")
                }else{
                    
                    guard let snapshotDocuments = querySnapshot?.documents else { return }
                        for doc in snapshotDocuments {
                         
                            
                            if let attendance     = try? doc.data(as: AttendanceFinal.self)
                            {
                                
                                self.attendance.append(attendance)
                                
                                
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                                
                                
                            }else{
                                print("print error getting converting data from firebase")
                                return
                            }
                            
                            
                        }
                    
                    
                    
                }
                
                
                
            }
       
    }
    
}


extension AttendanceScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendance.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AttendanceCell.cellID, for: indexPath) as! AttendanceCell
        
        cell.dateLabel.text = attendance[indexPath.row].date
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = AttendanceDetailScreen()
        
        vc.barTitle = attendance[indexPath.row].date
        vc.students = attendance[indexPath.row].attendance
        vc.absentNumber = attendance[indexPath.row].absentNumber
        vc.presentNumber = attendance[indexPath.row].presentNumber
        
        vc.navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

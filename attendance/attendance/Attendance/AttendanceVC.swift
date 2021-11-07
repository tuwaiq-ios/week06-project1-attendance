//
//  SceneDelegate.swift
//  Aziz.AttendanceApp
//
//  Created by Abdulaziz on 28/03/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AttendanceVC: UIViewController {

    let daysBtn = UIButton(type: .system)
    let studentsScreenBtn = UIButton(type: .system)
    let addDataBtn = UIButton(type: .system)
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let db = Firestore.firestore()
    var attendance: [Attendances] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Attendance"
        view.backgroundColor = .systemBrown
//        self.navigationItem.setHidesBackButton(true, animated: true)
        tableView.backgroundColor = .systemBrown
       
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
        
        daysBtn.setTitle("Days", for: .normal)
        daysBtn.setTitleColor(.white, for: .normal)
        
        studentsScreenBtn.setTitle("Students", for: .normal)
        studentsScreenBtn.setTitleColor(.white, for: .normal)
        
        studentsScreenBtn.addTarget(self, action: #selector(studentsButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [studentsScreenBtn, daysBtn])
        stackView.backgroundColor = .blue.withAlphaComponent(0.9)
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
        
        addDataBtn.setTitle("➕", for: .normal)
        addDataBtn.backgroundColor = .systemTeal
        addDataBtn.layer.cornerRadius = 22.5
        addDataBtn.setTitleColor(.white, for: .normal)
        addDataBtn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping

        addDataBtn.translatesAutoresizingMaskIntoConstraints = false
        addDataBtn.addTarget(self, action: #selector(addDateBtnTapped), for: .touchUpInside)
        view.addSubview(addDataBtn)
        addDataBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        addDataBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        addDataBtn.widthAnchor.constraint(equalToConstant: 65).isActive = true
        addDataBtn.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }
    
    @objc private func studentsButtonTapped() {
        
        self.navigationController?.popViewController(animated: true)
        print("Go to Student")
    }
    
    @objc private func addDateBtnTapped() {
        print("add date")
        let vc = AddAttendance()
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
                            if let attendance     = try? doc.data(as: Attendances.self)
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

extension AttendanceVC: UITableViewDelegate, UITableViewDataSource {
    
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
        
//        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = AttendanceDetailVC()
        vc.barTitle = attendance[indexPath.row].date
        vc.students = attendance[indexPath.row].attendance
        vc.absentNum = attendance[indexPath.row].absentNum
        vc.presentNum = attendance[indexPath.row].presentNum
        
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

class AttendanceCell: UITableViewCell {

    static let cellID = "12345"
    
    let dateLabel: UILabel = {
        let dl = UILabel()
        dl.textColor = .black
        dl.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        return dl
    }()
    
    let presentLabel: UILabel = {
        let dl = UILabel()
        dl.textColor = .systemGreen
        dl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return dl
    }()
    
    let absentLabel: UILabel = {
        let dl = UILabel()
        dl.textColor = .systemRed
        dl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return dl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCellViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
//    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
//
    private func setUpCellViews() {
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        absentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(absentLabel)
        absentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        absentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        presentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(presentLabel)
        presentLabel.trailingAnchor.constraint(equalTo: absentLabel.leadingAnchor, constant: -20).isActive = true
        presentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}

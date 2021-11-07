//
//  SceneDelegate.swift
//  Aziz.AttendanceApp
//
//  Created by Abdulaziz on 28/03/1443 AH.
//

import UIKit

class AttendanceDetailVC: UIViewController {
    
    let presentNumbersLbl     = UILabel()
    let absentNumbersLbl      = UILabel()
    
    var barTitle = ""
    var presentNum = 0
    var absentNum = 0
    var students: [AttendanceList] = []
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = barTitle
        tableView.backgroundColor = .white
        setupTableView()
        setupLbls()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.height)
    }
    
    private func setupLbls() {
        presentNumbersLbl.setupLabel(with: .systemGreen)
        absentNumbersLbl.setupLabel(with: .systemRed)
        
        presentNumbersLbl.text = "☑️: \(presentNum)"
        absentNumbersLbl.text = "✖️: \(absentNum)"
        
        let stackView = UIStackView(arrangedSubviews: [presentNumbersLbl, absentNumbersLbl])
    
        stackView.distribution = .equalCentering
        stackView.backgroundColor = .systemGray6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
    
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        view.addSubview(stackView)
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(AttendanceDetailCell.self, forCellReuseIdentifier: AttendanceDetailCell.cellID)
        view.addSubview(tableView)
        
    }
}

extension AttendanceDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AttendanceDetailCell.cellID, for: indexPath) as! AttendanceDetailCell
        
        cell.name.text = students[indexPath.row].name
        cell.presentOrAbsent.text = students[indexPath.row].isPresent ? "☑️" : "✖️"
        cell.isUserInteractionEnabled = false
        
        return cell
    }
}

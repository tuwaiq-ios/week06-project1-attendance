//
//  AppDelegate.swift
//  AttendanceApp
//
//  Created by HANAN on 28/03/1443 AH.
//

import UIKit

class AttendanceDetailScreen: UIViewController {
    
    let presentNumbersLabel     = UILabel()
    let absentNumbersLabel      = UILabel()
    var barTitle = ""
    var presentNumber = 0
    var absentNumber = 0
    var students: [AttendanceListModel] = []
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray6
        title = barTitle
        setupTableView()
        setupLabels()}
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = CGRect(x: 5, y: 120, width: view.frame.size.width, height: view.frame.size.height)}
    
    private func setupLabels() {
        presentNumbersLabel.setupLabel(with: .systemGreen)
        absentNumbersLabel.setupLabel(with: .systemRed)
        presentNumbersLabel.text = "P: \(presentNumber)"
        absentNumbersLabel.text = "A: \(absentNumber)"
        let stackView = UIStackView(arrangedSubviews: [presentNumbersLabel, absentNumbersLabel])
        stackView.distribution = .equalCentering
        stackView.backgroundColor = .systemGray6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive                   = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive       = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive          = true
        stackView.heightAnchor.constraint(equalToConstant: 20).isActive                                 = true
        view.addSubview(stackView)}
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(AttendanceDetailCell.self, forCellReuseIdentifier: AttendanceDetailCell.cellID)
        view.addSubview(tableView)}}

extension AttendanceDetailScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AttendanceDetailCell.cellID, for: indexPath) as! AttendanceDetailCell
        cell.name.text              = students[indexPath.row].name
        cell.presentOrAbsent.text   = students[indexPath.row].isPresent ? "P" : "A"
        cell.isUserInteractionEnabled = false
        return cell}}



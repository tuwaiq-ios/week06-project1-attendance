//
//  AppDelegate.swift
//  AttendanceApp
//
//  Created by HANAN on 28/03/1443 AH.
//

import UIKit

class AttendanceDetailCell: UITableViewCell {
    
    static let cellID = "AttendanceDetailCell"
    
    let name: UILabel = {
        let dl = UILabel()
        dl.textColor = .black
        dl.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        return dl
    }()
    let presentOrAbsent: UILabel = {
        let dl = UILabel()
        dl.textColor = .black
        dl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return dl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCellViews()}
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    private func setUpCellViews() {
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 6).isActive = true
        presentOrAbsent.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(presentOrAbsent)
        presentOrAbsent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        presentOrAbsent.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true}}


//
//  AttendanceCell.swift
//  AttendanceApp
//
//  Created by fatimah  on 30/03/1443 AH.
//

import UIKit

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
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    private func setUpCellViews() {
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        absentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(absentLabel)
        absentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        absentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        presentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(presentLabel)
        presentLabel.trailingAnchor.constraint(equalTo: absentLabel.leadingAnchor, constant: -20).isActive = true
        presentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true }}


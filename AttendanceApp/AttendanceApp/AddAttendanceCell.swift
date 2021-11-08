//
//  AppDelegate.swift
//  AttendanceApp
//
//  Created by HANAN on 28/03/1443 AH.
//
import UIKit

class AddAttendanceCell: UITableViewCell {
    
    
    static let cellID = "AddAttendanceCell"
    
    let name: UILabel = {
        let dl = UILabel()
        dl.textColor = .black
        dl.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        return dl
    }()
    
    let isPresent: UILabel = {
        let dl = UILabel()
        dl.textColor = .black
        dl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return dl
    }()
    
    let details: UILabel = {
        let dl = UILabel()
        dl.textColor = .systemGray2
        dl.text = "change status".uppercased()
        dl.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        dl.numberOfLines = 0
        dl.textAlignment = .left
        return dl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCellViews()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    private func setUpCellViews() {
        
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10).isActive = true
        details.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(details)
        details.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
        details.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        details.widthAnchor.constraint(equalToConstant: 280).isActive = true
        isPresent.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(isPresent)
        isPresent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        isPresent.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
}

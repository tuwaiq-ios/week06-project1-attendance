//
//  StudentCollectionViewCell.swift
//  Attendance
//
//  Created by Eth Os on 01/04/1443 AH.
//

import UIKit

class StudentCollectionViewCell: UICollectionViewCell {
    
    let studentNameLabel    = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius     = 15.0
        self.contentView.layer.borderWidth      = 2.0
        self.contentView.layer.borderColor      = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds    = true
        self.contentView.backgroundColor        = .white
        self.layer.shadowColor                  = UIColor.lightGray.cgColor
        self.layer.shadowOffset                 = CGSize(width: 0, height: 3.5)
        self.layer.shadowRadius                 = 3.0
        self.layer.shadowOpacity                = 0.2
        self.layer.masksToBounds                = false
        self.layer.cornerRadius                 = 2
        self.layer.shadowPath                   = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        studentNameLabel.text   = "test test"
        studentNameLabel.font   = .boldSystemFont(ofSize: 15)
        
        studentNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(studentNameLabel)
        NSLayoutConstraint.activate([
            studentNameLabel.topAnchor.constraint(equalTo: topAnchor),
            studentNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            studentNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            studentNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

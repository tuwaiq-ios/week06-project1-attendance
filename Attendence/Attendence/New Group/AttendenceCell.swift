//
//  AttendenceCell.swift
//  Attendence
//
//  Created by sara al zhrani on 30/03/1443 AH.
//

import UIKit
//import FirebaseFirestore



class AttendenceCell: UICollectionViewCell {
    
    
    static let identifier = "AttendenceCell"
    
    let namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.text = ""
        namelabel.textColor = .white
        namelabel.font = namelabel.font.withSize(25)
        namelabel.translatesAutoresizingMaskIntoConstraints = false
        return namelabel
    }()

    var attendancelabel: UILabel = {
        var attendancelabel = UILabel()
        attendancelabel.text = ""
        attendancelabel.textColor = .white
        attendancelabel.frame.origin.x = 10
        attendancelabel.frame.origin.y = 10

        attendancelabel.font = attendancelabel.font.withSize(20)
        attendancelabel.translatesAutoresizingMaskIntoConstraints = false
        return attendancelabel
    }()
    
    let absencelabel: UILabel = {
        let absencelabel = UILabel()
        absencelabel.text = ""
        absencelabel.textColor = .white
        absencelabel.font = absencelabel.font.withSize(20)
        absencelabel.translatesAutoresizingMaskIntoConstraints = false
        return absencelabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    self.backgroundColor = .systemCyan
    self.addSubview(namelabel)
    self.addSubview(attendancelabel)
    self.addSubview(absencelabel)
        
        namelabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        namelabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        namelabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        namelabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
     attendancelabel.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
    attendancelabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 35).isActive = true
    attendancelabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 270).isActive = true
    attendancelabel.trailingAnchor.constraint(equalTo:self.trailingAnchor).isActive = true
        
        
    absencelabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    absencelabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 35).isActive = true
    absencelabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 350).isActive = true
     absencelabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        
        
        
        self.layer.cornerRadius = 25.0
        self.layer.borderWidth = 25
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 25
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

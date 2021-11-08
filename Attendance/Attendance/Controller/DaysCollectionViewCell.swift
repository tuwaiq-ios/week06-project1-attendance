//
//  DaysCollectionViewCell.swift
//  Attendance
//
//  Created by Eth Os on 28/03/1443 AH.
//

import UIKit

class DaysCollectionViewCell: UICollectionViewCell {
    
    let dayNameLabel    = UILabel()
    let aLabel          = UILabel()
    let pLabel          = UILabel()

    
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
        
      
        dayNameLabel.font                       = .boldSystemFont(ofSize: 15)
        
        dayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(dayNameLabel)
        NSLayoutConstraint.activate([
            dayNameLabel.topAnchor.constraint(equalTo: topAnchor),
            dayNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            dayNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            dayNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        aLabel.textColor        = UIColor(red: 212.0/225.0, green: 38.0/225.0, blue: 28.0/225.0, alpha: 1.0)
        aLabel.font             = .boldSystemFont(ofSize: 18)
        
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(aLabel)
        NSLayoutConstraint.activate([
            aLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            aLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -30)
        ])
        
        pLabel.textColor        = UIColor(red: 120.0/225.0, green: 148.0/225.0, blue: 234.0/225.0, alpha: 1.0)
        pLabel.font             = .boldSystemFont(ofSize: 18)
        
        pLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(pLabel)
        NSLayoutConstraint.activate([
            pLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            pLabel.rightAnchor.constraint(equalTo: aLabel.leftAnchor, constant: -15)
        ])

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

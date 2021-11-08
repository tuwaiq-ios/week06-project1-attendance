//
//  DayCell.swift
//  Attendence
//
//  Created by sara al zhrani on 28/03/1443 AH.
//

import UIKit
class CustomCell: UICollectionViewCell {

    static let identifier = "CustomCell"
    


    let label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = label.font.withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let attendancelabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let absencelabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .systemCyan

        self.addSubview(label)
        self.addSubview(attendancelabel)
        self.addSubview(absencelabel)
             
        

    label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    label.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    
        
        
     attendancelabel.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
    attendancelabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 35).isActive = true
    attendancelabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 250).isActive = true
    attendancelabel.trailingAnchor.constraint(equalTo:self.trailingAnchor).isActive = true
        
        
        
    absencelabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    absencelabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 35).isActive = true
    absencelabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 300).isActive = true
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

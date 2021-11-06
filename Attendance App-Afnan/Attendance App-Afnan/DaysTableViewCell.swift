//
//  DaysTableViewCell.swift
//  Attendance App-Afnan
//
//  Created by Fno Khalid on 29/03/1443 AH.


import UIKit

class DaysTableViewCell: UITableViewCell {
    
    static let identifier = "Cell"
    
    var dateFormatter: DateFormatter = DateFormatter()
    
    
    var dayLabel: UILabel = {
        let dayname = UILabel()
        dayname.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        dayname.textColor = .black
        dayname.textAlignment = .left
        dayname.tintColor = .purple
        dayname.translatesAutoresizingMaskIntoConstraints = false
        return dayname
    }()

    var PresentLabel: UILabel = {
        let present = UILabel()
        present.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        present.textColor = .black
        present.textAlignment = .left
        present.tintColor = .purple
        present.translatesAutoresizingMaskIntoConstraints = false
        return present
    }()

    var AbsentLabel: UILabel = {
        let absent = UILabel()
        absent.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        absent.textColor = .black
        absent.textAlignment = .left
        absent.tintColor = .purple
        absent.translatesAutoresizingMaskIntoConstraints = false
        return absent
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(dayLabel)
        contentView.addSubview(PresentLabel)
        contentView.addSubview(AbsentLabel)

       // contentView.backgroundColor = .white
        contentView.backgroundColor = UIColor(red: (205/255), green: (195/255), blue: (212/255), alpha: 1)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dayLabel.font = .boldSystemFont(ofSize: 15)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    dayLabel.topAnchor.constraint(equalTo: topAnchor),
                    dayLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
                    dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                    dayLabel.heightAnchor.constraint(equalToConstant: 20)
                ])
        
             PresentLabel.text = "\(attendedStudents.count)"
               PresentLabel.textColor = UIColor(red: 120.0/225.0, green: 148.0/225.0, blue: 234.0/225.0, alpha: 1.0)
               PresentLabel.font = .boldSystemFont(ofSize: 18)
               PresentLabel.translatesAutoresizingMaskIntoConstraints = false

               NSLayoutConstraint.activate([
                   PresentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                   PresentLabel.rightAnchor.constraint(equalTo: PresentLabel.leftAnchor, constant: -15)
               ])
        
            //  AbsentLabel.text = "\(students.count)"
                 AbsentLabel.textColor = UIColor(red: 212.0/225.0, green: 38.0/225.0, blue: 28.0/225.0, alpha: 1.0)
                 AbsentLabel.font = .boldSystemFont(ofSize: 18)
                 AbsentLabel.translatesAutoresizingMaskIntoConstraints = false
                 NSLayoutConstraint.activate([
                     AbsentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                     AbsentLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -30)
                 ])

    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    }




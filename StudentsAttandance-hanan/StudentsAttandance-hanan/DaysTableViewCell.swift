//
//  DaysTableViewCell.swift
//  StudentsAttandance-hanan
//
//  Created by  HANAN ASIRI on 29/03/1443 AH.
//

import UIKit

class DaysCell: UITableViewCell {

    static let identefier = "DaysCell"
  var dateFormatter: DateFormatter = DateFormatter()

    let studentlable: UILabel = {
        let studentlable = UILabel()
        studentlable.text = ""
        studentlable.font = UIFont.systemFont(ofSize: 30)
        studentlable.translatesAutoresizingMaskIntoConstraints = false
        studentlable.textColor = .purple
        studentlable.backgroundColor = .black
        return studentlable
    }()

    var attandancelable: UILabel = {
        let attandancelable = UILabel()
        attandancelable.text = ""
        attandancelable.font = UIFont.systemFont(ofSize: 30)
        attandancelable.translatesAutoresizingMaskIntoConstraints = false
        attandancelable.textColor = .purple
        return attandancelable
    }()

    let absentlable: UILabel = {
    let absentlable = UILabel()
    absentlable.font = UIFont.systemFont(ofSize: 30)
    absentlable.translatesAutoresizingMaskIntoConstraints = false
    absentlable.backgroundColor = UIColor.cyan
    absentlable.textColor = .brown
    absentlable.textAlignment = .left
        return absentlable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
   //override func awakeFromNib() {
        //super.awakeFromNib()
        //self.backgroundColor = .blue
        self.addSubview(studentlable)
        self.addSubview(attandancelable)
        self.addSubview(absentlable)

        // Initialization code

        studentlable.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        studentlable.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        studentlable.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        studentlable.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true


        attandancelable.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        attandancelable.topAnchor.constraint(equalTo: self.topAnchor,constant: 38).isActive = true
        attandancelable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 270).isActive = true
        attandancelable.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true


        absentlable.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        absentlable.topAnchor.constraint(equalTo: self.topAnchor,constant: 38).isActive = true
        absentlable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 350).isActive = true
        absentlable.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

    }
  required init?(coder: NSCoder) {
  fatalError("init(coder:) has not been implemented")
}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

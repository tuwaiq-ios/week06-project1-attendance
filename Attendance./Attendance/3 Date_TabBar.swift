//
//  File2.swift
//  Attendance
//
//  Created by Fawaz on 08/11/2021.
//

import UIKit
//==========================================================================
class Date_TabBar: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var todayday : Array<Day> = []
  var studentCount = 0
  let TV = UITableView()
  let BtnAdd = UIButton()
  //==========================================================================
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return todayday.count
  }
  //==========================================================================
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
    
    let day =  todayday[indexPath.row]
    let pStudentCount = day.pStudents.count
    let aStudentCount = studentCount - pStudentCount
    
    cell.textLabel?.text = day.getNiceDate()
    cell.detailTextLabel?.text = "P: \(pStudentCount), A: \(aStudentCount)"
    
    return cell
  }
  //==========================================================================
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    
    let day = todayday[indexPath.row]
    
    let navigationController = UINavigationController(
      rootViewController: PrsentPage(dayId: day.id)
    )
    navigationController.navigationBar.prefersLargeTitles = true
    
    present(navigationController, animated: true, completion: nil)
  }
  //==========================================================================
  override func viewDidLoad() {
    super.viewDidLoad()
    
    DaysService.shared.listenToDays { newDays in
      self.todayday = newDays
      self.TV.reloadData()
    }
    StudentsService.shared.listenToStudentCount { newStudentCount in
      self.studentCount = newStudentCount
      self.TV.reloadData()
    }
    
    TV.delegate = self
    TV.dataSource = self
    
    view.addSubview(TV)
    TV.translatesAutoresizingMaskIntoConstraints = false
    TV.register(CellDays.self, forCellReuseIdentifier: "cell")
    
    NSLayoutConstraint.activate([
      TV.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
      TV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
      TV.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      TV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
    ])
    
    view.addSubview(BtnAdd)
    BtnAdd.translatesAutoresizingMaskIntoConstraints = false
    
    BtnAdd.backgroundColor = .systemBlue
    BtnAdd.setTitle("Add Day", for: .normal)
    BtnAdd.addTarget(self,
                     action: #selector(buttonAction),
                     for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      BtnAdd.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      BtnAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
      
      BtnAdd.heightAnchor.constraint(equalToConstant: 50),
      BtnAdd.widthAnchor.constraint(equalToConstant: 300)
    ])
  }
  //==========================================================================
  @objc func buttonAction(sender: UIButton!) {
    
    let secondController = DatePage()
    secondController.callbackClosure = { [weak self] in
      
      self?.TV.reloadData()
    }
    present(secondController, animated: true, completion: nil)
  }
  //==========================================================================
} // class end
//==========================================================================

class CellDays: UITableViewCell {
  
  let Label8 = UILabel()
  //==========================================================================
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
    
    super.init(style: style , reuseIdentifier: reuseIdentifier )
  }
  //==========================================================================
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  //==========================================================================
} //end class cell

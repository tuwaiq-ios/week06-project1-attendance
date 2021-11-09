//
//  File3.swift
//  Attendance
//
//  Created by Fawaz on 08/11/2021.
//

import UIKit
import FirebaseFirestore
import Firebase
//==========================================================================
class Student_TabBar: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  let BtnAdd = UIButton()
  let TV1 = UITableView()
  var Addnews : Array<Students> = []
  //==========================================================================
  func tableView_func(){
    
    view.addSubview(TV1)
    TV1.translatesAutoresizingMaskIntoConstraints = false

    TV1.register(Cell.self, forCellReuseIdentifier: "cell")
    TV1.backgroundColor = .white
    TV1.rowHeight = 80
    
    NSLayoutConstraint.activate([
      TV1.leftAnchor.constraint(equalTo: view.leftAnchor),
      TV1.rightAnchor.constraint(equalTo: view.rightAnchor),
      TV1.topAnchor.constraint(equalTo: view.topAnchor),
      TV1.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 500 )
    ])
  }
  //==========================================================================
  func BtnAdd_func(){
    
    view.addSubview(BtnAdd)
    BtnAdd.translatesAutoresizingMaskIntoConstraints = false
    
    BtnAdd.backgroundColor = .orange
    BtnAdd.setTitle("Add Student ", for: .normal)
    
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView_func()
    BtnAdd_func()
    
    StudentsService.shared.listenToStudents { newStudents in
      self.Addnews = newStudents
      self.TV1.reloadData()
    }
    
    TV1.dataSource = self
    TV1.delegate = self
    
  }
  //==========================================================================
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Addnews.count
  }
  //==========================================================================
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let contact = Addnews[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    as! Cell
    cell.textLabel?.text = "\(contact.name!)"
    
    return cell
  }
  //==========================================================================
  @objc func buttonAction(sender: UIButton!) {
    
    let secondController = AddStudent()

    present(secondController, animated: true, completion: nil)
    
  }
  //==========================================================================
} //end class
//============================================================================
class Cell: UITableViewCell {
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
    super.init(style: style , reuseIdentifier: reuseIdentifier )
  }
  //==========================================================================
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  //==========================================================================
} //class end Cell

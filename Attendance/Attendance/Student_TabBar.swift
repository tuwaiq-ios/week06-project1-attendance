//
//  Attendance
//
//  Created by Fawaz on 06/11/2021.
//

import UIKit

import FirebaseFirestore
import Firebase

//==========================================================================
struct ContactsData {
  var nameContact: String
}
var Addn : Array<Students> = []

//============================================================================
class Student_TabBar: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  let BtnAdd = UIButton()
  var tabelView = UITableView()

  //==========================================================================
  func tableView_func(){
    
    view.addSubview(tabelView)
    tabelView.translatesAutoresizingMaskIntoConstraints = false
    
    tabelView.register(Cell.self, forCellReuseIdentifier: "cell")
    tabelView.backgroundColor = .white
    tabelView.rowHeight = 80
    
    NSLayoutConstraint.activate([
      tabelView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tabelView.rightAnchor.constraint(equalTo: view.rightAnchor),
      tabelView.topAnchor.constraint(equalTo: view.topAnchor),
      tabelView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 500 )
    ])
  }
  //==========================================================================
  func BtnAdd_func(){
    
    view.addSubview(BtnAdd)
    BtnAdd.translatesAutoresizingMaskIntoConstraints = false
    
    BtnAdd.backgroundColor = .orange
    BtnAdd.setTitle("Add Student ", for: .normal)
    
    BtnAdd.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

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
    
    tabelView.dataSource = self
    tabelView.delegate = self
    
    tableView_func()
    BtnAdd_func()
    
    Firestore
      .firestore().collection("students").addSnapshotListener {
      
        snapshot,error in if error != nil {
          print (error)
          return
      }
    for document in snapshot!.documents{
        
      let data = document.data()
      Addn.append(Students(name: data["name"] as! String))
      }
    }
    self.tabelView.reloadData()
  }
  //==========================================================================
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Addn.count
  }
  //==========================================================================
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let contact = Addn[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                             for: indexPath) as! Cell
    cell.namecell.text = "\(contact.name)"
    
    return cell
  }
  //==========================================================================
  @objc func buttonAction(sender: UIButton!) {
    
    let secondController = StudentPage()
    secondController.callbackClosure = { [weak self] in
      
      self?.tabelView.reloadData()
    }
    present(secondController, animated: true, completion: nil)
  }
} //class end

//============================================================================
//============================================================================
class Cell: UITableViewCell {
  
  let namecell = UITextField()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
    super.init(style: style , reuseIdentifier: reuseIdentifier )
    
    self.addSubview(namecell)
    namecell.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      namecell.centerYAnchor.constraint(equalTo: centerYAnchor),
      namecell.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  //==========================================================================

} //class cell end

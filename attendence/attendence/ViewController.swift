//
//  AppDelegate.swift
//  attendence
//
//  Created by Amal on 28/03/1443 AH.
//

import UIKit
import FirebaseFirestore
class Task: NSObject {

    var title: String
    var deadline: String
    var done: Bool

    init(title:String, deadline:String,done:Bool) {
        self.title = title
        self.deadline = deadline
        self.done =  done
    }
}
class List: NSObject {

    var name: String
    var tasks: [Task]

    init(name:String, tasks: [Task]) {
        self.name = name
        self.tasks = tasks
    }
}
class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var data = [List]()
    let tabelView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tabelView)
   
        tabelView.dataSource = self
        tabelView.delegate = self
        
        tabelView.register(Cell1.self, forCellReuseIdentifier: Cell1.identifire)
        tabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tabelView.leftAnchor.constraint(equalTo: view.leftAnchor),
        tabelView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     tabelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
        tabelView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                      ])
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete All", style: .done, target: self, action: #selector(deleteAll))
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Student", style: .done, target: self, action: #selector(tapToAdd))

        
        
        self.title="Students"
        tabelView.delegate = self
        tabelView.dataSource = self
      }
      class Cell: UITableViewCell {
      }
    
    @objc func deleteAll(){
      data.removeAll()
      tabelView.reloadData()
    }
   @objc func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
   {
 
      let shareAction = UITableViewRowAction(style: .default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
      let deleteMenu = UIAlertController(title: nil, message: "Are you sure you want to delete this student", preferredStyle: .actionSheet)
            
      let deleteAction = UIAlertAction(title: "Delete", style: .destructive){ (alertAction) in
          self.data.remove(at: indexPath.row)
          Firestore.firestore().document("students/2").delete()
          tableView.reloadData()
      }

      
              let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
              
          deleteMenu.addAction(deleteAction)
          deleteMenu.addAction(cancelAction)
              
      self.present(deleteMenu, animated: true, completion: nil)
      })
   
      return [shareAction]
  }
    @objc func tapToAdd(){

        let alert = UIAlertController(title: "New student", message: "Input the name here", preferredStyle: .alert )
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            guard  let text = textField.text, !text.isEmpty else {
                       return
                   }
            Firestore.firestore().document("students/2").setData(["name": "name","attendance":true ,"id":87])
            
            self.data.append(List(name: textField.text!, tasks: []))
            self.tabelView.reloadData()
        }

        alert.addTextField { (textField) in
            textField.placeholder = "the name...!"
            textField.textColor = .purple
        }
        alert.addAction(save)
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        alert.addAction(cancel)
        self.present(alert, animated:true, completion: nil)

    }

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return data.count
}
    
    
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell1 = data[indexPath.row]
  let cell = tableView.dequeueReusableCell(withIdentifier: Cell1.identifire, for: indexPath) as! Cell1
    cell.label2.text = data[indexPath.row].name
  return cell
}
}
class Cell1: UITableViewCell {
    
    static let identifire = "cell"

 public let label2: UILabel = {
      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
      label.textColor = .black
      return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(label2)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()


        label2.frame = CGRect(x: 5,
                              y: 5,
                              width: 260,
                              height: contentView.frame.size.height-10)

    }

}




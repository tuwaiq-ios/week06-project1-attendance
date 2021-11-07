//
//  File.swift
//  Attendess2
//
//  Created by  m-alqahtani on 29/03/1443 AH.
//






import UIKit

class StudentList: NSObject {

    var name: String

    init(name:String) {
        self.name = name
    
    }
}

class StudentPage: UIViewController, UITableViewDelegate,UITableViewDataSource {
   
    var data = [StudentList]()
    
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
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add 🧑🏼‍💻", style: .done, target: self, action: #selector(tapToAdd))

        
        
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

        let alert = UIAlertController(title: "New Student", message: "Write the name of student", preferredStyle: .alert )
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            guard  let text = textField.text, !text.isEmpty else {
                       return
                   }
            self.data.append(StudentList(name: textField.text!))
            self.tabelView.reloadData()
        }

        alert.addTextField { (textField) in
            textField.placeholder = "Student name"
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




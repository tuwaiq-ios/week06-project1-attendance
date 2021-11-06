
//
//  AppDelegate.swift
//  attendence
//
//  Created by Amal on 28/03/1443 AH.
//
import UIKit

class Tas: NSObject {

    var title: String
    var deadline: String
    var done: Bool

    init(title:String, deadline:String,done:Bool) {
        self.title = title
        self.deadline = deadline
        self.done =  done
    }
}
class Lis: NSObject {

    var name: String
    var date: String
    var tasks: [Tas]

    init(name:String, date:String,  tasks: [Tas]) {
        self.name = name
        self.date = date
        self.tasks = tasks
    }
}

var data = [Lis]()
class EntryViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var t1:List?
    
    let label1: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black

        return label
      }()

    var dateFormatter: DateFormatter = DateFormatter()
 
    var data = [Lis]()
    
    let tabelView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        view.addSubview(tabelView)
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.register(Cell.self, forCellReuseIdentifier: Cell.identifire)
        tabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tabelView.leftAnchor.constraint(equalTo: view.leftAnchor),
        tabelView.rightAnchor.constraint(equalTo: view.rightAnchor),
        tabelView.topAnchor.constraint(equalTo: view.topAnchor),
        tabelView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                      ])

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete All", style: .done, target: self, action: #selector(deleteAll))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Day", style: .done, target: self, action: #selector(tapToAdd))

        self.title="Days "
        tabelView.delegate = self
        tabelView.dataSource = self
        view.addSubview(label1)
        tabelView.reloadData()
      }

    @objc func deleteAll(){
      data.removeAll()
      tabelView.reloadData()
    }
   @objc func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
   {
 
      let shareAction = UITableViewRowAction(style: .default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
      let deleteMenu = UIAlertController(title: nil, message: "Are you sure you want to delete this task using", preferredStyle: .actionSheet)
              
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

        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        let myDatePicker: UIDatePicker = UIDatePicker()
        
        myDatePicker.timeZone = .autoupdatingCurrent
        
            myDatePicker.preferredDatePickerStyle = .wheels
            myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
            let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
            alertController.view.addSubview(myDatePicker)
        
            let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
             
                let selectDate: String = self.dateFormatter.string(from: myDatePicker.date)
                
                let day = Lis(name: " ", date: selectDate, tasks: [])
                
                    self.data.append(day)
                
                     print(self.data)
                     print("Selected Date: \(myDatePicker.date)")
                 self.tabelView.reloadData()
              
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(selectAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)

    }

    var abss = students.filter({ Student in !Student.attendance}).count
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return data.count

}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    
  let cell1 = data[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifire, for: indexPath) as! Cell

    cell.label2.text = data[indexPath.row].date
    cell.label3.text = "\(c1)"
    cell.label4.text = "\(c2)"
  return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Unhighlights what you have selected
        tableView.deselectRow(at: indexPath, animated: true)
        let dmScreen = threeVC()
//        dmScreen.dayl = students[indexPath.row].dayl
        dmScreen.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(dmScreen, animated: true)
      }
}
  class Cell: UITableViewCell {
      
      static let identifire = "cell"
  
   public let label2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
      }()
      public let label3: UILabel = {
           let label = UILabel()
           label.text = "a"
           label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
           label.textColor = .black
   //
           return label
         }()
      
      public let label4: UILabel = {
           let label = UILabel()
           label.text = "b"
          label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
           label.textColor = .black

           return label
         }()
      override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          contentView.backgroundColor = .white
          contentView.addSubview(label2)
          contentView.addSubview(label3)
          contentView.addSubview(label4)
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
          label3.frame = CGRect(x: 340,
                                y: 5,
                                width: 70,
                                height: contentView.frame.size.height-10)
          
          label4.frame = CGRect(x: 380,
                                y: 5,
                                width: 70,
                                height: contentView.frame.size.height-10)
          
      }
  
  }

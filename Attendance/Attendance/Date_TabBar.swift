//
//  Attendance
//
//  Created by Fawaz on 06/11/2021.
//

import UIKit


class Date_TabBar: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let TableV = UITableView()
  let BtnAdd = UIButton()
  
  //==========================================================================
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return dateP.count
  }
  //==========================================================================
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier:"cell",
                                             for: indexPath) as! CellDays
    
    let listdays = dateP[indexPath.row]
    
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    
    cell.Label8.text = formatter.string(from: listdays.date)
    
    return cell
  }
  //==========================================================================
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    
    let dd = dateP[indexPath.row]
    
    self.present(PrsentPage(), animated: true, completion: nil)
  }
  //==========================================================================
  override func viewDidLoad() {
    super.viewDidLoad()

    TableV.delegate = self
    TableV.dataSource = self
    
    view.addSubview(TableV)
    TableV.translatesAutoresizingMaskIntoConstraints = false
    
    TableV.register(CellDays.self, forCellReuseIdentifier: "cell")
    
    NSLayoutConstraint.activate([
      TableV.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
      TableV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
      TableV.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      TableV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
    ])
    view.addSubview(BtnAdd)
    BtnAdd.translatesAutoresizingMaskIntoConstraints = false
    
    BtnAdd.backgroundColor = .systemBlue
    BtnAdd.setTitle("Add Day", for: .normal)
    
    BtnAdd.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    
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
    
    secondController.callbackClosure = {
      [weak self] in self?.TableV.reloadData()
    }
    present(secondController, animated: true, completion: nil)
  }
} //class end
//============================================================================
//============================================================================
class CellDays: UITableViewCell {
  
  let Label8 = UILabel()
  
  override init(style: UITableViewCell.CellStyle,
                reuseIdentifier: String?){
    
    super.init(style: style, reuseIdentifier: reuseIdentifier )
    
    
    self.addSubview(Label8)
    Label8.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      Label8.centerYAnchor.constraint(equalTo: centerYAnchor),
      Label8.centerXAnchor.constraint(equalTo: centerXAnchor)])
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  //==========================================================================

} //class cell end

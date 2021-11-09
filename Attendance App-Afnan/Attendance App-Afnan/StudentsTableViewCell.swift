////
////  StudentsTableViewCell.swift
////  Attendance App-Afnan
////
////  Created by Fno Khalid on 28/03/1443 AH.
////
//
//import UIKit
//
//
//protocol checkButtondelgate{
//
//    func checkTaskTapped(at indexpath: IndexPath )
//}
//
//class StudentsTableViewCell: UITableViewCell, UITextFieldDelegate {
//
//    var ST = [Students]()
//
//
//    var delgate: checkButtondelgate!
//    var indexpath = IndexPath()
//
//    var tableviewcell: UITableView = UITableView()
//
//    let button: UIButton = UIButton()
//
//   // var nameTextField: UITextField = UITextField()
//
////    var nameLabel: UILabel = UILabel()
////    var name = UILabel(
////        name.frame(CGRect(x: <#T##Double#>, y: <#T##Double#>, width: <#T##Double#>, height: <#T##Double#>))
////    )
//
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
////        button.frame = CGRect(x: 65, y: 150, width: 50, height: 50)
////        nameTextField.delegate = self
//////        nameTextField.frame = CGRect(x: 55, y: 150, width: 300, height: 40)
////        nameTextField.backgroundColor = UIColor.lightGray
//
//
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//    func buttoncell(_ sender: Any) {
//
//        delgate.checkTaskTapped(at: indexpath)
//}
//
////    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
////        let update = Students(name: nameTextField.text!, attendance: ST[indexpath.row].attendance)
////             ST[indexpath.row] = update
////              nameTextField.resignFirstResponder()
////                return true
////
////    }
//
//}

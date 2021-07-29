//
//  SportModuleView.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//


import UIKit


class SportModuleView: UITableViewController, UITextFieldDelegate {
    
    let sportCellId = "sportCellId"
    var presenter: SportModulePresenterProtocol?
    
    var sportList: [SportModel] = []
    
    var addingWin: SportAddingWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "运动管理"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(showSportAddingWindow))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: sportCellId)
        
        
        // test
//        showSportAddingWindow()
        // test end
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportList.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sportCellId)!
        cell.textLabel?.text = sportList[indexPath.row].name
        return cell
    }
    
    @objc func showSportAddingWindow() {
        if let presenter = self.presenter {
            addingWin = SportAddingWindow(presenter: presenter, parentView: self, textFieldDelegate: self)
            if let addingWin = addingWin {
                view.addSubview(addingWin)
                
                
                // Set the constraints.
                let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (navigationController?.navigationBar.frame.height ?? 0.0)
                
                addingWin.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    addingWin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    addingWin.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -topBarHeight),
                    addingWin.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
                    addingWin.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
                ])
            }
            
        } else {
            print("Error : presenter is a nil.")
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed.")
        addingWin?.nameTextField.resignFirstResponder()
        return true
    }
    
    

}

extension SportModuleView: SportModuleViewProtocol{
    func loadData(datas: [Any]) {
//        datas as [Any]
        
        for data in datas {
            if data is [SportModel] {
                sportList = data as! [SportModel]
                tableView.reloadData()
            }
        }
        
    }
    
    
}

extension SportModuleView: ForAddingWindowProtocol {
    func updateTableView(newSport: SportModel) {
        sportList.append(newSport)
        tableView.insertRows(at: [IndexPath(row: sportList.count-1, section: 0)], with: .left)
    }
    
}

//extension SportModuleView: ForDropDownWindowProtocol {
//    func createUnitOrTag(name: String, dataType: DataType) {
//        let alert = UIAlertController(title: "创建", message: "请输入需要创建的名称", preferredStyle: .alert)
//
//        alert.addTextField{(textField) in
//            textField.keyboardType = .default
//        }
//
//        // Set the confirm button.
//        let confirmAction = UIAlertAction(title: "确认", style: .default){
//            UIAlertAction in
//            let tf = alert.textFields![0]
//
//            switch dataType{
//            case .tag:
//                print("")
//                if let text = tf.text {
//
//                    if(text.isEmpty == false) {
//                        // Check empty.
//
//                        if (self.presenter?.isTagExists(name: text) == false) {
//                            // Check exists.
//
//                            if let newTag = self.presenter?.createTag(name: text) {
//                                // Check success.
//
//                            } else {
//                                print("Create Error.")
//                            }
//
//                        } else {
//                            print("empty")
//                        }
//                    } else {
//                        print("输入空")
//                    }
//                }
//                case .unit:
//                    print("")
//            }
//        }
//    }
//
//
//
//
//    func closeDropDownWindow() {}
//
//
//
//
//}

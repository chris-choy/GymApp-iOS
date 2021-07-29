////
////  NewFile.swift
////  GymApp
////
////  Created by 大金兒 on 12/10/2020.
////  Copyright © 2020 Chris. All rights reserved.
////
//
//import UIKit
//
//
//class NewPlanTestVC: UITableViewController, UITextFieldDelegate {
//    
//    let cellId = "cellId"
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableView.register(NewCell.self, forCellReuseIdentifier: cellId)
//        
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! NewCell
//        cell.tf.text = "\(indexPath.row)"
//        cell.tf.delegate = self
//        
//        return cell
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("1")
//        
//        
//    }
//    
//}
//
//class NewCell: UITableViewCell {
//    
//    let tf: UITextField = {
//        
//        let tf = UITextField(frame: CGRect(x: 10, y: 5, width: 50, height: 30))
//        tf.layer.borderWidth = 1
//        
//        return tf
//    }()
//    
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        self.contentView.addSubview(tf)
//        
////        addSubview(tf)
//    }
//    
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//

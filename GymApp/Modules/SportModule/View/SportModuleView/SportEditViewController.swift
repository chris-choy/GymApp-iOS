//
//  SportEditViewController.swift
//  GymApp
//
//  Created by Chris on 2021/8/13.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit



class SportEditViewController: UITableViewController, UITextFieldDelegate {
    
    let cellId = "cellId"
    
    let listView: ForAddingWindowProtocol
    
    var sportModel: SportModel
    
    let loadingAnimationView = LoadingAnimationView()
    
//    enum EditMode {
//        case create
//        case edit
//    }
    
    let editMode : SaveMode
    
    init(sport: SportModel, listView: ForAddingWindowProtocol, editMode: SaveMode) {
        self.listView = listView
        self.sportModel = sport
        self.editMode = editMode
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLoadingAnimationView() {
        view.addSubview(loadingAnimationView)
        
        loadingAnimationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = (editMode == .create) ? "添加运动" : "编辑运动"
        
        view.backgroundColor = .white
        
        setupNavgationBar()
        
        setupLoadingAnimationView()
        
//        setupViews()
        
        tableView.register(TableViewTextFieldCell.self, forCellReuseIdentifier: cellId)
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        
        
        tableView.tableFooterView = UIView()
    }
    
    func setupNavgationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
    }
    
    @objc func saveAction(){
//        navigationController?.popToRootViewController(animated: true)
        
//        listView.saveSport(sport: sportModel)
        
        // Get sport name and unit.
        let nameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TableViewTextFieldCell
        let unitCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! TableViewTextFieldCell
        
        if let name = nameCell.textField.text,
           let unit = unitCell.textField.text {
            if ( (name.count != 0) && (unit.count != 0) ) {
                sportModel.name = name
                sportModel.unit = unit
                
                loadingAnimationView.show()
                
                // Opertation.
                self.listView.saveSport(sport: sportModel)
                
            } else {
                let alert = UIAlertController(title: "提示", message: "请输入运动信息。", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch editMode {
        case .create:
            return 2
        case .edit:
            return 3
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? TableViewTextFieldCell {
            cell.textLabel?.text = "\(indexPath.row)"
            
            cell.contentView.isUserInteractionEnabled = false
            
            cell.textField.delegate = self
            cell.textField.isEnabled = true
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "名称"
                cell.textField.placeholder = "请输入运动名称"
                
                if editMode == .edit {
                    cell.textField.text = sportModel.name
                }
            case 1:
                cell.textLabel?.text = "单位"
                cell.textField.placeholder = "请输入单位"
                
                if editMode == .edit {
                    cell.textField.text = sportModel.unit
                }
            default:
                cell.textLabel?.text = "删除"
//                cell.textLabel?.text = "default"
            }
            
            
            return cell
        }
        
        return UITableViewCell()
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == textField {
            return (textField.text?.count ?? 0) + string.count - range.length <= 11
        } else {
            return true
        }
    }
    
    
    func createSuccess(){
        loadingAnimationView.hide()
        
//        let alert = UIAlertController(title: "提示", message: "创建成功", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
    }
    
    func showAlertMessage(message: String){
        loadingAnimationView.hide()
        
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
//    func showRepeatedNameAlert(){
//        loadingAnimationView.hide()
//        let alert = UIAlertController(title: "提示", message: "", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
    
    
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print("tf 1: \(textField)")
//
//    }
//
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        print("tf 2: ")
//        return true
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        print("tf 3")
//
//        return true
//    }
    
}


class TableViewTextFieldCell: UITableViewCell {
    
    let textField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    fileprivate func setupTextfield() {
        addSubview(textField)
        textField.text = "一二三四五六七八九十一"
        
        // 10 for left and right padding.
        let width = textField.intrinsicContentSize.width + 10
        textField.text = ""

        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            //            textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            textField.widthAnchor.constraint(equalToConstant: width),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
        
        textField.setBottomBorder()
        textField.setLeftPaddingPoints(5)
        textField.setRightPaddingPoints(5)
        
        
        textField.borderStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupTextfield()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



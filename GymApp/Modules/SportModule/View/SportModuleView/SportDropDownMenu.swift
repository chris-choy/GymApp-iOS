//
//  SportDropDownMenu.swift
//  GymApp
//
//  Created by Chris on 2020/9/25.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

protocol ForDropDownWindowProtocol {
    func closeDropDownWindow()
    
//    func createUnitOrTag(name: String, dataType: DataType)
}

class SportDropDownMenu: UIView, UITableViewDataSource, UITableViewDelegate{
    
    let cellId = "cellId"
    
//    var unitList: [SportUnitModel] = []
    var unitList = ["kg", "秒" , "分", "个"]
    var tagList: [SportTagModel] = []
    
//    var presenter: SportModulePresenterProtocol
//    var dataType: DataType
    var parentWindow: ForDropDownWindowProtocol
    
    var sourceButton: UIButton
    
    
    
    
    // 新的数据形式
    let dataManager: aaa
    var data: [String] = []
    
    
//    enum DataType {
//        case tag
//        case unit
//    }
    
    let navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.pushItem(UINavigationItem(), animated: false)
        return bar
    }()
    
//    let searchBar: UISearchBar = {
//        let bar = UISearchBar()
//
//        return bar
//    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        
        return tv
    }()
    
    let stackView: UIStackView = {
        let s = UIStackView()
        
        return s
    }()
    
    
    
//    var title: String = ""
    
//    convenience init(dataType: DataType, presenter: SportModulePresenterProtocol) {
//        self.init()
//        self.dataType = dataType
//        self.presenter = presenter
//    }
    
    init(
//        dataType: DataType,
//         presenter: SportModulePresenterProtocol,
        dataManager: aaa,
        sourceButton: UIButton, parentWindow: ForDropDownWindowProtocol) {
//        self.presenter = presenter
        self.dataManager = dataManager
//        self.dataType = dataType
        self.sourceButton = sourceButton
        self.parentWindow = parentWindow
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        setupViews()
        
        // load data
//        switch self.dataType {
//        case .tag:
//            if let result = presenter.getTagList() {
//                tagList = result
//                tableView.reloadData()
//            }
//        case .unit:
//            if let result = presenter.getUnitList() {
//                unitList = result
//                tableView.reloadData()
//            }
//        }
        
        // load data
        loadData()
        
        
        
        // test
        self.layer.borderWidth = 1
        //test end.
        
    }
    
    func loadData(){
        if let result = dataManager.fetchAll() {
            data = result
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        self.backgroundColor = .white

//        if(dataType == DataType.tag){
//            title = "分类"
//        } else{
//            title = "单位"
//        }
        
        navigationBar.topItem?.title = dataManager.getTitle()
        navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTagOrUnit))
        
        stackView.addArrangedSubview(navigationBar)
//        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(tableView)
        addSubview(stackView)
        
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.axis = .vertical
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = 0
        
        setupConstraints()
    }
    
    func setupConstraints(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
//    func showInputAlert(){
//        
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
//            if let text = tf.text {
//                
//                if(text.isEmpty == false) {
//                    // Check empty.
//                    
////                    if (self.presenter.isTagExists(name: text) == false) {
//                    if (self.dataManager.isDataExists(name: text) == false) {
//                        // Check exists.
//                        
//                        if let newTag = self.dataManager.createNewObject(name: text){
//                            // Check success.
////                            self.tagList.append(newTag)
//                            self.data.append(newTag)
//                            self.tableView.insertRows(at: [IndexPath(row: self.data.count-1, section: 0)], with: .left)
//                        } else {
//                            self.showErrorInformation(text: "创建失败！")
//                        }
//                        
//                    } else {
//                        self.showErrorInformation(text: "您输入的xxx已存在，请重新输入。")
//                    }
//                } else {
//                    self.showErrorInformation(text: "请输入需要创建的xx名称。")
//                }
//            }
//        }
//        let cancelAction = UIAlertAction(title: "取消", style: .default){
//            UIAlertAction in
//            print("cancel")
//        }
//            
//        alert.addAction(confirmAction)
//        alert.addAction(cancelAction)
//        
////            self.present(alert, animated: true)
//        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
//        rootViewController?.present(alert, animated: true, completion: nil)
//        
//        
//    }
    
    @objc func addTagOrUnit(){
        
        let alert = UIAlertController(title: "创建", message: "请输入需要创建的名称", preferredStyle: .alert)
        
        alert.addTextField{(textField) in
            textField.keyboardType = .default
        }
        
        // Set the confirm button.
        let confirmAction = UIAlertAction(title: "确认", style: .default){
            UIAlertAction in
            let tf = alert.textFields![0]
            
            if let text = tf.text {
                
                if(text.isEmpty == false) {
                    // Check empty.
                    
                    if (self.dataManager.isDataExists(name: text) == false) {
                        // Check exists.
                        
                        if let newObject = self.dataManager.createNewObject(name: text){
                            // Check success.
//                            self.tagList.append(newTag)
                            self.data.append(newObject)
                            self.tableView.insertRows(at: [IndexPath(row: self.data.count-1, section: 0)], with: .left)
                        } else {
                            self.showErrorInformation(text: "创建失败！")
                        }
                        
                    } else {
                        self.showErrorInformation(text: "您输入的xxx已存在，请重新输入。")
                    }
                } else {
                    self.showErrorInformation(text: "请输入需要创建的xx名称。")
                }
            }
            
//            self.ddmTableView?.reloadData()
        }
            let cancelAction = UIAlertAction(title: "取消", style: .default){
                UIAlertAction in
                print("cancel")
            }
            
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
        
//            self.present(alert, animated: true)
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func showErrorInformation(text: String){
        let failedAlert = UIAlertController(title: "提示", message: text, preferredStyle: .alert)
        failedAlert.addAction(UIKit.UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.present(failedAlert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch self.dataType {
//        case .tag:
//            return tagList.count
//        case .unit:
//            return unitList.count
//        }
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        
//        switch self.dataType {
//        case .tag:
//            cell.textLabel?.text = tagList[indexPath.row].name
//        case .unit:
//            cell.textLabel?.text = unitList[indexPath.row].name
//        }
        cell.textLabel?.text = data[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        switch self.dataType {
//        case .tag:
//            sourceButton.setTitle(tagList[indexPath.row].name, for: .normal)
//        case .unit:
//            sourceButton.setTitle(unitList[indexPath.row].name, for: .normal)
//        }
        sourceButton.setTitle(data[indexPath.row], for: .normal)
        
        parentWindow.closeDropDownWindow()
    }
    
}

protocol aaa {
    func fetchAll() -> [String]?
    func createNewObject(name: String) -> String?
    func getTitle() -> String
    func isDataExists(name: String) -> Bool
}

class TagManager: aaa{
    var presenter: SportModulePresenterProtocol
    
    init(presenter: SportModulePresenterProtocol) {
        self.presenter = presenter
    }
    
    func createNewObject(name: String) -> String? {
        if let newTag = presenter.createTag(name: name) {
            return newTag.name
        }
        return nil
    }
    
    func isDataExists(name: String) -> Bool{
        return presenter.isTagExists(name: name)
    }

    func fetchAll() -> [String]? {
        
        if let result = presenter.getTagList(){
            var nameList : [String] = []
            
            for item in result {
                nameList.append(item.name)
            }
            
            return nameList
            
        }
        
        return nil
    }
    
    func getTitle() -> String {
        return "分类"
    }

}


//class UnitManager: aaa {
//    var presenter: SportModulePresenterProtocol
//
//    init(presenter: SportModulePresenterProtocol) {
//        self.presenter = presenter
//    }
//
//    func createNewObject(name: String) -> String? {
//        if let newTag = presenter.createUnit(name: name) {
//            return newTag.name
//        }
//        return nil
//    }
//
//    func isDataExists(name: String) -> Bool{
//        return presenter.isUnitExists(name: name)
//    }
//
//    func fetchAll() -> [String]? {
//
//        if let result = presenter.getUnitList(){
//            var nameList : [String] = []
//
//            for item in result {
//                nameList.append(item.name)
//            }
//
//            return nameList
//
//        }
//
//        return nil
//    }
//
//    func getTitle() -> String {
//        return "单位"
//    }
//
//}


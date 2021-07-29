////
////  SportViewController.swift
////  GymApp
////
////  Created by Chris on 2020/4/16.
////  Copyright © 2020 Chris. All rights reserved.
////
//
//import UIKit
//import CoreData
//
//class SportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
//    
////    var sportList = ["仰卧起坐","深蹲","跑步","引体向上","弓箭步","卷腹","反向卷腹","上斜哑铃卧推","平地哑铃飞鸟","坐姿哑铃推举"]
//    
//    var sportList: [String] = []
//    
//    var testList: [Sport]? = nil
//    
//    var sportFC: NSFetchedResultsController<Sport>?
//    
//    var sortedName: [String] = []
//    
//    private var sportAddingWindow: UIView!
//    
//    let tableView: UITableView = {
//        let tbv  = UITableView()
//        tbv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return tbv
//    }()
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        title = "运动管理"
//
//        setupContext()
//        
//        setupTableView()
//        
//        
////        navigationItem.title = "运动管理"
////        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(showSportAddingWindow))
////        // set large titles
////        if #available(iOS 11.0, *) {
////            navigationController?.navigationBar.prefersLargeTitles = true
////        } else {
////            // Fallback on earlier versions
////        }
//        
////        setData()
//        
//        
//        
//        
//        fetchSportData()
//        
////        createSportAddingWin()
//        
////        showDropDownMenu()
//
//    }
//    
//// MARK: - SportAddingWindow UI
//    
//    let inputStackView: UIStackView = {
//            let stack = UIStackView()
//            stack.alignment = .fill
//            stack.distribution = .fill
//            stack.axis = .vertical
//            stack.translatesAutoresizingMaskIntoConstraints = false
//            return stack
//        }()
//        
//        let nameLabel: UILabel = {
//            let label = UILabel()
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.text = "名称"
//            return label
//        }()
//        
//        let titleLabel: UILabel = {
//            let label = UILabel()
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.text = "运动管理"
//            return label
//        }()
//        
//        let nameTextField: UITextField = {
//            let tf = UITextField()
//            tf.translatesAutoresizingMaskIntoConstraints = false
//            return tf
//        }()
//        
//        let confirmAddSportBtn: UIButton = {
//            let btn = UIButton()
//            btn.translatesAutoresizingMaskIntoConstraints = false
//            btn.setTitle("确认", for: .normal)
//            return btn
//        }()
//        
//        //tag view
//        let tagStackView: UIStackView = {
//            let stack = UIStackView()
//            stack.alignment = .fill
//            stack.distribution = .fill
//            stack.axis = .vertical
//            stack.translatesAutoresizingMaskIntoConstraints = false
//            
//            let label = UILabel()
//            label.text = "分类"
//            label.translatesAutoresizingMaskIntoConstraints = false
//            stack.addArrangedSubview(label)
//            
//            let button = UIButton()
//            button.setTitle("点击选择分类", for: .normal)
//            button.setTitleColor(.black, for: .normal)
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.layer.borderWidth = 1
//            button.layer.borderColor = UIColor.lightGray.cgColor
//            button.layer.cornerRadius = 5
//            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//            button.contentHorizontalAlignment = .left
//            button.addTarget(self, action: #selector(showTagMenuAction), for: .touchUpInside)
//            button.titleLabel?.textAlignment = NSTextAlignment.center
//            
//            stack.addArrangedSubview(button)
//            
//            return stack
//        }()
//        
//        let tagLabel: UILabel = {
//            let label = UILabel()
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.text = "分类"
//            return label
//        }()
//        
//        let tagButton: UIButton = {
//            let btn = UIButton()
//            btn.translatesAutoresizingMaskIntoConstraints = false
//            btn.setTitle("点击选择分类", for: .normal)
//            return btn
//        }()
//        
//        let unitLabel: UILabel = {
//            let label = UILabel()
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.text = "单位"
//            return label
//        }()
//        
//        let unitButton: UIButton = {
//            let btn = UIButton()
//            btn.translatesAutoresizingMaskIntoConstraints = false
//            btn.setTitle("点击选择单位", for: .normal)
//            return btn
//        }()
//    
//    /*
//    fileprivate func setInputUI() {
//        inputStackView.addArrangedSubview(nameLabel)
//        inputStackView.addArrangedSubview(nameTextField)
//        inputStackView.addArrangedSubview(tagLabel)
//        inputStackView.addArrangedSubview(tagButton)
//        inputStackView.addArrangedSubview(unitLabel)
//        inputStackView.addArrangedSubview(unitButton)
//        sportAddingWindow.addSubview(inputStackView)
//        
//        inputStackView.leadingAnchor.constraint(equalTo: sportAddingWindow.leadingAnchor, constant: 50).isActive = true
//        inputStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
//        inputStackView.centerXAnchor.constraint(equalTo: sportAddingWindow.centerXAnchor).isActive = true
//        inputStackView.spacing = 5
//        
//        nameTextField.setLeftPaddingPoints(10)
//        nameTextField.layer.borderWidth = 1
//        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
//        nameTextField.layer.cornerRadius = 5
//        nameTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
//        nameTextField.placeholder = "输入"
//        
//        tagButton.layer.borderWidth = 1
//        tagButton.layer.cornerRadius = 5
//        NSLayoutConstraint.activate([
//            tagButton.heightAnchor.constraintu7(equalToConstant: 35)
//        ])
//        tagButton.setTitleColor(.lightGray, for: .normal)
//        //padding
//        tagButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        tagButton.contentHorizontalAlignment = .left
//        tagButton.layer.borderColor = UIColor.lightGray.cgColor
//        tagButton.addTarget(self, action: #selector(showTagMenuAction), for: .touchUpInside)
//        tagButton.titleLabel?.textAlignment = NSTextAlignment.center
//        
//        unitButton.layer.borderWidth = 1
//        unitButton.layer.cornerRadius = 5
//        NSLayoutConstraint.activate([
//            unitButton.heightAnchor.constraint(equalToConstant: 35)
//        ])
//        unitButton.setTitleColor(.lightGray, for: .normal)
//        //padding
//        unitButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        unitButton.contentHorizontalAlignment = .left
//        unitButton.layer.borderColor = UIColor.lightGray.cgColor
//        unitButton.addTarget(self, action: #selector(showUnitMenuAction), for: .touchUpInside)
//        
//        
//        sportAddingWindow.addSubview(tagStackView)
//        inputStackView.addArrangedSubview(tagStackView)
////        tagStackView.topAnchor.constraint(equalTo: unitButton.bottomAnchor, constant: 0).isActive = true
////        tagStackView.centerXAnchor.constraint(equalTo: unitButton.centerXAnchor).isActive = true
//    }*/
//    
//    fileprivate func setInputUI() {
//        sportAddingWindow.addSubview(inputStackView)
//        inputStackView.addArrangedSubview(tagStackView)
//        
//        inputStackView.leadingAnchor.constraint(equalTo: sportAddingWindow.leadingAnchor, constant: 50).isActive = true
//        inputStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
//        inputStackView.centerXAnchor.constraint(equalTo: sportAddingWindow.centerXAnchor).isActive = true
//        inputStackView.spacing = 5
//        
//        
//    }
//    
//    fileprivate func setupSportAddingWinUI() {
//        //customView
//        sportAddingWindow.backgroundColor = .white
//        sportAddingWindow.translatesAutoresizingMaskIntoConstraints = false
//        sportAddingWindow.layer.borderWidth = 1
//        
//        //window position
//        NSLayoutConstraint.activate([
//            sportAddingWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            sportAddingWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            sportAddingWindow.widthAnchor.constraint(equalToConstant: 300),
//            sportAddingWindow.heightAnchor.constraint(equalToConstant: 350)
//            //        customView.centerYAnchor.constraint(equalTo: anchor)
//        ])
//        sportAddingWindow.layer.cornerRadius = 8
//        
//        //title
//        sportAddingWindow.addSubview(titleLabel)
//        titleLabel.centerXAnchor.constraint(equalTo: sportAddingWindow.centerXAnchor).isActive = true
//        titleLabel.topAnchor.constraint(equalTo: sportAddingWindow.topAnchor, constant: 15).isActive = true
//        titleLabel.text = "添加运动"
//        titleLabel.textColor = .black
//        
//        //button
//        sportAddingWindow.addSubview(confirmAddSportBtn)
//        confirmAddSportBtn.setTitleColor(.black, for: .normal)
//        confirmAddSportBtn.centerXAnchor.constraint(equalTo: sportAddingWindow.centerXAnchor).isActive = true
//        confirmAddSportBtn.bottomAnchor.constraint(equalTo: sportAddingWindow.bottomAnchor, constant: -10).isActive = true
//        confirmAddSportBtn.widthAnchor.constraint(equalToConstant: 130).isActive = true
//        confirmAddSportBtn.layer.cornerRadius = 5
//        confirmAddSportBtn.layer.borderWidth = 1
////        confirmAddSportBtn.addTarget(self, action: #selector(confirmAddSportBtnAction), for: .touchUpInside)
//
//        
//        
//        setInputUI()
//        
//        
//        
//    }
//    
//    func createSportAddingWin() {
//        //pop up adding window
//        sportAddingWindow = UIView()
//        view.addSubview(sportAddingWindow)
//        sportAddingWindow.isHidden = false
//        
//        setupSportAddingWinUI()
//    }
//    
//    func removeSportAddingWin(){
//        sportAddingWindow.isHidden = true
//    }
//    
//// MARK: - Actions
//    
//    @objc func confirmAddSportBtnAction() {
//        let name = nameTextField.text
//        if(name?.count == 0){
//            let alert = UIAlertController(title: "提示", message: "请输入运动名称。", preferredStyle: .alert)
//            alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
//            present(alert, animated: false, completion: nil)
//        }
//        
//        let tag = selectTag(name: tagButton.titleLabel!.text!)
//        if(tag.count == 0){
//            let alert = UIAlertController(title: "提示", message: "请选择运动分类。", preferredStyle: .alert)
//            alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
//            present(alert, animated: false, completion: nil)
//        }
//        
//        let unit = selectUnit(name: unitButton.titleLabel!.text!)
//        if(tag.count == 0){
//            let alert = UIAlertController(title: "提示", message: "请选择运动计数单位。", preferredStyle: .alert)
//            alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
//            present(alert, animated: false, completion: nil)
//        }
//        
//        if((tag.count == 1) && (unit.count == 1)){
////            addSport(name: name!, tag: tag[0], unit: unit[0])
//        }
//        
//    }
//    
//    fileprivate func showDropDownMenu() {
//        createDropDownMenu(title: "分类", btn: tagButton, dataType: .tag)
//    }
//    
//    fileprivate func showUnitDropDownMenu() {
//        if dropDownMenu == nil {
//            createDropDownMenu(title: "单位", btn: unitButton, dataType: .unit)
//        }
//        else{
//            removeDropDownMenu()
//        }
//
//    }
//    
//    @objc func showTagMenuAction(){
//    
//        if(dropDownMenu != nil){
//            removeDropDownMenu()
//        }else{
//            showDropDownMenu()
//        }
//        
////        if(dropDownMenu.isHidden){
////            dropDownMenu.isHidden = false
////            UIView.animate(withDuration: 0.15, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
////                        self.dropDownMenu.alpha = 1.0
////                    })
////        }else{
////            dropDownMenu.isHidden = true
////            UIView.animate(withDuration: 0.15, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
////                self.dropDownMenu.alpha = 0.0
////            })
////        }
//
//    }
//    
//    @objc func showUnitMenuAction(){
//            showUnitDropDownMenu()
//        }
//    
//    
//    @objc func showSportAddingWindow() {
//        
//        createSportAddingWin()
//    }
//    
//    
//    
//    
//    
////    func setData()  {
////
////
//////        let s1 = Sport()
////
////        let store = NSPersistentContainer(name: "GymApp")
////        store.loadPersistentStores { (desc, err) in
////            if let err = err {
////                fatalError("core data error: \(err)")
////            }
////        }
////        let context = store.viewContext
////
////
////
////
////
////    }
//    
//// MARK: - UITableView
//    
//    func setupTableView(){
//        view.addSubview(tableView)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//
//        
//        switch tableView {
//        case self.tableView:
//            return testList!.count
//        case ddmTableView:
//            if(ddmDataType == DataType.tag){
//                return tagList?.count ?? 0
//            }
//            else{
//                return unitList?.count ?? 0
//            }
//            
//            
//        default:
//            return 0
//        }
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        switch tableView {
//        case self.tableView:
//            return 1
//        case ddmTableView:
//            return 1
//        default:
//            return 0
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        switch tableView {
//        case self.tableView:
//            let label = UILabel()
//            label.text = "Header"
//            label.backgroundColor = UIColor.lightGray
//            return label
//        case ddmTableView:
//            return nil
//        default:
//            return nil
//        }
//    }
//    
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        
//        switch tableView {
//        case self.tableView:
//            cell.textLabel?.text = testList?[indexPath.row].name
//        case ddmTableView:
//            if(ddmDataType == DataType.tag){
//                cell.textLabel?.text = tagList?[indexPath.row].name
//            }
//            else{
//                cell.textLabel?.text = unitList?[indexPath.row].name
//            }
//        default:
//            break
//        }
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch tableView {
//        case self.tableView:
//            print(testList?[indexPath.row].name as Any)
//        case ddmTableView:
//            if ddmDataType == DataType.tag {
//                tagButton.setTitle(tagList?[indexPath.row].name, for: .normal)
//                tagButton.setTitleColor(.black, for: .normal)
//            }
//            else{
//                unitButton.setTitle(unitList?[indexPath.row].name, for: .normal)
//                unitButton.setTitleColor(.black, for: .normal)
//            }
//            removeDropDownMenu()
//        default:
//            break
//        }
//    }
//    
//    @available(iOS 11.0, *)
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let modifyAction = UIContextualAction(style: .normal, title:  "删除", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            
//            switch self.ddmDataType{
//            case .tag :
//                self.deleteTag(name: (self.tagList?[indexPath.row].name)!)
//            case .unit :
//                self.deleteUnit(name: (self.unitList?[indexPath.row].name)!)
//            case .none:
//                break
//            }
//            
//            
////            if(self.ddmDataType == DataType.tag){
////                self.deleteTag(name: (self.tagList?[indexPath.row].name)!)
////            }
////            else{
////                self.deleteUnit(name: (self.unitList?[indexPath.row].name)!)
////            }
//            success(true)
//        })
//        modifyAction.image = UIImage(named: "hammer")
//        modifyAction.backgroundColor = .red
//        
//        
//        return UISwipeActionsConfiguration(actions: [modifyAction])
//    }
//    
//// MARK: - DropDownMenuView
//    
//    var dropDownMenu: UIView?
//    var ddmNavigationBar: UINavigationBar?
//    var ddmSearchBar: UISearchBar?
//    var ddmTableView: UITableView?
//    var ddmStackView: UIStackView?
//    var ddmDataType: DataType?
//    
//    //data
//    
//    var tagList: [SportTag]? = nil
//    var unitList: [SportUnit]? = nil
//    enum DataType {
//        case tag
//        case unit
//    }
//    
//    var tagFC: NSFetchedResultsController<SportTag>?
//    var unitFC: NSFetchedResultsController<SportUnit>?
//    
//    var managedObjectContext: NSManagedObjectContext?
//
//}
//
//
//// MARK: - Extensions
//
//extension UITextField{
//    func setLeftPaddingPoints(_ amount:CGFloat){
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//        self.leftView = paddingView
//        self.leftViewMode = .always
//    }
//    func setRightPaddingPoints(_ amount:CGFloat) {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//        self.rightView = paddingView
//        self.rightViewMode = .always
//    }
//}

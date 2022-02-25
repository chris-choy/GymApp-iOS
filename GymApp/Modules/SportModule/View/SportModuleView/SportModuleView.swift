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
    
    var editViewController: SportEditViewController? = nil
    
//    refreshControl = UIRefreshControl()
    
    // HeaderStruct is for constructing the tableView's headerIndex.
    struct HeaderStruct {
        var letter: Character
        var ni: [NameAndIndex]
    }
    
    struct NameAndIndex{
        var name: String
        var index: Int
    }
    
    var headerList : [HeaderStruct] = []
    
    let viewMode : ViewMode
    
    
    let loadingAnimationView = LoadingAnimationView()
    
    fileprivate func setupLoadingAnimationView() {
        view.addSubview(loadingAnimationView)
        
        tableView.backgroundView = loadingAnimationView

    }
    
    init(viewMode: ViewMode) {
        self.viewMode = viewMode
        super.init(style: .plain)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupBar()
        
        switch viewMode {
        case .manager:
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: sportCellId)
        case .choice:
            tableView.register(CheckMarkTableViewCell.self, forCellReuseIdentifier: sportCellId)
        }
        
        tableView.allowsMultipleSelection = true

        // Color.
        tableView.backgroundColor = .white
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "下拉更新运动数据")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        setupLoadingAnimationView()
        
        // test
        loadSportData()
        // test end
        
    }
    
    @objc func refresh(){
        loadSportData()
    }
    
    func loadSportData(){
        loadingAnimationView.show()
        presenter?.fetchAllSportFromServer()
    }
    
    fileprivate func setupBar() {
        
        title = (viewMode == .manager) ? "运动管理" : "选择运动"
        
        let rightBtnTitle = (viewMode == .manager) ? "Add" : "完成"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightBtnTitle, style: .plain, target: self, action: #selector(rightBtnAction))
        
    }
    
    func setupIndexTitle(){
        
        headerList = []
        
        for index in 0..<sportList.count{

            var name = sportList[index].name
            
            // 1. Whether the first letter is Latin Letter or Chinese Characters.
            var pattern = "^[a-zA-Z\u{4e00}-\u{9fa5}]"
            
            if let _ = name.range(of: pattern,options: .regularExpression){
                
                // 2. Convert the Chinese Characters to PinYin.
                pattern = "^[\u{4e00}-\u{9fa5}]"
                if let _ = name.range(of: pattern, options: .regularExpression){
                    let s = NSMutableString(string: "\(name)")
                    CFStringTransform(s, nil, kCFStringTransformToLatin, false)
                    CFStringTransform(s, nil, kCFStringTransformStripDiacritics, false)
                    name = String(s)
                }
                
                // 3. Get the index and characters.
                if let headerIndex = headerList.firstIndex(where: {$0.letter == name.first}){
                    headerList[headerIndex].ni.append(NameAndIndex(name: name, index: index))
                } else {
                    if let letter = name.first{
                        headerList.append(HeaderStruct(letter: letter,
                                                       ni: [NameAndIndex(name: name,
                                                                         index: index)]))
                    }
                }
            } else {
                // 4. First character is not Latin Letter or Chinese Characters.
                if let otherIndex = headerList.firstIndex(where: {$0.letter == "#"}){
                    headerList[otherIndex].ni.append(NameAndIndex(name: name, index: index))
                } else {
                    // Create the '#' titleIndex.
                    headerList.append(HeaderStruct(letter: "#",
                                                   ni: [NameAndIndex(name: name,
                                                                     index: index)]))
                }
                
            }

        }

        // Sort.
        headerList.sort(by: {$0.letter < $1.letter})
        for i in 0..<headerList.count{
            headerList[i].ni.sort(by: {$0.name < $1.name})
        }
        if let otherIndex = headerList.firstIndex(where: {$0.letter == "#"}){
            let other = headerList.remove(at: otherIndex)
            headerList.insert(other, at: headerList.count)
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerList[section].ni.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return headerList.count
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(headerList[section].letter)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sportIndex = headerList[indexPath.section].ni[indexPath.row].index
        
        let cell = tableView.dequeueReusableCell(withIdentifier: sportCellId)!
        cell.selectionStyle = .none
        cell.textLabel?.text = sportList[sportIndex].name
        
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        var titles : [String] = []
        
        for t in headerList {
            titles.append(String.init(t.letter))
        }
        
        return titles
    }

    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
        return index
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewMode {
        case .manager:
            let index = headerList[indexPath.section].ni[indexPath.row].index
            
            editViewController = SportEditViewController(
                sport: sportList[index],
                listView: self,
                editMode: .edit)
            self.navigationController?.pushViewController( editViewController! , animated: true)
        case .choice:
            break
        }

    }
    
    @objc func rightBtnAction() {
        
        switch viewMode {
        case .manager:
            // Open the Sport Edit view.
            editViewController = SportEditViewController(
                sport: SportModel(id: 0, objectId: nil, name: "", unit: "", user_id: 0, last_changed: 0),
                listView: self,
                editMode: .create)
            self.navigationController?.pushViewController( editViewController! , animated: true)
        case .choice:
            // Return the sports' choice result.
            if let selectedIndexPath = tableView.indexPathsForSelectedRows {
                var selectedSports : [SportModel] = []
                for indexPath in selectedIndexPath {
                    let index = headerList[indexPath.section].ni[indexPath.row].index
                    selectedSports.append(sportList[index])
                }
                
                presenter?.sendTheChoseResult(sports: selectedSports)
            }
        
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed.")
        addingWin?.nameTextField.resignFirstResponder()
        return true
    }

}

extension SportModuleView: SportModuleViewProtocol{
    
    
    func loadData(datas: [SportModel]) {
                
        sportList = datas
        setupIndexTitle()
        tableView.reloadData()
        refreshControl?.endRefreshing()
        loadingAnimationView.hide()
        
    }
    
    func showCreateSuccess() {
        
        if let editViewController = editViewController {
            editViewController.createSuccess()
            editViewController.navigationController?.popToRootViewController(animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let alert = UIAlertController(title: "提示", message: "创建成功。", preferredStyle: .alert)
                self.present(alert, animated: true) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                      alert.dismiss(animated: true, completion: nil)
                    }
                }

            }

            presenter?.fetchAllSportFromServer()
            
        }
        
        editViewController = nil

    }
    
    func showFailMessage(message: String) {

        if let editViewController = editViewController {
            editViewController.showAlertMessage(message: "创建失败，网络连接错误。")
        }
        
    }
    
    func loadSportFail(){
        let alert = UIAlertController(title: "提示", message: "由于网络原因，加载运动数据出错。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: nil))
        
        loadingAnimationView.hide()
        
        present(alert, animated: true, completion: nil)
    }
    
    func loadSportSuccess(){
        tableView.reloadData()
        loadingAnimationView.hide()
    }

}

extension SportModuleView: ForAddingWindowProtocol {
    func updateTableView(newSport: SportModel) {
        sportList.append(newSport)
        tableView.insertRows(at: [IndexPath(row: sportList.count-1, section: 0)], with: .left)
    }
    
    func backToModuleView(){
        editViewController?.navigationController?.popToRootViewController(animated: true)
        editViewController = nil
    }
    
    func saveSport(sport: SportModel) {
        
        // Check whether the sport's name was repeated.
        
        // Determin that create or update.
        if sport.id == 0 {
            // Crate a new sport.
            if let _ = sportList.firstIndex(where: {$0.name == sport.name}) {
                editViewController?.showAlertMessage(message: "\"\(sport.name)\"已存在，无法重复创建。")
            } else {
                presenter?.saveSport(sport: sport, mode: .create)
            }
        } else {
            // Update the sport information.
            presenter?.saveSport(sport: sport, mode: .edit)
        }
        
    }
    
}

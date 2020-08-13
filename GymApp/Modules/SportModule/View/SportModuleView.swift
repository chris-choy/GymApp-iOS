//
//  SportModuleView.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class SportModuleView: UITableViewController{
    
    var presenter: SportModulePresenterProtocol?
    
    let cellId = "cellId"
    
    var sportList: [SportModel]?
    
//    var isChecked: [Bool]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.allowsMultipleSelection = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(doneAction))
        
        title = "运动"
    }
    
    @objc func doneAction(){
//        if sportList != nil {
//            if sportList!.count > 0 {
//                var sports : [SportModel] = []
//                for index in 0...sportList!.count-1 {
//                    if(isChecked![index]){
//                        sports.append(sportList![index])
//                    }
//                }
//
////                // Test.
////                print(sports)
////                // Test end.
//                if sports.count > 0 {
//                    presenter?.sendTheChoseResult(sports: sports)
//                    self.dismiss(animated: true, completion: nil)
//                }
//            }
//        }
        
        if let selectedIndexPath = tableView.indexPathsForSelectedRows {
            var selectedSports : [SportModel] = []
            for index in selectedIndexPath {
                selectedSports.append(sportList![index.row])
            }
            
            presenter?.sendTheChoseResult(sports: selectedSports)
        }
        
        
        
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = sportList?.count {
            return count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if let sports = sportList {
            cell?.textLabel?.text = sports[indexPath.row].name
//            if let isChecked = isChecked{
//                if(isChecked[indexPath.row]){
////                    cell?.select(self)
//                    cell?.accessoryType = .checkmark
//                }
//            }
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        isChecked?[indexPath.row] = true
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        isChecked?[indexPath.row] = false
    }
    
}

extension SportModuleView: SportModuleViewProtocol {
    
    func loadData(selectedList: [Bool], data: [SportModel]) {
        
        sportList = data
//        isChecked = selectedList
        tableView.reloadData()
    }
    
}

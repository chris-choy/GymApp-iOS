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
    
    var sportList: [Sport]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.allowsMultipleSelection = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(doneAction))
        
        title = "运动"
    }
    
    @objc func doneAction(){
        if let indexList = tableView.indexPathsForSelectedRows {
            
            var sports : [Sport] = []
            for index in indexList {
                sports.append(sportList![index.row])
            }
            presenter?.sendTheChoseResult(sports: sports)
            self.dismiss(animated: true, completion: nil)
        }
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
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}

extension SportModuleView: SportModuleViewProtocol {
    
    func showSports(sports: [Sport]) {
        sportList = sports
        tableView.reloadData()
    }
    
}

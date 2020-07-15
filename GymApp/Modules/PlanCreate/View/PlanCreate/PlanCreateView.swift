//
//  PlanCreateView.swift
//  GymApp
//
//  Created by Chris on 2020/6/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit


private let collectionCellId = "PlanCollectionViewCell"

class PlanCreateView: UITableViewController {
    
    var presenter: PlanCreatePresenterProtocol?
    
    let tableCellId = "tableCellId"
    let addButtonCellId = "addButtonCellId"
    
    var plan : Plan?
    
    let planTitleTF: UITextField = {
        let tf = UITextField()
        tf.text = "PlanTitle"
        tf.translatesAutoresizingMaskIntoConstraints = false

        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PlanTableviewCell.self, forCellReuseIdentifier: tableCellId)
        tableView.register(AddButtonCell.self, forCellReuseIdentifier: addButtonCellId)
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if let p = plan {
            
            if let section = p.planSections {
                return section.count + 2
            }
        
            // There is no seciton.
            // So one is for title, another is for the add Button.
            return 2
        }
        
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let totalRow = tableView.numberOfRows(inSection: indexPath.section)
        switch indexPath.row {
        case 0:
//             The title row.
            let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId) as! PlanTableviewCell
            cell.setNumLabel.text = "组"
            cell.lastValueLabel.text = "上一次记录"
            cell.valueLabel.text = "数值"
            cell.unitLabel.text = "单位"
            cell.timesLabel.text = "次数"
            cell.multiplicationSymbol.image = nil
            cell.backgroundColor = .lightGray
            return cell
        case totalRow - 1:
            // The last row in the section.
            let cell = tableView.dequeueReusableCell(withIdentifier: addButtonCellId) as! AddButtonCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId) as! PlanTableviewCell
            cell.setNumLabel.text = "1"
            cell.lastValueLabel.text = "50"
            cell.valueLabel.text = "35"
            cell.unitLabel.text = "kg"
            cell.timesLabel.text = "3"
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 60
        } else {
            return 35
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }

    fileprivate func titleSectionView(width: CGFloat, height: CGFloat) -> UIView{
        // Plan's title View.
        let titleSectionView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
                
        let label = UILabel()
        titleSectionView.addSubview(label)
//        label.backgroundColor = .darkGray
        
        if let text = plan?.name {
            label.text = text
        }
        
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        // Text style.
        // ...
        
        // Label layout
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-10-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": label]))
        label.centerYAnchor.constraint(equalTo: titleSectionView.centerYAnchor).isActive = true
        
        return titleSectionView
    }
    
    fileprivate func addBtnSectionView(_ tableView: UITableView) -> UIView? {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))

        let btn = UIButton()
        v.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(" Add Sport", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 8
        
        btn.addTarget(self, action: #selector(addPlanSection), for: .touchUpInside)
        
        //Layout
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": btn])
        )
        
        return v
    }
    
    @objc func addPlanSection(){
        present(presenter!.buildSportListView(), animated: true, completion: nil)
    }
    
    fileprivate func planSectionView(_ tableView: UITableView) -> UIView? {
        // PlanSection View.
        let v = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        v.backgroundColor = .clear
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        v.addSubview(label)
        label.text = "仰卧起坐"
        label.textColor = .systemBlue
        
        // Layout.
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: v.centerYAnchor),
            label.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 10)
        ])
        
        return v
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let numberOfSections = tableView.numberOfSections
        
        switch section {
            
        case 0:
            // Show plan title.
            return titleSectionView(width: tableView.frame.width, height: 50)
            
        case numberOfSections - 1:
            // Show the add section button.
            return addBtnSectionView(tableView)

        default:
            // Show the plan section details.
            return planSectionView(tableView)
            
        }
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRowsInSection = tableView.numberOfSections
        
        let rowCounts = 3
        
        switch section {
        case 0,
             numberOfRowsInSection-1,
             numberOfRowsInSection-2 :
            return 0
        default:
            return rowCounts
        }
        
    }
    
    
    
    

}

extension PlanCreateView: PlanCreateViewProtocol {
    
    func loadData(plans: [Plan]) {
        if(plans.count == 1){
            viewDidLoad()
            self.plan = plans[0]
            tableView.reloadData()
//            viewDidLoad()
        }
        else{
            print("PlanEditView Error：Passed more than two object.")
        }
    }
    
    func addSection(sections: [PlanSection]){
//        var sections: [PlanSection] = []
        
        for s in sections {
            
            
        }
//        plan?.addToPlanSections(NSSet(object: sections))
        tableView.reloadData()
    }
}

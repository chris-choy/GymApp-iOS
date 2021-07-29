////
////  File.swift
////  GymApp
////
////  Created by Chris on 2020/10/12.
////  Copyright © 2020 Chris. All rights reserved.
////
//
//import UIKit
//
//class PlanTestVC : UITableViewController, UITextFieldDelegate{
//    
//    let tableCellId = "tableCellId"
//    let addButtonCellId = "addButtonCellId"
//    let sectionHeaderCellId = "sectionHeaderCellId"
//    
//    let testCellId = "testCellId"
//
//    
//    var plan : PlanModel? = {
//        
//        
//        let row1 = PlanRowModel(id: 0,
//                                seq: 1,
//                                lastValue: 0,
//                                value: 0,
//                                times: 0)
//        
//        let row2 = PlanRowModel(id: 0,
//                                seq: 2,
//                                lastValue: 0,
//                                value: 0,
//                                times: 0)
//        
//        
//        let model = PlanModel(
//            id: nil,
//            objectId: nil,
//            name: "Plan!!!",
//            sectionList: [PlanSectionModel(id: 0,
//                                           sectionIndex: 0,
//                                           unit: "unit",
//                                           rowList: [row1,row2],
//                                           sport: SportModel(
//                                            id: 0,
//                                            objectId: nil,
//                                            name: "sport1",
//                                            unit: SportUnitModel(name: "unit", sportNames: nil)))], last_changed: 0)
//        
//        return model
//    }()
//    
////    let titleTF: UITextField = {
////        let tf = UITextField()
//////        tf.text = "PlanTitle"
////        tf.translatesAutoresizingMaskIntoConstraints = false
////
////        return tf
////    }()
//    
//    let titleTF: UILabel = {
//        let tf = UILabel()
////        tf.text = "PlanTitle"
//        tf.translatesAutoresizingMaskIntoConstraints = false
//
//        return tf
//    }()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        
//        tableView.register(PlanTableViewCell.self, forCellReuseIdentifier: tableCellId)
//        tableView.register(AddRowButtonCell.self, forCellReuseIdentifier: addButtonCellId)
//        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: sectionHeaderCellId)
//        
//        tableView.register(NewCell.self, forCellReuseIdentifier: testCellId)
//
//        
//        
//        
//        
//        //
////        plan = PlanModel(objectId: nil, name: "Plan!!!")
//        
//        
//    }
//    
//    
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let totalRow = tableView.numberOfRows(inSection: indexPath.section)
//        switch indexPath.row {
//        case 0:
//            
////             The title row.
//            let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId) as! PlanTableViewCell
//            cell.setNumLabel.text = "组"
//            cell.lastValueLabel.text = "上一次的记录"
//            cell.valueTF.text = "数值"
////            cell.valueTF.isEnabled = false
////            cell.unitLabel.text = "单位"
//            cell.timesTF.text = "次数"
////            cell.timesTF.isEnabled = false
//            cell.multiplicationSymbol.image = nil
////            cell.backgroundColor = .lightGray
//            return cell
//            
//        case totalRow - 1:
//            
//            // The last row in the section is the the button to add row.
//            // The action of this button is in the tableView's disSelectRowAt.
//            let cell = tableView.dequeueReusableCell(withIdentifier: addButtonCellId) as! AddRowButtonCell
//            return cell
//            
//        default:
//            
//            let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId) as! PlanTableViewCell
//            cell.valueTF.delegate = self
//            cell.timesTF.delegate = self
//            
//            if(plan?.sectionList.count != 0){
//                cell.valueTF.text = String(plan!.sectionList[indexPath.section-1].rowList[indexPath.row-1].value)
//                cell.timesTF.text = String(plan!.sectionList[indexPath.section-1].rowList[indexPath.row-1].times)
//            } else {
//                cell.valueTF.text = "-"
//                cell.timesTF.text = "-"
//            }
//            cell.setNumLabel.text = String(indexPath.row)
//            cell.lastValueLabel.text = "-"
//            
//            cell.valueTF.keyboardType = .numbersAndPunctuation
//            // Set the layer.
//            cell.valueTF.backgroundColor = UIColor(red: 209, green: 209, blue: 214)
//            cell.valueTF.layer.cornerRadius = 8
//
//            
////            cell.unitLabel.text = plan?.sectionList[indexPath.section-1].unit
//            
//            cell.timesTF.keyboardType = .numbersAndPunctuation
//            // Set the layer.
//            cell.timesTF.backgroundColor = UIColor(red: 209, green: 209, blue: 214)
//            cell.timesTF.layer.cornerRadius = 8
//            
//            return cell
//        }
//    }
//    
//    
//    /*
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: testCellId) as! NewCell
//        
//        cell.tf.delegate = self
//        
//        return cell
//    }
//    */
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        
//        if let plan = plan {
//            // One is for title, another is for the add Button.
//            return plan.sectionList.count + 2
//        }
//        return 0
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if(section == 0){
//            return 60
//        } else {
//            return 35
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 30
//    }
//    
//    fileprivate func addBtnSectionView(_ tableView: UITableView) -> UIView? {
//
//        let v = UIView()
//        
//        let btn = UIButton()
//        v.addSubview(btn)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle("添加运动", for: .normal)
//        btn.backgroundColor = .systemBlue
//        btn.layer.cornerRadius = 8
//        
////        btn.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)
//        
//        //Layout
//        NSLayoutConstraint.activate(
//            NSLayoutConstraint.constraints(withVisualFormat: "|-16-[v0]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": btn])
//        )
//        
//        return v
//    }
//    
//    fileprivate func titleSectionView(title: String,width: CGFloat, height: CGFloat) -> UIView{
//        // Plan's title View.
//        let titleSectionView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
//                
////        let titleTF = UITextField()
//        titleSectionView.addSubview(titleTF)
//        
//        let titleLabel = UILabel()
//        titleLabel.text = "名称："
//
//        
//        titleSectionView.addSubview(titleLabel)
//        
//        titleTF.text = title
////        titleTF.placeholder = "请输入计划名称"
//        
//        
//        
//
//        titleTF.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
//        // Text style.
//        // ...
//        
//        // Label layout
////        titleTF.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[label]-0-[tf(tfWidth)]", options: NSLayoutConstraint.FormatOptions(), metrics: ["tfWidth": width*0.5], views: ["label": titleLabel, "tf": titleTF]))
//        
//        
//        NSLayoutConstraint.activate([
//            titleTF.centerYAnchor.constraint(equalTo: titleSectionView.centerYAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: titleSectionView.centerYAnchor)
//        ])
//        
//        return titleSectionView
//    }
//    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let numberOfSections = tableView.numberOfSections
//        
//        switch section {
//            
//        case 0:
//            // Show plan title.
//            return titleSectionView(title: plan!.name,width: tableView.frame.width, height: 50)
//            
//        case numberOfSections - 1:
//            // Show the add section button.
//            return addBtnSectionView(tableView)
//
//        default:
//            let title = plan?.sectionList[section-1].sport.name
//            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderCellId)
//            cell?.textLabel?.text = title
//        
//            
//            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
//            cell?.addSubview(btn)
//            btn.setImage(UIImage(named: "close"), for: .normal)
//            btn.translatesAutoresizingMaskIntoConstraints = false
//            btn.centerYAnchor.constraint(equalTo: cell!.centerYAnchor).isActive = true
//            btn.rightAnchor.constraint(equalTo: cell!.rightAnchor, constant: -20).isActive = true
//            
//            btn.tag = section
////            btn.addTarget(self, action: #selector(deletSectionAction), for: .touchUpInside)
//            
//            return cell
//            
//            // Show the plan section details.
////            return planSectionView(title: title!, tableView)
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        let numberOfRowsInSection = tableView.numberOfSections
//        
//        switch section {
//        case 0, numberOfRowsInSection-1:
//            return 0
//        default:
//            if let count = plan?.sectionList[section-1].rowList.count {
//                // Section title and the add button.
//                return count + 2
//            }
//            return 2
//        }
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("textFieldDidEndEditing")
//    }
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print("textFieldDidBeginEditing")
//    }
//    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        print("textFieldShouldBeginEditing")
//        return true
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("textFieldShouldReturn")
//        return true
//    }
//    
//    
//    
//}
//
//
//

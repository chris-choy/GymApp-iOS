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
    let sectionHeaderCellId = "sectionHeaderCellId"
    
    var plan : PlanModel?
    
    var snapshotImageView : UIImageView?
    var selectedIndexPath: IndexPath?
    
//    var planModel: PlanModel?
    
    let planTitleTF: UITextField = {
        let tf = UITextField()
        tf.text = "PlanTitle"
        tf.translatesAutoresizingMaskIntoConstraints = false

        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "编辑计划"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PlanTableViewCell.self, forCellReuseIdentifier: tableCellId)
        tableView.register(AddButtonCell.self, forCellReuseIdentifier: addButtonCellId)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: sectionHeaderCellId)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        
        
        // Test.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAction))
        // Test end.
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(gestureRecognizer:)))
        tableView.addGestureRecognizer(longPress)
        
        
        
        // Test.
        
//        addPlanSection()
        
        // Test end.
        
        

    }
    
    // Test.
    @objc func editAction(){
        tableView.moveSection(3, toSection: 4)
    }
    // Test end.
    
    
    
    
    
// MARK: TableView Method.

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if let plan = plan {
            // One is for title, another is for the add Button.
            return plan.sectionList.count + 2
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let totalRow = tableView.numberOfRows(inSection: indexPath.section)
        switch indexPath.row {
        case 0:
//             The title row.
            let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId) as! PlanTableViewCell
            cell.setNumLabel.text = "组"
            cell.lastValueLabel.text = "上一次的记录"
            cell.valueTF.text = "数值"
            cell.valueTF.isEnabled = false
            cell.unitLabel.text = "单位"
            cell.timesTF.text = "次数"
            cell.timesTF.isEnabled = false
            cell.multiplicationSymbol.image = nil
//            cell.backgroundColor = .lightGray
            return cell
        case totalRow - 1:
            // The last row in the section.
            let cell = tableView.dequeueReusableCell(withIdentifier: addButtonCellId) as! AddButtonCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId) as! PlanTableViewCell
            if(plan?.sectionList.count != 0){
                cell.valueTF.text = String(plan!.sectionList[indexPath.section-1].rowList[indexPath.row-1].value)
                cell.timesTF.text = String(plan!.sectionList[indexPath.section-1].rowList[indexPath.row-1].times)
            } else {
                cell.valueTF.text = "-"
                cell.timesTF.text = "-"
            }
            cell.setNumLabel.text = String(indexPath.row)
            cell.lastValueLabel.text = "-"
            
            cell.valueTF.keyboardType = .numbersAndPunctuation
            // Set the layer.
            cell.valueTF.backgroundColor = UIColor(red: 209, green: 209, blue: 214)
            cell.valueTF.layer.cornerRadius = 8

            
            cell.unitLabel.text = plan?.sectionList[indexPath.section-1].unit
            
            cell.timesTF.keyboardType = .numbersAndPunctuation
            // Set the layer.
            cell.timesTF.backgroundColor = UIColor(red: 209, green: 209, blue: 214)
            cell.timesTF.layer.cornerRadius = 8
            
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

    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let numberOfSections = tableView.numberOfSections
        
        switch section {
            
        case 0:
            // Show plan title.
            return titleSectionView(title: plan!.name,width: tableView.frame.width, height: 50)
            
        case numberOfSections - 1:
            // Show the add section button.
            return addBtnSectionView(tableView)

        default:
            let title = plan?.sectionList[section-1].sport.name
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderCellId)
            cell?.textLabel?.text = title
        
            
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            cell?.addSubview(btn)
            btn.setImage(UIImage(named: "close"), for: .normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.centerYAnchor.constraint(equalTo: cell!.centerYAnchor).isActive = true
            btn.rightAnchor.constraint(equalTo: cell!.rightAnchor, constant: -20).isActive = true
            
            btn.tag = section
            btn.addTarget(self, action: #selector(deletSectionAction), for: .touchUpInside)
            
            return cell
            
            // Show the plan section details.
//            return planSectionView(title: title!, tableView)
        }
    }
    
    @objc func deletSectionAction(sender: UIButton){
        print("delete : \(sender.tag)")
        
        let alert = UIAlertController(title: "提示", message: "确定删除吗？", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "确定", style: .destructive, handler: { UIAlertAction in
//            print("yes")
            let sectionIndex = sender.tag-1
            
            // Update deleteAction's tag.
            if sender.tag+1 <= self.plan!.sectionList.count {
                for index in sender.tag+1 ... self.plan!.sectionList.count {
                    self.updateDeleteAction(section: index)
                }
            }
            
            self.plan!.sectionList.remove(at: sectionIndex)
            
            self.tableView.deleteSections(IndexSet(arrayLiteral: sender.tag), with: .fade)
            
        })
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: { UIAlertAction in
            print("cancel")
        })
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == tableView.numberOfRows(inSection: indexPath.section)-1){
            // The addRowButton pressed.
            plan?.sectionList[indexPath.section-1].rowList.append(PlanRowModel(
                setNum: indexPath.row,
                lastValue: 0,
                value: 0,
                times: 0))
            tableView.insertRows(at: [indexPath], with: .fade)
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRowsInSection = tableView.numberOfSections
        
        switch section {
        case 0, numberOfRowsInSection-1:
            return 0
        default:
            if let count = plan?.sectionList[section-1].rowList.count {
                // Section title and the add button.
                return count + 2
            }
            return 2
        }
    }
    
//MARK: View Method.
    
    fileprivate func titleSectionView(title: String,width: CGFloat, height: CGFloat) -> UIView{
            // Plan's title View.
            let titleSectionView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
                    
            let label = UILabel()
            titleSectionView.addSubview(label)
            
            label.text = title
            
            label.textAlignment = .center
            label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
            // Text style.
            // ...
            
            // Label layout
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": label]))
            label.centerYAnchor.constraint(equalTo: titleSectionView.centerYAnchor).isActive = true
            
            return titleSectionView
        }
        
        fileprivate func addBtnSectionView(_ tableView: UITableView) -> UIView? {
    //        let v = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
            let v = UIView()
            
            let btn = UIButton()
            v.addSubview(btn)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("添加运动", for: .normal)
            btn.backgroundColor = .systemBlue
            btn.layer.cornerRadius = 8
            
            btn.addTarget(self, action: #selector(addPlanSection), for: .touchUpInside)
            
            //Layout
            NSLayoutConstraint.activate(
                NSLayoutConstraint.constraints(withVisualFormat: "|-16-[v0]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": btn])
            )
            
            return v
        }
        
        
        
        fileprivate func planSectionView(title: String,_ tableView: UITableView) -> UIView? {
            // PlanSection View.
            let v = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
            v.backgroundColor = .clear
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            v.addSubview(label)
    //        label.text = "仰卧起坐"
            label.text = title
            label.textColor = .systemBlue
            
            // Layout.
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.centerYAnchor.constraint(equalTo: v.centerYAnchor),
                label.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 16)
            ])
            
            return v
        }
    
    
// MARK: Action Method
    
    @objc func addPlanSection(){
        present(presenter!.buildSportListView(sections: plan!.sectionList), animated: true, completion: nil)
    }
    
    func getSnapshotOfSection(tableView: UITableView, section: CGRect) -> UIImageView {

        UIGraphicsBeginImageContextWithOptions(tableView.bounds.size, false, 0.0)
        tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        
        // Set the section area.
        var rect = section
        rect.origin.x*=image.scale
        rect.origin.y*=image.scale
        rect.size.width*=image.scale
        rect.size.height*=image.scale
        
        
        print("originalImage:\(image)")
        
        // Crop
        let cropImage = UIImage(cgImage: image.cgImage!.cropping(to: rect)!, scale: image.scale, orientation: image.imageOrientation)
        print("crop: \(cropImage) ")
        
        let snapshot = UIImageView(image: cropImage)
        snapshot.layer.masksToBounds = false
        snapshot.layer.cornerRadius = 0.0
        snapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        snapshot.layer.shadowRadius = 5.0
        snapshot.layer.shadowOpacity = 0.4
        
        
        return snapshot
    }
    
    func hideSection(section: Int) {
        // Hide the Section Cell.
        let headerCell = tableView.headerView(forSection: section)
        
        headerCell?.alpha = 0
        
        
        for row in 0...tableView.numberOfRows(inSection: section) {
            let cell = tableView.cellForRow(at: IndexPath(row: row, section: section))
            cell?.alpha = 0
//            cell?.isOpaque = false
        }
    }
    
    func showSection(section: Int) {
        // Hide the Section Cell.
        let headerCell = tableView.headerView(forSection: section)
        headerCell?.alpha = 1
        for row in 0...tableView.numberOfRows(inSection: section) {
            let cell = tableView.cellForRow(at: IndexPath(row: row, section: section))
            cell?.alpha = 1
        }
    }
    
    fileprivate func updateDeleteAction(section: Int) {
        
        print("update: \(section)")
        
        // Reset the delete button action.
        var cell = tableView.headerView(forSection: section)
        var btns = cell?.subviews.filter{$0 is UIButton} as! [UIButton]
        if btns.count == 1 {
            
            
            if selectedIndexPath != nil {
                // Move row.
                btns[0].tag = section
            } else {
                // Delete row.
                btns[0].tag = btns[0].tag - 1
            }
        }
        
        if let selectedSection = selectedIndexPath {
            cell = tableView.headerView(forSection: selectedSection.section)
            btns = cell?.subviews.filter{$0 is UIButton} as! [UIButton]
            if btns.count == 1 {
                btns[0].tag = selectedIndexPath!.section
            }
        }
        
    }
    
    @objc func longPressAction(gestureRecognizer: UIGestureRecognizer) {
        
        let longpress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longpress.state
        let locationInView = longpress.location(in: self.tableView)
        
        // Get the indexPath on the section or row which was selected.
//        var locatedIndexPath = self.tableView.indexPathForRow(at: locationInView)
        var locatedIndexPath : IndexPath?
        
//        print("point:\(locationInView)")
         
        if locatedIndexPath == nil {
            for s in 1 ... tableView.numberOfSections-2{
                let sectionArea = tableView.rect(forSection: s)
                
                if locationInView.y > sectionArea.minY &&
                    locationInView.y < sectionArea.maxY {
//                    print("section\(s) yes")
                    locatedIndexPath = IndexPath(row: 0, section: s)
                }
                
            }
        }
        
        switch state {
        case .began:
            if locatedIndexPath != nil {
                let sectionArea = tableView.rect(forSection: locatedIndexPath!.section)
                
                // Test
                print("section\(locatedIndexPath?.section):\(sectionArea)")
                // Testend
                
                let imageView = getSnapshotOfSection(tableView: tableView, section: sectionArea)
                
                imageView.center = CGPoint(x: sectionArea.origin.x + sectionArea.width/2,
                                           y: sectionArea.origin.y + sectionArea.height/2)
                
                snapshotImageView = imageView
                selectedIndexPath = locatedIndexPath
                
                hideSection(section: selectedIndexPath!.section)
                
                
                tableView.addSubview(imageView)
            }
        case .changed:
            if let imageView = snapshotImageView {
                imageView.center.y = locationInView.y
            }
            
            if(locatedIndexPath != nil && selectedIndexPath != nil ) {
                if locatedIndexPath?.section != selectedIndexPath?.section {
                    
                    // Update datasource.
                    plan?.sectionList.swapAt(selectedIndexPath!.section-1, locatedIndexPath!.section-1)
                    
                    // Update tableview cell.
                    tableView.moveSection(selectedIndexPath!.section,
                    toSection: locatedIndexPath!.section)
                    hideSection(section: locatedIndexPath!.section)
                    
                    updateDeleteAction(section: locatedIndexPath!.section)
                    
                    // Reset the selectedIndexPath which is represented the section holded.
                    selectedIndexPath!.section = locatedIndexPath!.section
                }
            }
        default:
            snapshotImageView?.removeFromSuperview()
            if selectedIndexPath != nil {
                showSection(section: selectedIndexPath!.section)
            }
            selectedIndexPath = nil
            snapshotImageView = nil
        }
    }
    
    @objc func saveAction(){
//        let sectionCount = tableView.numberOfSections
        
        // Save planSection.
        for sectionIndex in 0...plan!.sectionList.count-1 {
            // Save planSection.
            // ...
            plan?.sectionList[sectionIndex].sectionIndex = Int16(sectionIndex)
            let rowsCount = plan!.sectionList[sectionIndex].rowList.count
            if( rowsCount != 0){
                for rowIndex in 0...rowsCount-1 {
                    let cell = tableView.cellForRow(at: IndexPath(row: rowIndex+1, section: sectionIndex+1)) as! PlanTableViewCell
                    // Save planRow.
                    print("section=\(sectionIndex), row=\(rowIndex)")
                    plan?.sectionList[sectionIndex].rowList[rowIndex].value = Float.init(cell.valueTF.text!)!
                    plan?.sectionList[sectionIndex].rowList[rowIndex].times = Int.init(cell.timesTF.text!)!
                }
            }
            
            if (presenter!.savePlan(plan: plan!)) {
                let alert = UIAlertController(title: "提示", message: "成功保存！", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                print("Save successful!")
            } else {
                let alert = UIAlertController(title: "提示", message: "保存失败！", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                print("Failed to save.")
            }
            
        }
    }
}


extension PlanCreateView: PlanCreateViewProtocol {
    func addSection(sections: [PlanSectionModel]) {
        
        plan?.sectionList.append(contentsOf: sections)
        tableView.reloadData()
        
//        if var plan = plan {
//            for s in sections {
//
//                // To see whether there are some section that already exist.
//                let exist = plan.sectionList.contains(where: {
//                    if s.sport.name == $0.sport.name {
//                        print("\(s.sport.name) 存在.")
//                        return true
//                    } else {
//                        return false
//                    }
//
//                })
//
//                print(s.sport.name)
//
//                if !exist {
//
//                    print("before:\(plan.sectionList.count)")
//
//                    self.plan?.sectionList.append(s)
//
//                    print("after:\(plan.sectionList.count)")
//
//                    tableView.reloadData()
//                } else {
//                    print("exists")
//                }
//            }
//        }
        
    }
    
    func loadData(data: Any) {
        if data is PlanModel{
            plan = data as? PlanModel
        } else {
            return
        }
    }
}

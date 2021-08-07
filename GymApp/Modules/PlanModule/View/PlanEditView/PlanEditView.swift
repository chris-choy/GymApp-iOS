//
//  PlanEditView.swift
//  GymApp
//
//  Created by Chris on 2020/6/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit
import Lottie

private let collectionCellId = "PlanCollectionViewCell"

class PlanEditView: UITableViewController, UITextFieldDelegate {
    
    
//    var presenter: PlanModulePresenterProtocol?
//    let listPresenter: PlanModulePresenterProtocol
    
    let listView: ForPlanEditViewProtocol
    
    
    let loadingAnimationView = LoadingAnimationView()
    
    
    let tableCellId = "tableCellId"
    let addButtonCellId = "addButtonCellId"
    let sectionHeaderCellId = "sectionHeaderCellId"
    let restTimeCellId = "restTimeCell"
    
    //test
    let testCellId = "a"
    //end
    

    @objc func dismissKeyboard(on: UIButton){
        view.endEditing(true)
    }
    
    var plan : PlanModel?
    
    var snapshotImageView : UIImageView?
    var selectedIndexPath: IndexPath?
    
    let titleTF: UITextField = {
        let tf = UITextField()
//        tf.text = "PlanTitle"
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return tf
    }()
    
//    init(listPresenter: PlanModulePresenterProtocol) {
//        self.listPresenter = listPresenter
//
//        super.init(nibName: nil, bundle: nil)
//    }
    
    init(plan: PlanModel, listView: ForPlanEditViewProtocol) {
        self.plan = plan
        self.listView = listView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLoadingAnimationView() {
        view.addSubview(loadingAnimationView)
        
//        let viewHeight: CGFloat = view.frame.size.height
//        let tableViewContentHeight: CGFloat = tableView.contentSize.height
//        let marginHeight: CGFloat = (viewHeight - tableViewContentHeight) / 2.0
        
        loadingAnimationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -self.topBarHeight),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoadingAnimationView()
        
        title = "编辑计划"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PlanTableViewCell.self, forCellReuseIdentifier: tableCellId)
        tableView.register(AddRowButtonCell.self, forCellReuseIdentifier: addButtonCellId)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: sectionHeaderCellId)
        tableView.register(RestTimeTableViewCell.self, forCellReuseIdentifier: restTimeCellId)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
    
        
        
    }

    
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
//            cell.valueTF.text = "数值"
            cell.valueTF.text = plan?.sectionList[indexPath.section-1].unit
            cell.valueTF.isEnabled = false
//            cell.unitLabel.text = "单位"
            
            cell.timesTF.text = "次数"
            cell.timesTF.isEnabled = false
            cell.multiplicationSymbol.image = nil
//            cell.backgroundColor = .lightGray
            return cell
            
        case totalRow - 1:
            
            // The last row in the section is the the button to add row.
            // The action of this button is in the tableView's disSelectRowAt.
            let cell = tableView.dequeueReusableCell(withIdentifier: addButtonCellId) as! AddRowButtonCell
            return cell
            
        default:
            
            if indexPath.row%2 != 0 {
                
                // PlanRow
                let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId) as! PlanTableViewCell
                cell.valueTF.delegate = self
                
                // test
                cell.valueTF.becomeFirstResponder()
                // testend.
                
                
                cell.timesTF.delegate = self
                cell.timesTF.becomeFirstResponder ()
                
                if(plan?.sectionList.count != 0){
                    let value = plan!.sectionList[indexPath.section-1].rowList[(indexPath.row-1)/2].value
                    let times = plan!.sectionList[indexPath.section-1].rowList[(indexPath.row-1)/2].times
                    
                    if (times == 0){
                        cell.timesTF.text = ""
                    } else {
                        cell.timesTF.text = "\(times)"
                    }
                    
                    if (value == 0){
                        cell.valueTF.text = ""
                    } else {
                        cell.valueTF.text = "\(value)"
                    }
                    
                } else {
                    cell.valueTF.text = "-"
                    cell.timesTF.text = "-"
                }
                cell.setNumLabel.text = "\((indexPath.row-1)/2+1)"
                
                cell.lastValueLabel.text = "-"
                
                cell.valueTF.keyboardType = .numbersAndPunctuation
                
                // Set the layer.
                cell.valueTF.backgroundColor = UIColor(red: 209, green: 209, blue: 214)
                cell.valueTF.layer.cornerRadius = 8

                cell.timesTF.keyboardType = .numbersAndPunctuation
                
                // Set the layer.
                cell.timesTF.backgroundColor = UIColor(red: 209, green: 209, blue: 214)
                cell.timesTF.layer.cornerRadius = 8
                
                return cell
            } else {
                // Rest Time Row
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "restTimeCell") as! RestTimeTableViewCell
//                cell.textField.text = "\(plan!.sectionList[indexPath.section-1].rowList[(indexPath.row-2)/2].restTime)"
                cell.textField.sec = plan!.sectionList[indexPath.section-1].rowList[(indexPath.row-2)/2].restTime

                return cell
            }
            
            
            
        
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
            btn.addTarget(self, action: #selector(deleteSectionAction), for: .touchUpInside)
            
            return cell
            
            // Show the plan section details.
//            return planSectionView(title: title!, tableView)
        }
    }
    
    @objc func deleteSectionAction(sender: UIButton){
        print("delete : \(sender.tag)")
        
        let alert = UIAlertController(title: "提示", message: "确定删除吗？", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "确定", style: .destructive, handler: { UIAlertAction in
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
            
            if var section = plan?.sectionList[indexPath.section-1] {
                section.rowList.append(PlanRowModel(
                                id: 0,
                                seq: (indexPath.row-1)/2+1,
                                lastValue: 0,
                                value: 0,
                                times: 0,
                                restTime: 0,
                                last_changed: 0,
                                plan_id: section.plan_id,
                                plan_section_id: section.id))
                
                let restTimeIndexPath = IndexPath(row: indexPath.row+1, section: indexPath.section)
                tableView.insertRows(at: [indexPath,restTimeIndexPath], with: .fade)
            }
            
//            // The addRowButton pressed.
//            plan?.sectionList[indexPath.section-1].rowList.append(PlanRowModel(
//                                                                    id: 0,
//                                                                    seq: (indexPath.row-1)/2+1,
//                                                                    lastValue: 0,
//                                                                    value: 0,
//                                                                    times: 0,
//                                                                    restTime: 0,
//                                                                    last_changed: 0,
//                                                                    plan_id: 0,
//                                                                    plan_section_id: 0))
            
            
            
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
//                return count + 2
                return 2*count + 2
            }
            return 2
        }
    }
    
//MARK: TextField Method.
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("tf 1: \(textField)")

    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("tf 2: ")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("tf 3")
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == titleTF{
            return (textField.text?.count ?? 0) + string.count - range.length <= 11
        } else {
            return true
        }
        
    }
    
    
    
    
    
    
//MARK: View Method.
    
    @objc func titleTFEditAction(){
        print("titleTFEditAction")
        
        plan?.name = titleTF.text!
        print("name: \(plan?.name)")
        
    }
    
    fileprivate func titleSectionView(title: String,width: CGFloat, height: CGFloat) -> UIView{
        // Plan's title View.
        let titleSectionView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
                
//        let titleTF = UITextField()
        titleSectionView.addSubview(titleTF)
        
        let titleLabel = UILabel()
        titleLabel.text = "名称："
        
        titleSectionView.addSubview(titleLabel)
        
        titleTF.text = title
        titleTF.placeholder = "请输入计划名称"
        
        titleTF.addTarget(self, action: #selector(titleTFEditAction), for: .editingDidEnd)
        
        titleTF.delegate = self
        

        titleTF.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        // Text style.
        // ...
        
        // Label layout
//        titleTF.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[label]-0-[tf(tfWidth)]", options: NSLayoutConstraint.FormatOptions(), metrics: ["tfWidth": width*0.5], views: ["label": titleLabel, "tf": titleTF]))
        
        
        NSLayoutConstraint.activate([
            titleTF.centerYAnchor.constraint(equalTo: titleSectionView.centerYAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleSectionView.centerYAnchor)
        ])
        
        return titleSectionView
    }
        
    fileprivate func addBtnSectionView(_ tableView: UITableView) -> UIView? {

        let v = UIView()
        
        let btn = UIButton()
        v.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("添加运动", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 8
        
        btn.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)
        
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
    
    @objc func addBtnAction(){
        //
//        present(presenter!.buildSportListView(sections: plan!.sectionList), animated: true, completion: nil)
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
        var locatedIndexPath : IndexPath?
                 
        if locatedIndexPath == nil {
            for s in 1 ... tableView.numberOfSections-2{
                let sectionArea = tableView.rect(forSection: s)
                
                if locationInView.y > sectionArea.minY &&
                    locationInView.y < sectionArea.maxY {
                    locatedIndexPath = IndexPath(row: 0, section: s)
                }
                
            }
        }
        
        switch state {
        case .began:
            if locatedIndexPath != nil {
                let sectionArea = tableView.rect(forSection: locatedIndexPath!.section)
                
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
        
        plan?.name = titleTF.text!
        
        if plan!.sectionList.count > 0 {
            
            
            for sectionIndex in 0...plan!.sectionList.count-1 {
                // Save planSection.
                // Processing the data.

                let rowsCount = plan!.sectionList[sectionIndex].rowList.count
                if( rowsCount != 0){
                    for rowIndex in 0...rowsCount-1 {
                        let cell = tableView.cellForRow(at: IndexPath(row: rowIndex*2+1, section: sectionIndex+1)) as! PlanTableViewCell
                        // Save planRow.
                        plan?.sectionList[sectionIndex].rowList[rowIndex].value = Float.init(cell.valueTF.text!)!
                        plan?.sectionList[sectionIndex].rowList[rowIndex].times = Int.init(cell.timesTF.text!)!
                        
                        // Get the restTime.
                        let restCell = tableView.cellForRow(at: IndexPath(row: rowIndex*2+2, section: sectionIndex+1)) as! RestTimeTableViewCell
                        plan?.sectionList[sectionIndex].rowList[rowIndex].restTime = restCell.textField.sec
                    }
                }
            }
        }
        
        setupLoadingAnimationView()
        
        loadingAnimationView.show()
        
        listView.savePlan(planModel: plan!)
        
        // Output the plan json string.
//        do {
//            let data = try JSONEncoder().encode(plan)
//            let str = String(data: data, encoding: .utf8)
//            print("\(str)")
//
////            saveSuccessfully()
//            saveError()
//
//            print("  ")
//            // Send the json to presenter and get the response plan from server.
//
//
//        } catch {
//            print(error)
//        }
        
        
        
        /*
        // Saving operation. (Save to CoreData)
        // Change. (2021/0709)
        if plan?.objectId == nil {
            // Create new plan.
            
            // Update the name.
            plan?.name = titleTF.text!
            
//            plan?.sectionList[0].rowList

            // Saving the new plan.
            if let result = presenter?.createPlan(plan: plan!) {
                plan = result
                tableView.reloadData()
                
                // Dismiss and tell the list to reload.
                self.dismiss(animated: true, completion: nil)
                listPresenter.showAllPlans()
                
            }
        } else {
            // Updating the plan.
            if (presenter!.savePlan(plan: plan!)) {
//                let alert = UIAlertController(title: "提示", message: "成功保存！", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
////                present(alert, animated: true, completion: nil)
//                print("Save successful!")
                
                
                // Dismiss and tell the list to reload.
                self.dismiss(animated: true, completion: nil)
                listPresenter.showAllPlans()
                
                
            } else {
                let alert = UIAlertController(title: "提示", message: "保存失败！", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                print("Failed to save.")
            }
        }
         */
        
    }
}


extension PlanEditView {
    
    
    public func saveSuccessfully(){
        loadingAnimationView.hide()
        
//        AnimationView = .init(name:"loading-animation")
        
        let successAnimation = AnimationView(name: "success-animation")
        
//        tableView.addSubview(<#T##view: UIView##UIView#>)
        
        view.addSubview(successAnimation)
        successAnimation.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            successAnimation.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 0.4),
            successAnimation.heightAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 0.4),
            successAnimation.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            successAnimation.centerYAnchor.constraint(equalTo: tableView.centerYAnchor,constant: -topBarHeight),
        ])
        

        
        
        successAnimation.play { finish in
            if(finish){
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
//        navigationController?.popViewController(animated: true)
        
    }
    
    public func showSaveError(){
        
        loadingAnimationView.hide()
        
        let alert = UIAlertController(title: "提示", message: "保存出错，请稍后重试。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func addSection(sections: [PlanSectionModel]) {
        plan?.sectionList.append(contentsOf: sections)
        tableView.reloadData()
    }
    
//    func loadData(data: Any) {
//        if data is PlanModel{
//            plan = data as? PlanModel
//        } else {
//            return
//        }
//    }
    
    
}


extension UITableViewController {
    var topBarHeight: CGFloat {
        var top = self.navigationController?.navigationBar.frame.height ?? 0.0
        if #available(iOS 13.0, *) {
            top += UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            top += UIApplication.shared.statusBarFrame.height
        }
        return top
    }
}

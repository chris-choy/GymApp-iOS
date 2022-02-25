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

class InputErrorMessageHandler {
    
    enum DataType {
        case value
        case times
    }
    
    struct ErrorMessage {
        let rowIndex : Int
        let sectionIndex: Int
        let type: DataType
        var message: String
    }
    
    
    var errorList : [ErrorMessage] = []
    
    func addError(row: Int, section: Int, type: DataType, message: String){
        if let errorIndex = errorList.firstIndex(
            where: {$0.rowIndex==row && $0.type == type && $0.sectionIndex==section }) {
            errorList[errorIndex].message = message
        } else {
            errorList.append(ErrorMessage(rowIndex: row, sectionIndex: section, type: type, message: message))
        }
    }
    
    func cleanError(rowIndex: Int, sectionIndex: Int , type: DataType){
        if let errorIndex = errorList.firstIndex(
            where: {$0.rowIndex==rowIndex && $0.type == type && $0.sectionIndex==sectionIndex}) {
            errorList.remove(at: errorIndex)
        }
    }
    
    func isThereError() -> String? {
        return errorList.first?.message
    }
    
}

class PlanEditView: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    let listView: ForPlanEditViewProtocol
    let loadingAnimationView = LoadingAnimationView()

    let tableCellId = "tableCellId"
    let addButtonCellId = "addButtonCellId"
    let sectionHeaderCellId = "sectionHeaderCellId"
    let restTimeCellId = "restTimeCell"

    @objc func dismissKeyboard(on: UIButton){
        view.endEditing(true)
    }
    
    var plan : PlanModel?
    
    var snapshotImageView : UIImageView?
    var selectedIndexPath: IndexPath?
    
    var errorMessage = InputErrorMessageHandler()
    
    let dataPickerView = UIPickerView()
    
    let titleTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    
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

        loadingAnimationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -self.topBarHeight),
        ])
        
        loadingAnimationView.accessibilityElementsHidden = true
        
    }
    
    fileprivate func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PlanTableViewCell.self, forCellReuseIdentifier: tableCellId)
        tableView.register(AddRowButtonCell.self, forCellReuseIdentifier: addButtonCellId)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: sectionHeaderCellId)
        tableView.register(RestTimeTableViewCell.self, forCellReuseIdentifier: restTimeCellId)
        
        dataPickerView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupToHideKeyboardOnTapOnView()
        
        setupLoadingAnimationView()
        
        title = "编辑计划"
        
        setupTableView()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        
    }

    
// MARK: TableView Method.

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if let plan = plan {
            // One is for title, another is for the add Button.
            var count = plan.sectionList.count
            
            count += 1 // PlanName Section.
            count += 1 // Add Sport Button Section.
            count += 1 // Delete Sport Button Section.
            
            return count
        }
        return 0
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let totalRow = tableView.numberOfRows(inSection: indexPath.section)
        switch indexPath.row {
        case 0:
            //The title row.
            
            let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId) as! PlanTableViewCell
            cell.setNumLabel.text = "组"
            cell.lastValueLabel.text = "上一次的记录"
            cell.valueTF.text = plan?.sectionList[indexPath.section-1].unit
            cell.valueTF.isEnabled = false
            
            cell.timesTF.text = "次数"
            cell.timesTF.isEnabled = false
            cell.multiplicationSymbol.image = nil
            cell.deleteBtn.isHidden = true
            cell.deleteBtn.isUserInteractionEnabled = false
            
//            cell.backgroundColor = .lightGray
            return cell
            
        case totalRow - 1:
            // The last row in the section is the the button for adding row.
            // The button's action is in the tableView's disSelectRowAt.
            
            let cell = tableView.dequeueReusableCell(withIdentifier: addButtonCellId) as! AddRowButtonCell
            return cell
            
        default:
            // Plan's Data row.
            
            if indexPath.row%2 != 0 {
                
                // sectionIndex for secion in plan.
                // rowIndex for row in section.
                let rowIndex = (indexPath.row-1)/2
                let sectionIndex = indexPath.section-1
                
                // PlanRow
                let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId) as! PlanTableViewCell
                cell.valueTF.delegate = self
                cell.valueTF.textContentType = .telephoneNumber
                cell.timesTF.delegate = self
                cell.timesTF.setupTimesInputView()
                cell.timesTF.textContentType = .telephoneNumber
                
                cell.valueTF.rowIndex = rowIndex
                cell.valueTF.sectionIndex = sectionIndex
                cell.timesTF.rowIndex = rowIndex
                cell.timesTF.sectionIndex = sectionIndex

                if(plan?.sectionList.count != 0){
                    let value = plan!.sectionList[sectionIndex].rowList[rowIndex].value
                    let times = plan!.sectionList[sectionIndex].rowList[rowIndex].times
                    
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
                cell.setNumLabel.text = "\(rowIndex+1)"
                
                cell.lastValueLabel.text = "-"
                
                cell.valueTF.keyboardType = .decimalPad
                
                // Set the layer.
                cell.valueTF.backgroundColor = UIColor(red: 209, green: 209, blue: 214)
                cell.valueTF.layer.cornerRadius = 8
                
                // Set the layer.
                cell.timesTF.backgroundColor = UIColor(red: 209, green: 209, blue: 214)
                cell.timesTF.layer.cornerRadius = 8
                
                // Set the delete row btn.
                cell.deleteBtn.indexPath = indexPath
                cell.deleteBtn.addTarget(self, action: #selector(deleteRowAction), for: .touchUpInside)
                
                return cell
            } else {
                // Rest Time Row
                
                let restTimeCell = tableView.dequeueReusableCell(withIdentifier: "restTimeCell") as! RestTimeTableViewCell

                restTimeCell.textField.sec = plan!.sectionList[indexPath.section-1].rowList[(indexPath.row-2)/2].restTime
                restTimeCell.textField.sectionIndex = indexPath.section-1
                restTimeCell.textField.rowIndex = (indexPath.row-2)/2
                restTimeCell.textField.delegate = self

                return restTimeCell
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
            
        case numberOfSections - 2:
            // Show the add section button.
            return addBtnSectionView(tableView)
        case numberOfSections - 1:
            return deletePlanView(tableView)
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
            
        }
    }
    
    fileprivate func deleteSection(sectionIndex: Int){
        // Update button's tag.
        if sectionIndex+1 <= self.plan!.sectionList.count {
            for index in sectionIndex+1 ... self.plan!.sectionList.count {
                self.updateDeleteSectionBtn(section: index)
            }
        }
        
        self.plan!.sectionList.remove(at: sectionIndex)
        
        self.tableView.deleteSections(IndexSet(arrayLiteral: sectionIndex+1), with: .fade)
    }
    
    @objc func deleteSectionAction(sender: UIButton){
        print("delete : \(sender.tag)")
        
        let alert = UIAlertController(title: "提示", message: "确定删除吗？", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "确定", style: .destructive, handler: { UIAlertAction in
            self.deleteSection(sectionIndex: sender.tag-1)
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
            
            // Action for adding plan row.
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
                
                plan?.sectionList[indexPath.section-1] = section
                
                let restTimeIndexPath = IndexPath(row: indexPath.row+1, section: indexPath.section)
                tableView.insertRows(at: [indexPath,restTimeIndexPath], with: .fade)
            }

        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRowsInSection = tableView.numberOfSections
        
        switch section {
        case 0, numberOfRowsInSection-1, numberOfRowsInSection-2:
            return 0
        default:
            if let count = plan?.sectionList[section-1].rowList.count {
                // Section title and the add button.
                return 2*count + 2
            }
            return 2
        }
    }
    
//MARK: PickerView Methods.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row+1)"
    }
    
//MARK: TextField Method.
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("tf 1: \(textField)")
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("tf 2: ")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("textFieldDidEndEditing")
        
        // 1. Set name.
        
        
        // 2. Set value and times.
        if textField is TextFieldWithIndex {
            
            let tf = textField as! TextFieldWithIndex
            
            let rowIndex = tf.rowIndex
            let sectionIndex = tf.sectionIndex
            var message = ""
            switch tf.dataType {
            case .value:
                
                if let value = Float(tf.text!){
                    if value <= 0 {
                        showAlert(message: "请输入一个大于0的数。")
                        tf.text = ""
                        plan?.sectionList[tf.sectionIndex].rowList[tf.rowIndex].value = value
                        return
                    }
                    plan?.sectionList[tf.sectionIndex].rowList[tf.rowIndex].value = value
                } else {
                    showAlert(message: "数值输入有误，请重新输入。")
                    tf.text = ""
                    plan?.sectionList[tf.sectionIndex].rowList[tf.rowIndex].value = 0
                }
                
            case .times:
                if let times = Int(tf.text!){
                    plan?.sectionList[tf.sectionIndex].rowList[tf.rowIndex].times = times
                    errorMessage.cleanError(rowIndex: rowIndex,
                                            sectionIndex: sectionIndex,
                                            type: .times)
                    return
                } else {
                    message = "\(plan!.sectionList[sectionIndex].sport.name)的第\(rowIndex+1)组运动次数不符合规则，\n请填写一个正整数。"
                    errorMessage.addError(row: rowIndex,
                                          section: sectionIndex,
                                          type: .times,
                                          message: message)
                }
            
            }
        }
        
        // 3. Set rest time.
        if textField is CountDownTextField {
            let tf = textField as! CountDownTextField
            plan?.sectionList[tf.sectionIndex].rowList[tf.rowIndex].restTime = tf.sec
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("tf 3")
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard textField.markedTextRange == nil else {return true}
        
        let canChange = (textField.text?.count ?? 0) + string.count - range.length <= 11
        
        if !canChange && string.isEmpty {
            // string="" when user pressed delete button on keyboard.
            // We allow delete text when the length of text is over,
            // but can't allow append text.
            return true
        } else {
            return canChange
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
    
    fileprivate func deletePlanView(_ tableView: UITableView) -> UIView? {

        let v = UIView()
        
        let btn = UIButton()
        v.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("删除计划", for: .normal)
        btn.backgroundColor = .systemRed
        btn.layer.cornerRadius = 8
        
        btn.addTarget(self, action: #selector(delBtnAction), for: .touchUpInside)
        
        //Layout
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "|-16-[v0]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": btn])
        )
        
        return v
    }
    
    @objc func delBtnAction(){
        print("del")
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
        present(listView.buildSportListView(sections: plan!.sectionList),animated: true, completion: nil)
    }
    
    @objc func deleteRowAction(sender: CustomDeleteButton){
        /*
          section and row are the index for the Cell.
          sectionIndex and rowIndex are the indexs for the plan.
         ------------------------------------------------------------
          seciton = sectionIndex+1    ->    sectionIndex = section-1
          row = 2*rowIndex+1          ->    rowIndex = (row-1)/2
         */
        
        let rowIndex = (sender.indexPath.row-1)/2
        let sectionIndex = sender.indexPath.section-1
        
        // The last one row in the section.
        if plan?.sectionList[sectionIndex].rowList.count == 1 {
            let alert = UIAlertController(title: "提示", message: "每个运动至少需要一组数据，是否继续删除？", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "确认", style: .destructive) { action in
                // Delete section.
                self.deleteSection(sectionIndex: sectionIndex)
            }
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(cancel)
            alert.addAction(confirm)
            
            present(alert, animated: true, completion: nil)
        } else {
            // 1. update the sender's indexPath and cell's seq.
            // indexPath after rowIndex forward 1 step.
            if(rowIndex != plan!.sectionList[sectionIndex].rowList.count-1){
                // Not the latest one in the rowList.
                // Otherwise there's no need to do the operation below.
                for r in rowIndex+1 ... plan!.sectionList[sectionIndex].rowList.count-1 {
                    // sender's indexPath.
                    let cell = tableView.cellForRow(at: IndexPath(row: 2*r+1, section: sectionIndex+1)) as! PlanTableViewCell
                    cell.deleteBtn.indexPath.row -= 2

                    // cell's seq.
                    if let seq = Int(cell.setNumLabel.text ?? "0") {
                        cell.setNumLabel.text = "\(seq-1)"
                    }
                }

            }

            // 2. delete the row in plan data.
            plan?.sectionList[sectionIndex].rowList.remove(at: rowIndex)

            // 3. delete the row in tableView.
            let restTimeCell = IndexPath(row: sender.indexPath.row+1, section: sender.indexPath.section)
            tableView.deleteRows(at: [sender.indexPath, restTimeCell], with: .bottom)
        }

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
    
    fileprivate func updateDeleteSectionBtn(section: Int) {

        var cell = tableView.headerView(forSection: section)
        var btns = cell?.subviews.filter{$0 is UIButton} as! [UIButton]
        
        if let selectedSection = selectedIndexPath {
            // For move section operation.
            cell = tableView.headerView(forSection: selectedSection.section)
            btns = cell?.subviews.filter{$0 is UIButton} as! [UIButton]
            if btns.count == 1 {
                btns[0].tag = selectedSection.section
            }
        } else {
            // For delete section operation.
            if btns.count == 1 {
                btns[0].tag = btns[0].tag - 1
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
                    
                    updateDeleteSectionBtn(section: locatedIndexPath!.section)
                    
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
        
        // 1. Check name.
        if(plan?.name.count == 0){
            showAlert(message: "请输入运动名称。")
            return
        }
        
        // 2. Check value and times.
        for s in 0 ..< plan!.sectionList.count {
            let section = plan!.sectionList[s]
            for r in 0 ..< section.rowList.count {
                let row = section.rowList[r]
                if (row.value == 0) {
                    showAlert(message: "请填写\(section.sport.name)中第\(r+1)组的数值数据。")
                    return
                }
                if (row.times == 0){
                    showAlert(message: "请填写\(section.sport.name)中第\(r+1)组的运动次数。")
                    return
                }
            }
        }

        setupLoadingAnimationView()
        
        loadingAnimationView.show()
        
        listView.savePlan(planModel: plan!)
        
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确认", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

extension PlanEditView {
    
    public func saveSuccessfully(){
        
        loadingAnimationView.hide()
        
        let successAnimation = AnimationView(name: "success-animation")

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
                successAnimation.removeFromSuperview()
                self.navigationController?.popToRootViewController(animated: true)
            }
        }

    }
    
    public func showSaveError(){
        
        loadingAnimationView.hide()
        
        let alert = UIAlertController(title: "提示", message: "保存出错，请稍后重试。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

    func addSection(sections: [PlanSectionModel]) {
        // Set the seq in section.
        var varSections = sections
        var count = plan!.sectionList.count
        for s in 0 ..< varSections.count {
            varSections[s].seq = Int16(count + 1)
            count = count + 1
        }
        plan?.sectionList.append(contentsOf: varSections)
        tableView.reloadData()
    }
    
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
    
    func setupToHideKeyboardOnTapOnView(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UITableViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
}

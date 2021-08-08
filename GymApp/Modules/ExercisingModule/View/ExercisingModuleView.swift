//
//  ExercisingModuleView.swift
//  GymApp
//
//  Created by Chris on 2020/8/24.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class ExercisingModuleView: UIViewController {
    
    var presenter: ExercisingModulePresenterProtocol?
    
    var currentRow: Int = 0
    
    var groupTimeArray : [Int] = []
    
    var isHighlighted : [[Bool]] = []
    
    var recordModel: RecordModel
    
    init(planModel: PlanModel) {
        self.planModel = planModel
        
        // Initiate the record according to the plan.
        self.recordModel = RecordModel(planName: planModel.name,
                                       date: Date(),
                                       totalTime: 0,
                                       recordSectionList: [])
        
//        detailCell = DetailCellView(exercisingModuleView: self)
        
        detailCell = DetailCellView()
        
        super.init(nibName: nil, bundle: nil)
        
        
        
//        detailCell = DetailCellView(exercisingModuleView: self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let planModel : PlanModel
    
//    var planModel : PlanModel = {
//
//        let row1 = PlanRowModel(setNum: 1,
//                                lastValue: 0,
//                                value: 15,
//                                times: 8)
//
//        let row2 = PlanRowModel(setNum: 2,
//                                lastValue: 0,
//                                value: 16,
//                                times: 8)
//
//        let row3 = PlanRowModel(setNum: 3,
//                                lastValue: 0,
//                                value: 15,
//                                times: 8)
//
//        let row4 = PlanRowModel(setNum: 4,
//                                lastValue: 0,
//                                value: 16,
//                                times: 8)
//
//        let section1 = PlanSectionModel(sectionIndex: 0,
//                                        unit: "kg",
//                                        rowList: [row1,row2,row3,row4],
//                                        sport: SportModel(name: "侧平举",
//                                                          unit: SportUnitModel(name: "kg", sportNames: nil)))
//
//        let row5 = PlanRowModel(setNum: 1,
//                                lastValue: 0,
//                                value: 5,
//                                times: 8)
//
//        let row6 = PlanRowModel(setNum: 2,
//                                lastValue: 0,
//                                value: 5,
//                                times: 10)
//
//        let section2 = PlanSectionModel(sectionIndex: 1,
//                                        unit: "kg",
//                                        rowList: [row5,row6],
//                                        sport: SportModel(name: "双哑铃前平举",
//                                                          unit: SportUnitModel(name: "kg", sportNames: nil)))
//
//        let row7 = PlanRowModel(setNum: 1,
//                                lastValue: 0,
//                                value: 8,
//                                times: 8)
//
//        let row8 = PlanRowModel(setNum: 2,
//                                lastValue: 0,
//                                value: 8,
//                                times: 10)
//
//        let row9 = PlanRowModel(setNum: 3,
//                                lastValue: 0,
//                                value: 8,
//                                times: 10)
//
//        let section3 = PlanSectionModel(sectionIndex: 2,
//                                        unit: "kg",
//                                        rowList: [row7,row8,row9],
//                                        sport: SportModel(name: "双哑铃侧平举",
//                                                          unit: SportUnitModel(name: "kg", sportNames: nil)))
//
//        let sectionList = [section1, section2, section3]
//
//        let model = PlanModel(
//            objectId: nil,
//            name: "Plan!!!",
//            sectionList:sectionList)
//
//        return model
//    }()
    
    let schedualCellId = "schedualCellId"
    
    let timeCell : TimeCellView = {
        let cell = TimeCellView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()
    
    let schedualCell : SchedualView = {
        let cell = SchedualView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.allowsSelection = false
        return cell
    }()
    
//    let detailCell : DetailCellView = {
//        let cell = DetailCellView(exercisingModuleView: )
//        cell.translatesAutoresizingMaskIntoConstraints = false
//        return cell
//    }()
    
//    var detailCell : DetailCellView?
    
    let detailCell : DetailCellView

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        navigationItem.title = "aa"
        
//        navigationController?.navigationBar.topItem?.title = "锻炼"
        title = "锻炼"
        
        view.backgroundColor = .white
        setupViews()
        setupViewConstraint()
        updateDetailView()
        setupDetailCell()
        
        //test
        
        for sec in planModel.sectionList {
            var boolArray : [Bool] = []
            for _ in sec.rowList {
                boolArray.append(false)
            }
            
            isHighlighted.append(boolArray)
        }
        
        isHighlighted[0][0] = true
        
        //testend.
        
        
    }
    
    

// MARK: Setup & initiate.
    func setupDetailCell() {
        detailCell.exercisingModuleView = self
    }
    
    
    
    
    
    func setupViews() {
//        detailCell = DetailCellView(exercisingModuleView: self)
        detailCell.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailCell)
        
        
        view.addSubview(timeCell)
        setupSchedualCell()
        
        
        
        
        
    }
    
    fileprivate func setupSchedualCell() {
        view.addSubview(schedualCell)
        schedualCell.delegate = self
        schedualCell.dataSource = self
//        schedualCell.register(UITableViewCell.self, forCellReuseIdentifier: schedualCellId)
        schedualCell.register(SchedualTableViewCell.self, forCellReuseIdentifier: schedualCellId)
        
        // test.
        schedualCell.layer.borderWidth = 1
        timeCell.layer.borderWidth = 1
        detailCell.layer.borderWidth = 1
        
        schedualCell.allowsSelection = true
        
        // end.
    }
    
    func setupViewConstraint(){

        // Calculate the time&schedual size.
        let screenWidth = UIScreen.main.bounds.width
        let padding = CGFloat(20)
        let tsWidth = (screenWidth - padding*3)/2
        
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (navigationController?.navigationBar.frame.height ?? 0.0)
        
//        let titleBarHeight = navigationController!.navigationBar.frame.height
        
//        let tabBarHeight = self.tabBarController?.tabBar.frame.height
        
        
        // tabBar
        
        let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? CGFloat(0)
        
        // Calculate the detailCell size.
//        let screenHeight = UIScreen.main.bounds.height
        let screenHeight = view.frame.height
        let detailHeight = screenHeight - topBarHeight - tabBarHeight - tsWidth - 3*padding
        let detailWidth = screenWidth - 2*padding

        let mertics = ["top": topBarHeight+padding,
                       "tsWidth": tsWidth,
                       "tsHeight": tsWidth,
                       "detailHeight": detailHeight,
                       "detailWidth": detailWidth,
                       "padding": padding]
        let viewDict = ["time":timeCell,
                        "schedual":schedualCell,
                        "detail": detailCell]
        
        
        NSLayoutConstraint.activate([
            schedualCell.heightAnchor.constraint(equalTo: timeCell.heightAnchor),
            schedualCell.centerYAnchor.constraint(equalTo: timeCell.centerYAnchor)
        ])
        
        // Vertical.
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[time(tsHeight)]-padding-[detail(detailHeight)]", options: NSLayoutConstraint.FormatOptions(), metrics: mertics, views: viewDict))
        
        // Honrizontal.
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[time(tsWidth)]-padding-[schedual(==time)]-padding-|", options: NSLayoutConstraint.FormatOptions(), metrics: mertics, views: viewDict))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[detail(detailWidth)]-padding-|", options: NSLayoutConstraint.FormatOptions(), metrics: mertics, views: viewDict))
    
    }
    
    func updateRowHightLight(){
        
        // Dishighlighted all the row.
        for sec in 0...schedualCell.numberOfSections-1 {
            for row in 0...schedualCell.numberOfRows(inSection: sec)-1 {
                schedualCell.cellForRow(at: IndexPath(row: row, section: sec))?.imageView?.isHidden = true
            }
        }
        
        
        // Update the new row.
        if let indexPath = getIndexPath(currentRow) {
            schedualCell.cellForRow(at: indexPath)?.imageView?.isHidden = false
        }
    
    }
    
    func updateDetailView(){
        
        if let index = getIndexPath(currentRow){
            detailCell.titleLabel.text = planModel.sectionList[index.section].sport.name
            detailCell.valueTF.text = "\(planModel.sectionList[index.section].rowList[index.row].value)"
            detailCell.unitLabel.text = planModel.sectionList[index.section].sport.name
            detailCell.timesLabel.text = "\(planModel.sectionList[index.section].rowList[index.row].times)"
        }
        
    }
    
    func getIndexPath(_ currentRow: Int) -> IndexPath? {
        // Get the data's indexPath accroding to the index of row(currentRow) in the UI.
        
        var row = currentRow
        var section = 0
        for sec in planModel.sectionList {
            if(row-sec.rowList.count < 0){
                return IndexPath(row: row, section: section)
            } else {
                row = row-sec.rowList.count
                section += 1
            }
        }
        
        return nil
    }

}

// MARK: SchedualCell TableView Delegate.

extension ExercisingModuleView: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        var rowCount = 0
//
//        for section in planModel.sectionList {
//            rowCount += section.rowList.count
//        }
//
//        return rowCount
        
        
        
        return planModel.sectionList[section].rowList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = schedualCell.dequeueReusableCell(withIdentifier: schedualCellId)
        
        let section = planModel.sectionList[indexPath.section]
        let row = section.rowList[indexPath.row]
        
        cell?.textLabel?.text = "\(row.value) \(section.unit) × \(row.times)"
        cell?.imageView?.image = UIImage(named: "right-arrow")
        
        // Set the imageView highlight
        cell?.imageView?.isHidden = !isHighlighted[indexPath.section][indexPath.row]
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
//        updateRowHightLight()
        
//        print(cell.isSelected,indexPath)
//        if(indexPath.row == 2) {
//            cell.imageView?.isHidden = false
//        }
//        if (cell.isHighlighted) {
//            cell.imageView?.isHidden = false
//        } else {
//            cell.imageView?.isHidden = true
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return planModel.sectionList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return schedualCell.frame.height/5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return planModel.sectionList[section].sport.name
    }
    
    
    
    
    
}

extension ExercisingModuleView: ExercisingModuleViewForOtherViewProtocol{
    func skipAction() {
        
        
        // Make a empty RecordRow.
        createEmptyRecordRowModel()
        
        
        // Update the UI.
        updateUIForNextRow()
        
        
        
        // test
//        updateRowHightLight()
        
        print("skip")
        
        // test end
    }
    
    func createEmptyRecordRowModel(){
        if let indexPath = getIndexPath(currentRow) {
            
            // Create new RecordSection on the first row in a section.
            if indexPath.row == 0 {
                
                let sport = planModel.sectionList[indexPath.section].sport
                recordModel.recordSectionList.append(RecordSectionModel(sportName: sport.name,
                                                                        sportUnit: sport.unit,
                                                                        recordRowList: []))
            }
            
            let rowModel = RecordRowModel(costTime: 0, times: 0, value: 0)
            recordModel.recordSectionList[indexPath.section].recordRowList.append(rowModel)

        }
    }
    
    func createRecordRowModel(){
        // ***********************************************************************
        // isEmpty: The empty record is whose costTime attitude ie equal to 0.
        // ***********************************************************************
        
        // Make a RecordRow.
        if let indexPath = getIndexPath(currentRow) {
            
            // Create new RecordSection on the first row in a section.
            if indexPath.row == 0 {
                
                let sport = planModel.sectionList[indexPath.section].sport
                recordModel.recordSectionList.append(RecordSectionModel(sportName: sport.name,
                                                                        sportUnit: sport.unit,
                                                                        recordRowList: []))
            }
            
            if let timesText = detailCell.timesLabel.text,
               let valueText = detailCell.valueTF.text
            {
                if let times = Int(timesText),
                   let value = Float(valueText)
                {
                    let rowModel = RecordRowModel(costTime: timeCell.groupSeconds, times: times, value: value)
                    recordModel.recordSectionList[indexPath.section].recordRowList.append(rowModel)
                }
                
            }

        }
        
    }
    
    fileprivate func updateUIForNextRow() {
        // Cancel the current row highlight.
        if let indexPath = getIndexPath(currentRow) {
            isHighlighted[indexPath.section][indexPath.row] = false
            schedualCell.cellForRow(at: indexPath)?.imageView?.isHidden = true
        }
        
        currentRow += 1
        
        // Update the cells.
        if let indexPath = getIndexPath(currentRow) {
            
            // Update the Schdual View.
            isHighlighted[indexPath.section][indexPath.row] = true
            schedualCell.cellForRow(at: indexPath)?.imageView?.isHidden = false
            schedualCell.selectRow(at: getIndexPath(currentRow), animated: true, scrollPosition: .middle)
            
            // Update Time view.
            groupTimeArray.append(timeCell.groupSeconds)
            timeCell.startNextGroupTimer()
            
            // Update Detail View
            updateDetailView()
            
        } else {
            // Finish.
            
            // Add the total time into the RecordModel.
            recordModel.totalTime = timeCell.totalSeconds
            
            
            // test
            print("finish in updateUIForNextRow")
            
            print("------------------------------------------------------------------------")
            print(recordModel)
            
            finishAction()
            
            print("------------------------------------------------------------------------")
            // test end.
            
        }
    }
    
    func nextAction() {
        
        // Make a record of the exercising.
        createRecordRowModel()
        
        // Update UI.
        updateUIForNextRow()
        
    }
    
    func finishAction() {
        // 如果还没到最后就结束 且需要保存记录，则为后面的各个row创建empty record row。
        // ...
        
        
        
        // 保存记录
        if (presenter?.createRecord(model: recordModel) == true) {
            print("success.")
        } else {
            print("faild.")
        }
    }
    
    
}


protocol ExercisingModuleViewForOtherViewProtocol {
    func skipAction()
    func nextAction()
    func finishAction()
}




extension ExercisingModuleView: ExercisingModuleViewProtocol {
    
}

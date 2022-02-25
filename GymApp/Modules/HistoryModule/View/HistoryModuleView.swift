//
//  HistoryModuleView.swift
//  GymApp
//
//  Created by Chris on 2020/10/31.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class HistoryModuleView: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var presenter: HistoryModulePresenterProtocol?
    
    var recordModels:[RecordModel] = []
    
    let recordCellId = "recordCellId"
    
    let testDetailText = ["1111\n2222\n333\n4\n5\n6","1111\n2222\n3333\n4444"]
    
    let loadingAnimationView = LoadingAnimationView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "历史"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Load data.
        getAllRecords()
        
        setupView()
        setupRrefreshControl()
        
        collectionView.register(RecordCell.self, forCellWithReuseIdentifier: recordCellId)
    }
    
    func setupView(){
        collectionView.backgroundColor = UIColor(red: 246, green: 249, blue: 255)
        setupLoadingAnimationView()
    }
    
    func setupRrefreshControl(){
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "下拉更新历史数据")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        collectionView.refreshControl = refreshControl
        
    }
    
    @objc func refresh(){
        print("refresh")
        getAllRecords()
    }
    
    fileprivate func setupLoadingAnimationView() {
        view.addSubview(loadingAnimationView)
        
        loadingAnimationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recordModels.count
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        let recordModel = recordModels[indexPath.row]
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recordCellId, for: indexPath) as! RecordCell
        cell.titleLabel.text = "\(recordModel.planName)"
        
        // Format date information.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        cell.dateLabel.text = "\(dateFormatter.string(from: recordModel.date))"
        
        // Format the total time seconds to time string.
        let timeFormatter = DateComponentsFormatter()
        timeFormatter.allowedUnits = [.hour, .minute, .second]
        timeFormatter.unitsStyle = .brief
        let formattedString = timeFormatter.string(from: TimeInterval(recordModel.totalTime))!
        cell.timeLabel.text = "\(formattedString)"
        
        // Format detail text.
        cell.detailLabel.text = "运动列表"
        for section in recordModel.recordSectionList {
            cell.detailLabel.text?.append("\n\(section.recordRowList.count) × \(section.sportName)")
        }
        
        return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recordCellId, for: indexPath) as! RecordCell
        
        if recordModels.count > 0 {
            // Fetch the detail text from the record model.
            let recordModel = recordModels[indexPath.row]
            var text = "运动列表"
            for section in recordModel.recordSectionList {
                text.append("\n\(section.recordRowList.count) × \(section.sportName)")
            }
            
            // Estimate the height of text.
            let estimatedHeight = NSString(string: text).boundingRect(
                with: CGSize(width: view.frame.width-4*10, height: 1000),
                options: .usesLineFragmentOrigin,
                attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)],
                context: nil)
            
            // Return the cell's basic height and estimatedHeight as the cell's height.
            return CGSize(
                width: view.frame.width-20,
                height: cell.getBasicHeight() + estimatedHeight.height
            )
        } else {
            return CGSize.zero
        }
        
    }
    
    func getAllRecords(){
        presenter?.getAllRecords()
    }
    
}

extension HistoryModuleView: HistoryModuleViewProtocol {
    
    func showRecords(records: [RecordModel]) {
        recordModels = records
        
        collectionView.reloadData()
        print("endRefreshing")
        collectionView.refreshControl?.endRefreshing()
    }
    
    func showErrorAlert(){
        let alert = UIAlertController(title: "提示", message: "读取数据出错", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

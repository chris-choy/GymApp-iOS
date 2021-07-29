//
//  HistoryModuleView.swift
//  GymApp
//
//  Created by Chris on 2020/10/31.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class HistoryModuleView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//class HistoryModuleView: UICollectionViewController {
    
    var presenter: HistoryModulePresenterProtocol?
    
    var recordModels:[RecordModel] = []
    
    let recordCellId = "recordCellId"
    
    let testDetailText = ["1111\n2222\n333\n4\n5\n6","1111\n2222\n3333\n4444"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "历史"
        
        // Load data.
        recordModels = presenter!.loadRecordData()
        
        
        /*
        // test
        
        
        let label = UILabel()
        label.text = "History Module."
        view.addSubview(label)
        label.frame = CGRect(x: 0, y: 0, width: label.intrinsicContentSize.width, height: 50)
        label.center = view.center
        // testend
        */
        
        setupView()
        
//        view.backgroundColor = .black
        
        
        /*
        // 测试cell的动态高度
        let customFlowLayout = CustomFlowLayout()
        customFlowLayout.sectionInsetReference = .fromContentInset // .fromContentInset is default
        customFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        customFlowLayout.minimumInteritemSpacing = 10
        customFlowLayout.minimumLineSpacing = 10
        customFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        customFlowLayout.headerReferenceSize = CGSize(width: 0, height: 40)
        
        
        
        collectionView.collectionViewLayout = customFlowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        
        // end
         */
        
        
        collectionView.register(RecordCell.self, forCellWithReuseIdentifier: recordCellId)
    }
    
    func setupView(){
        collectionView.backgroundColor = UIColor(red: 246, green: 249, blue: 255)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//        return recordModels.count
        return recordModels.count
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
         // 调试ui使用
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recordCellId, for: indexPath) as! RecordCell
        
//        cell.titleLabel.text = "row=\(indexPath.row),section=\(indexPath.section)"
        
//        cell.detailLabel.text = "row=\(indexPath.row), section=\(indexPath.section)"
        
        
        
        
        /*
        cell.titleLabel.text = "title"
        cell.dateLabel.text = "date"
        cell.timeLabel.text = "time"
        
        
 
        cell.detailLabel.text = testDetailText[indexPath.row]
        */
                
        let recordModel = recordModels[indexPath.row]
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recordCellId, for: indexPath) as! RecordCell
        cell.titleLabel.text = "\(recordModel.planName)"
        
        
        // Format date information.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年mm月dd日"
        cell.dateLabel.text = "\(dateFormatter.string(from: recordModel.date))"
        
        // Format the total time seconds to time string.
        let timeFormatter = DateComponentsFormatter()
        timeFormatter.allowedUnits = [.hour, .minute, .second]
        timeFormatter.unitsStyle = .brief
        let formattedString = timeFormatter.string(from: TimeInterval(1000))!
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
    
    

}

extension HistoryModuleView: HistoryModuleViewProtocol {
    
}

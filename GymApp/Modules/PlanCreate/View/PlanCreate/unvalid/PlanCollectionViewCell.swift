//
//  PlanCollectionViewCell.swift
//  GymApp
//
//  Created by 大金兒 on 23/6/2020.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit

// MARK: CollectionViewCell

class PlanCollectionViewCell : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let planDetailCellId = "PlanDetailTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "仰卧起坐"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        // Set the label style.
        
//        label.layer.cornerRadius = 8
//        label.clipsToBounds = true
        
        return label
    }()
    
    let cellCollectionView: UICollectionView={
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false

        return cv
    }()
    
    let addButton: UIButton = {
        let btn = UIButton(type: .contactAdd)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .cyan
        btn.layer.cornerRadius = 8
        
        return btn
    }()
    
//    var collectionView = UICollectionView()
    
    func setupViews(){
        self.backgroundColor = .red
//        self.layer.cornerRadius = 10
        
        // Set the titleLabel.
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0(50)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":titleLabel]))
        
        // Set the tableView.
        addSubview(cellCollectionView)
        cellCollectionView.dataSource = self
        cellCollectionView.delegate = self
        cellCollectionView.register(PlanDetailCollectionViewCell.self, forCellWithReuseIdentifier: planDetailCellId)
        cellCollectionView.backgroundColor = .lightGray
        
        // Set the addButton
        addSubview(addButton)
        addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalTo: cellCollectionView.widthAnchor, multiplier: 0.5).isActive = true
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellCollectionView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1]-10-[v0]-[v2]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellCollectionView, "v1": titleLabel, "v2": addButton]))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: planDetailCellId, for: indexPath) as! PlanDetailCollectionViewCell

        if(indexPath.section == 0){
            // Set the columns' title.
            cell.setNumLabel.text = "组"
            cell.lastValueLabel.text = "上一次记录"
            cell.valueLabel.text = "数值"
            cell.unitLabel.text = "单位"
            cell.timesLabel.text = "次数"
            cell.multiplicationSymbol.image = nil
            cell.backgroundColor = .lightGray
        }
        else{
            // Set every colums' value.
            cell.setNumLabel.text = "1"
            cell.lastValueLabel.text = "50"
            cell.valueLabel.text = "35"
            cell.unitLabel.text = "kg"
            cell.timesLabel.text = "3"
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Just use to cal the text's height.
        let label = UILabel()
        label.text = "example"
        
        
        
        return CGSize(width: collectionView.frame.width, height: label.intrinsicContentSize.height + 10.adjust())
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Int{
    
    static var ratio : CGFloat = 0.0
    
    func adjust() -> CGFloat{
        print(UIDevice.current.model)
        
        if(Int.ratio == 0.0){
            print("yes")
            Int.ratio = 1.1
        }
        else{
            print("no,\(Int.ratio)")
        }
        
        return CGFloat(self)
    }
    
}


//
//  PlanCollcetionCell.swift
//  GymApp
//
//  Created by Chris on 2020/7/6.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit

class PlanCollcetionCell: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.gymFont(size: .PlanCollectionCellTitle, bold: true)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let detailText: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.gymFont(size: .PlanCollectionCellDetail, bold: false)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 5
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail

        return label
    }()
    
    func setupViews(){
        backgroundColor = UIColor(named: "PlanListCellBackground")
        
        self.layer.cornerRadius = 8
        
        addSubview(nameLabel)
        addSubview(detailText)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: PlanCollcetionCell.padding),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant:   PlanCollcetionCell.padding),
            detailText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: PlanCollcetionCell.padding),
            detailText.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
        
    }
    
    private static var padding = CGFloat(15)
    
    
    static func basicHeight() -> CGFloat {
        
        // 1. Top.
        // 2. Bottom.
        // 3. Padding between nameLabel and detailTextLabel.
        let height = padding * 3
        
        return height
    }
    
    static func getHeight(planModel: PlanModel) -> CGFloat {
        
        // 1. Get the title from planModel.
        let title = planModel.name
        let titleHeight = title.height(withConstrainedWidth: 500, font: UIFont.gymFont(size: .PlanCollectionCellTitle, bold: false))
        
        // 2. Get the detail text from planModel.
        var detail = ""
        for (index, section) in planModel.sectionList.enumerated(){
            detail.append("\(section.sport.name) * \(section.rowList.count)")
            if (index != planModel.sectionList.endIndex-1){
                detail.append("\n")
            }
        }
        let detailHeight = detail.height(withConstrainedWidth: 500, font: UIFont.gymFont(size: .PlanCollectionCellDetail, bold: false))

        return padding*3 + titleHeight + detailHeight
    }

}

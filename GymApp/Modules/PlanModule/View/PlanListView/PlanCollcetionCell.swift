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
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 64).isActive = true
        image.widthAnchor.constraint(equalToConstant: 64).isActive = true
        image.backgroundColor = Color.darkBackground.value
        return image
    }()
    
    let contentText: UILabel = {
        let label = UILabel()
        label.text = "xxxxxxx"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 5
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        return label
    }()
    
    func setupViews(){
        backgroundColor = Color.intermidiateBackground.value
        
        self.layer.cornerRadius = 8
        
        addSubview(nameLabel)
        addSubview(imageView)
        addSubview(contentText)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 15),
            nameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant:   15),
            contentText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            contentText.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
        
    }
    
}

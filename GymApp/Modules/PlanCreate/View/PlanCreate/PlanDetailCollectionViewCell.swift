//
//  PlanDetailCollectionViewCell.swift
//  GymApp
//
//  Created by 大金兒 on 23/6/2020.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit

class PlanDetailCollectionViewCell: UICollectionViewCell{
    
    var setNumLabel: UILabel = {
        let label = UILabel()
        label.text = "99"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textAlignment = .center
        
        // Calculate the text max size.
        label.maxSizeOfText(text: "99")
        
        return label
    }()

    var unitLabel: UILabel = {
       let label = UILabel()
//        label.text = "kgxxx"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        label.textAlignment = .center
        
        // Calculate the text max size.
        label.maxSizeOfText(text: "单位")
        
        return label
    }()

    var valueLabel: UILabel = {
       let label = UILabel()
        label.text = "数值"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        label.textAlignment = .center
        label.maxSizeOfText(text: "数值")
        
        return label
    }()

    var timesLabel: UILabel = {
       let label = UILabel()
        label.text = "999"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        
        label.maxSizeOfText(text: "次数")
     
        return label
    }()
    
    var multiplicationSymbol: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(imageLiteralResourceName: "cross")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return iv
    }()
    
    var lastValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .yellow
        label.textAlignment = .center
        
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
//        backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupViews(){
        addSubview(setNumLabel)
        addSubview(lastValueLabel)
        addSubview(unitLabel)
        addSubview(timesLabel)
        addSubview(multiplicationSymbol)
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            setNumLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            lastValueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            unitLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timesLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            multiplicationSymbol.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            (valueLabel).centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[v0]-16-[v1]-[v2]-8-[v3]-[v4(16)]-[v5]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":setNumLabel,"v1":lastValueLabel , "v2":valueLabel, "v3":unitLabel, "v4":multiplicationSymbol,"v5":timesLabel]))
        
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":setNumLabel,"v1":lastValueLabel , "v2":valueLabel, "v3":unitLabel, "v4":multiplicationSymbol,"v5":timesLabel]))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "[v2]-8-[v3]-[v4(16)]-[v5]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":setNumLabel,"v1":lastValueLabel , "v2":valueLabel, "v3":unitLabel, "v4":multiplicationSymbol,"v5":timesLabel]))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "[v0]-16-[v1]-16-[v2]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":setNumLabel,"v1":lastValueLabel , "v2":valueLabel, "v3":unitLabel, "v4":multiplicationSymbol,"v5":timesLabel]))
        
        
 
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-[v0]-[v1]-[v2]-[v3]-[v4(16)]-[v5]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":setNumLabel,"v1":lastValueLabel , "v2":valueLabel, "v3":unitLabel, "v4":multiplicationSymbol,"v5":timesLabel]))
        
        
        
    }
    
}

extension UILabel {
    
    // To calculate the longgest text's size.
    func maxSizeOfText(text: String){
        self.textAlignment = .center
        
        // Cal the text size
        self.text = text
        let size = self.intrinsicContentSize
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: size.width),
            self.heightAnchor.constraint(equalToConstant: size.height)
        ])

    }
}

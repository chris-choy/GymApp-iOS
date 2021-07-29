//
//  PlanTableviewCell.swift
//  GymApp
//
//  Created by Chris on 2020/6/24.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit


class PlanTableViewCell: UITableViewCell {
    
    var setNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .white
        label.textAlignment = .center
        
        // test
        label.layer.borderWidth = 1
        // testend
        
        
        // Calculate the text max size.
        label.text = "99"
        label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width).isActive = true
        label.text = ""
        
        return label
        }()
    
    /*
    var unitLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        
        // test
        label.layer.borderWidth = 1
        // testend
        
        // Calculate the text max size.
//        label.maxSizeOfText(text: "单位")
        
        return label
    }()
    */
    
    
    var valueTF: UITextField = {
       let tf = UITextField()
//        tf.text = "数值"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        
        // To calculate the max size.
        tf.text = "  数值  "
        tf.sizeToFit()
        tf.widthAnchor.constraint(equalToConstant: tf.frame.width).isActive = true
        
        // Set the layer.
//        tf.backgroundColor = .systemGray
//        tf.layer.cornerRadius = 8
        
        tf.placeholder = "数值"
        
        
        // test
        tf.layer.borderWidth = 1
        // testend
        
        return tf
    }()

    var timesTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
//        tf.backgroundColor = .green
        tf.textAlignment = .center
        
        // To Calculate the max size of the
        tf.text = "  次数  "
        tf.placeholder = "次数"
        tf.sizeToFit()
        tf.widthAnchor.constraint(equalToConstant: tf.frame.width).isActive = true
        
        
        // test
        tf.layer.borderWidth = 1
        // testend
     
        return tf
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
//        label.backgroundColor = .yellow
        label.textAlignment = .center
        
        
        // Calculate the width.
        label.text = "  上一次的记录  "
        label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width).isActive = true
        label.text = ""

        
        
        // test
        label.layer.borderWidth = 1
        // testend
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
        selectionStyle = .none
        
        contentView.addSubview(setNumLabel)
        contentView.addSubview(lastValueLabel)
//        contentView.addSubview(unitLabel)
        contentView.addSubview(timesTF)
        contentView.addSubview(multiplicationSymbol)
        contentView.addSubview(valueTF)
        
        
        NSLayoutConstraint.activate([
            setNumLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            lastValueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            unitLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timesTF.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            multiplicationSymbol.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            (valueTF).centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[v0]-16-[v1]-16-[v2]-8-[v4(16)]-[v5]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":setNumLabel,"v1":lastValueLabel , "v2":valueTF, "v4":multiplicationSymbol,"v5":timesTF]))
    
    }
    
}

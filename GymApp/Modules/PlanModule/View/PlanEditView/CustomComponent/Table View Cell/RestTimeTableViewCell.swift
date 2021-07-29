//
//  RestTimeTableViewCell.swift
//  GymApp
//
//  Created by Chris on 2020/10/22.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class RestTimeTableViewCell: UITableViewCell {
    
    /*
    let textField : UITextField = {
        let tf = UITextField()
        
        tf.translatesAutoresizingMaskIntoConstraints = false
//        tf.textContentType = .none
        tf.isEnabled = true
        
        tf.layer.borderWidth = 1
        
        return tf
    }()
     */
    
    let textField : CountDownTextField = {
        let tf = CountDownTextField()
        
        tf.translatesAutoresizingMaskIntoConstraints = false
//        tf.textContentType = .none
        tf.isEnabled = true
        
        
        tf.text = "11分钟11秒"
        tf.widthAnchor.constraint(equalToConstant: tf.intrinsicContentSize.width).isActive = true
        tf.text = "0秒"
        
        
        
        tf.textAlignment = .center
        
        tf.layer.borderWidth = 1
        
        return tf
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
        selectionStyle = .none
        
        contentView.addSubview(textField)
                
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        
        
        
        
    }
    
}

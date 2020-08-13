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
        
        // Calculate the text max size.
        label.maxSizeOfText(text: "99")
        
        return label
        }()

    var unitLabel: UILabel = {
       let label = UILabel()
//        label.text = "kgxxx"
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .green
        label.textAlignment = .center
        
        // Calculate the text max size.
        label.maxSizeOfText(text: "单位")
        
        return label
    }()

    var valueTF: UITextField = {
       let tf = UITextField()
//        tf.text = "数值"
        tf.translatesAutoresizingMaskIntoConstraints = false
//        tf.backgroundColor = .green
        tf.textAlignment = .center
        
        // To calculate the max size.
        tf.text = "  数值  "
        tf.sizeToFit()
        tf.widthAnchor.constraint(equalToConstant: tf.frame.width).isActive = true
        
        // Set the layer.
//        tf.backgroundColor = .systemGray
//        tf.layer.cornerRadius = 8
        
        
        return tf
    }()

    var timesTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
//        tf.backgroundColor = .green
        tf.textAlignment = .center
        
        // To Calculate the max size of the
        tf.text = "  次数  "
        tf.sizeToFit()
        tf.widthAnchor.constraint(equalToConstant: tf.frame.width).isActive = true
     
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
//        label.maxSizeOfText(text: "  上一次的记录  ")
        
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
        
//        backgroundColor = .orange
        
        selectionStyle = .none
        
        addSubview(setNumLabel)
        addSubview(lastValueLabel)
        addSubview(unitLabel)
        addSubview(timesTF)
        addSubview(multiplicationSymbol)
        addSubview(valueTF)
        
        NSLayoutConstraint.activate([
            setNumLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            lastValueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            unitLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timesTF.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            multiplicationSymbol.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            (valueTF).centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":setNumLabel,"v1":lastValueLabel , "v2":valueTF, "v3":unitLabel, "v4":multiplicationSymbol,"v5":timesTF]))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[v0]-16-[v1]-16-[v2]-8-[v3]-[v4(16)]-[v5]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":setNumLabel,"v1":lastValueLabel , "v2":valueTF, "v3":unitLabel, "v4":multiplicationSymbol,"v5":timesTF]))
        
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "[v0]-16-[v1]-16-[v2]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":setNumLabel,"v1":lastValueLabel , "v2":valueTF, "v3":unitLabel, "v4":multiplicationSymbol,"v5":timesTF]))
    }
    
}

class AddButtonCell: UITableViewCell {
    
    let buttonImage: UIImageView = {
//        let btn = UIImage(type: .contactAdd)
//        btn.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(image: UIImage(named: "add"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(view)
        view.backgroundColor = .systemTeal
        view.layer.cornerRadius = 8
        
        selectionStyle = .none
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-16-[v0]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": view]))
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            view.widthAnchor.constraint(equalTo: self.widthAnchor),
            view.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        
        setupButton()
    }
    
    fileprivate func setupButton() {
        view.addSubview(buttonImage)
//        buttonImage.backgroundColor = .systemYellow
//        buttonImage.layer.cornerRadius = 8
        
//        button.addTarget(self, action: #selector(addSport), for: .touchUpInside)
        
        
        // Layout
        NSLayoutConstraint.activate([
            buttonImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonImage.widthAnchor.constraint(equalToConstant: 24),
            buttonImage.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
//    @objc func addSport(){
//        print("add")
//
//    }
}

//
//  DetailCellView.swift
//  GymApp
//
//  Created by Chris on 2020/9/12.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit

class DetailCellView : UIView {
    
    var exercisingModuleView : ExercisingModuleViewForOtherViewProtocol?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "仰卧起坐"
        
        return label
    }()
    
    @objc let skipButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("跳过", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        
        return btn
    }()
    
    let nextButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("next", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        
        return btn
    }()
    
    let finishButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("结束", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        
        return btn
    }()
    
    let valueTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        tf.keyboardType = .decimalPad
        
        // Calculate the max size.
        tf.text = "111111"
        tf.sizeToFit()
        tf.widthAnchor.constraint(equalToConstant: 85).isActive = true
        
        // View.
//        tf.layer.borderWidth = 1
        tf.textAlignment = .center
        tf.layer.cornerRadius = 8
        tf.backgroundColor = Color.lightBackground.value
        
        
        return tf
    }()
    
    var unitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center

        return label
    }()
    
    let timesTF : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        tf.layer.cornerRadius = 8
        tf.backgroundColor = Color.lightBackground.value
        
        tf.textAlignment = .center
        
        tf.widthAnchor.constraint(equalToConstant: 85).isActive = true

        return tf
    }()
    
    let timesLabel : UILabel = {
        let label = UILabel()
        label.text = "次"
        
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    
    
    init() {
        super.init(frame: CGRect.zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//#MARK: Method
    
    func setupView() {
        
        self.layer.cornerRadius = 8
        
        setValuesFontStyle(name: "Helvetica Neue", size: 25)
        setTitleLabel()
        setupButtons()
        setupValues()
        
    }
    
    func setTitleLabel(){
        addSubview(titleLabel)
        
        // Constraint.
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        ])
    }
    
    @objc func skipAction() {
        if let exercisingModuleView = exercisingModuleView {
            exercisingModuleView.skipAction()
        } else {
            print("Error: exercisingModuleView is nil.")
        }
        
    }
    @objc func nextAction() {
        if let exercisingModuleView = exercisingModuleView {
            exercisingModuleView.nextAction()
        } else {
            print("Error: exercisingModuleView is nil.")
        }
    }
    
    func setupButtons(){
        addSubview(skipButton)
        skipButton.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
        addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        addSubview(finishButton)
        
        // Height constraints.
        NSLayoutConstraint.activate([
            skipButton.heightAnchor.constraint(equalTo: skipButton.widthAnchor),
            nextButton.heightAnchor.constraint(equalTo: nextButton.widthAnchor),
            finishButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            skipButton.bottomAnchor.constraint(equalTo: finishButton.topAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: finishButton.topAnchor, constant: -20),
            finishButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
        
        // Width contraints.
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-20-[skip(==next)]-20-[next]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["skip":skipButton, "next":nextButton]))
        
        NSLayoutConstraint.activate([
            finishButton.leftAnchor.constraint(equalTo: skipButton.leftAnchor),
            finishButton.rightAnchor.constraint(equalTo: nextButton.rightAnchor)
        ])
    }
    
    func setupValues(){
        
        let valueStackView = UIStackView(arrangedSubviews: [valueTF,unitLabel,timesTF,timesLabel])
        addSubview(valueStackView)
        valueStackView.translatesAutoresizingMaskIntoConstraints = false
        valueStackView.axis = .horizontal
        valueStackView.spacing = 3
        valueStackView.setCustomSpacing(25, after: unitLabel)
        
        // Horizontal constraints.
        NSLayoutConstraint.activate([
            valueStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        // Vertical constraints.
        NSLayoutConstraint.activate([
            valueStackView.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -20)
        ])
        
    }
    
    func setValuesFontStyle(name: String,size: CGFloat){
        valueTF.font = UIFont(name: name, size: size)
        unitLabel.font = UIFont(name: name, size: size)
        timesTF.font = UIFont(name: name, size: size)
        timesLabel.font = UIFont(name: name, size: size)
    }
    
    func updateDetail(planRow: PlanRowModel){
        
    }
    
}

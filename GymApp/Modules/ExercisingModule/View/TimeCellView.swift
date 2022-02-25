//
//  TimeCellView.swift
//  GymApp
//
//  Created by Chris on 2020/9/12.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit

class TimeCellView : UIView {
    
    let totalTimeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica Neue", size: 21)
        return label
    }()
    
    let groupTimeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica Neue", size: 21)
        return label
    }()
    
    let totalTimeTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "总时间"
        label.font = UIFont(name: "Helvetica Neue", size: 23)
        return label
    }()
    
    let groupTimeTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "本组时间"
        label.font = UIFont(name: "Helvetica Neue", size: 23)
        return label
    }()
    
    var totalSeconds = -1
    var groupSeconds = -1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
        updateTotalTime()
        updateGroupTime()
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTotalTime), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateGroupTime), userInfo: nil, repeats: true)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startNextGroupTimer(){
        groupSeconds = -1
    }
    
    let stackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    @objc func updateTotalTime(){
        
        // Total time.
        totalSeconds = totalSeconds + 1
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        
        totalTimeLabel.text = formatter.string(from: TimeInterval(totalSeconds))
        
        if(totalSeconds <= 60) {
            totalTimeLabel.text?.append("秒")
        }

    }
    
    @objc func updateGroupTime(){
        
        // Total time.
        groupSeconds = groupSeconds + 1
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        
        groupTimeLabel.text = formatter.string(from: TimeInterval(groupSeconds))
        
        if(groupSeconds <= 60) {
            groupTimeLabel.text?.append("秒")
        }
        
    }
    
    
    func setupView() {
        
        addSubview(stackView)
        
        self.layer.cornerRadius = 8
        
        setupLabels()
        setupConstraints()
    }
    
    func setupLabels(){
        
        stackView.addArrangedSubview(totalTimeTitle)
        stackView.addArrangedSubview(totalTimeLabel)
        stackView.addArrangedSubview(groupTimeTitle)
        stackView.addArrangedSubview(groupTimeLabel)
        
        stackView.spacing = 0
        stackView.setCustomSpacing(15, after: totalTimeLabel)
        
    }
    
    func setupConstraints(){

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85)
        ])
                
    }
    
}

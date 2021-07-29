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

        return label
    }()
    
    let groupTimeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let totalTimeTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "总时间"
        return label
    }()
    
    let groupTimeTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "分组时间"
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
    
    
    func setupView() {
        
        self.layer.cornerRadius = 8
        
        totalTimeLabel.font = UIFont(name: "Helvetica Neue", size: 25)
        groupTimeLabel.font = UIFont(name: "Helvetica Neue", size: 25)
        
        setupLabels()
        setupConstraints()
    }
    
    func setupLabels(){
        self.addSubview(totalTimeTitle)
        self.addSubview(totalTimeLabel)
        self.addSubview(groupTimeLabel)
        self.addSubview(groupTimeTitle)
    }
    
    func setupConstraints(){
        
        
//        NSLayoutConstraint.activate([
//            totalTimeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            totalTimeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            setTimeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            setTimeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
//        ])
        
        NSLayoutConstraint.activate([
            totalTimeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            totalTimeTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            groupTimeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            groupTimeTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v1]-[v2]-[v3]-[v4]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1": totalTimeTitle, "v2": totalTimeLabel, "v3": groupTimeTitle, "v4": groupTimeLabel,]))
        
        
        // Title constraint.
//        NSLayoutConstraint.activate([
        //            totalTimeTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        //            totalTimeTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        //            setTimeTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        //            setTimeTitle.topAnchor.constraint(equalTo: totalTimeLabel.bottomAnchor, constant: 10),
        //        ])
                
                
    }
        
    public func te(){
        print("test")
    }
    
    @objc func updateTotalTime(){
        
        // Total time.
        totalSeconds = totalSeconds + 1
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        
        totalTimeLabel.text = formatter.string(from: TimeInterval(totalSeconds))
        
        if(totalSeconds <= 60) {
            totalTimeLabel.text?.append("s")
        }
        
        //
        
    }
    
    @objc func updateGroupTime(){
        
        // Total time.
        groupSeconds = groupSeconds + 1
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        
        groupTimeLabel.text = formatter.string(from: TimeInterval(groupSeconds))
        
        if(groupSeconds <= 60) {
            groupTimeLabel.text?.append("s")
        }
        
        //
        
    }
}

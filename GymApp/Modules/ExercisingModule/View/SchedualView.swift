//
//  SchedualView.swift
//  GymApp
//
//  Created by Chris on 2020/9/12.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit


class SchedualView : UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {

        self.layer.cornerRadius = 8
        
    }
    
}






class SchedualTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        let image = UIImage(named: "right-arrow")
        imageView?.image = image
    }
    
    func setupConstraints(){
        
        if let imageView = imageView ,
           let textLabel = textLabel {
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 24)
            ])
            
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-10-[v1(24)]-10-[v2]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1":imageView, "v2":textLabel]))
            
        }
        
    }
    
}



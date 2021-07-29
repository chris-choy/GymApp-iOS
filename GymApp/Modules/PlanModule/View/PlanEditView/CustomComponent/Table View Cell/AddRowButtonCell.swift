//
//  AddRowButtonCell.swift
//  GymApp
//
//  Created by Chris on 2020/10/10.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class AddRowButtonCell: UITableViewCell {
    
    let buttonImage: UIImageView = {
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
            view.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        
        setupButton()
    }
    
    fileprivate func setupButton() {
        view.addSubview(buttonImage)
        
        // Layout
        NSLayoutConstraint.activate([
            buttonImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonImage.widthAnchor.constraint(equalToConstant: 24),
            buttonImage.heightAnchor.constraint(equalToConstant: 24),
        ])
    
        // The action of this button is in the tableView's disSelectRowAt.
    }
    
}

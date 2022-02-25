//
//  ProfileDetailsCellTableViewCell.swift
//  GymApp
//
//  Created by Chris on 2021/5/22.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit

class ProfileDetailsCellTableViewCell: UITableViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        setupViews()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        
        iv.image = UIImage(named: "billgates.jpeg")
        
        // View.
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        
        // test
        label.layer.borderWidth = 1
        // test end.
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        backgroundColor = .cyan
        
        addSubview(photoImageView)
        addSubview(nameLabel)
        
//        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 150),
            photoImageView.heightAnchor.constraint(equalToConstant: 150),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20)
        ])
        
        
        
    }

}



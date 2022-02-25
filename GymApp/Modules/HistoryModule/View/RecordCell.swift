//
//  RecordCollectionViewCell.swift
//  GymApp
//
//  Created by Chris on 2020/11/1.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class RecordCell: UICollectionViewCell {
    
    let lineHeight = CGFloat(20)
    let titleHeight = CGFloat(30)
    let padding = CGFloat(10)
    
    let titleLabel : UILabel = {
        let label = UILabel()
        
        label.text = "全身训练"

        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        
        label.text = "2020年11月3日"
        
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    
    let timeImageView : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "clock"))
        
        return iv
    }()
    
    let dateImageView : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "calendar"))
        
        return iv
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "52min"
        return label
    }()
    
    let timeStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        return sv
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        return sv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// #MARK: Setting Methods.
    fileprivate func setShadowLayer() {
        // layer shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    func setupViews(){

//        layer.borderWidth = 1
        layer.cornerRadius = 8
        backgroundColor = .white

        // Use autolayout.
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(dateImageView)
        addSubview(timeImageView)
        addSubview(timeLabel)
        addSubview(detailLabel)
        
        // TitleLabel.
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            titleLabel.heightAnchor.constraint(equalToConstant: titleHeight),
            titleLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        
        // Date Label.
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: padding),
            dateImageView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            dateImageView.heightAnchor.constraint(equalToConstant: lineHeight),
            dateImageView.widthAnchor.constraint(equalToConstant: lineHeight)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: dateImageView.centerYAnchor),
            dateLabel.leftAnchor.constraint(equalTo: dateImageView.rightAnchor, constant: 5),
            dateLabel.heightAnchor.constraint(equalToConstant: lineHeight),
        ])
        
        // Time Label
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeImageView.centerYAnchor.constraint(equalTo: dateImageView.centerYAnchor),
            timeImageView.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: padding),
            timeImageView.heightAnchor.constraint(equalToConstant: lineHeight),
            timeImageView.widthAnchor.constraint(equalToConstant: lineHeight)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor),
            timeLabel.leftAnchor.constraint(equalTo: timeImageView.rightAnchor, constant: 5),
            timeLabel.heightAnchor.constraint(equalToConstant: lineHeight),
        ])
        
        // Detail Label.
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding),
            detailLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            detailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: padding)
        ])
        
        
        setShadowLayer()
        
        setupTextStyle()

    }
    
    
    
    func setupTextStyle(){

        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        detailLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        dateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        timeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
    }
    
    func setupStackView(){
        
        addSubview(timeStackView)
        
        // Time stackview.
        timeStackView.addArrangedSubview(dateLabel)
        timeStackView.addArrangedSubview(timeImageView)
        timeStackView.addArrangedSubview(timeLabel)

        addSubview(stackView)
    
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(timeStackView)
        stackView.addArrangedSubview(detailLabel)
        
        stackView.spacing = 5
        
    }
    
    func getBasicHeight() -> CGFloat {

        let detailHeight = CGFloat(0) // This height need to calculate with the deital text.
        
        let basicHeight = padding + titleHeight + padding + lineHeight + padding + detailHeight + padding
        
        return basicHeight
        
    }
    
    func setupDateLabel(){
        
        // Mix image and text in the label.
        
        let text = NSMutableAttributedString(string: "")
        
        let calendarAttachment = NSTextAttachment()
        calendarAttachment.image = UIImage(named: "calendar")
        calendarAttachment.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let date = NSAttributedString(string: " 2020年11月3日")
        
        text.append(NSAttributedString(attachment: calendarAttachment))
        text.append(date)
   
        dateLabel.attributedText = text
    }
    
    func setupTimeLabel(){
        
        timeLabel.text = "52min"
        
        if let image = timeImageView.image {
            
            let labelHeight = timeLabel.intrinsicContentSize.height
            
            timeImageView.image = image.resize(size: CGSize(width: labelHeight, height: labelHeight))
            
            timeImageView.contentMode = .center

        }
        
    }
    
}

extension UIImage {
    func resize(size: CGSize) -> UIImage {
        let originalSize = self.size

            let widthRatio  = size.width  / originalSize.width
            let heightRatio = size.height / originalSize.height

            // Figure out what our orientation is, and use that to form the rectangle
            var newSize: CGSize
            if(widthRatio > heightRatio) {
                newSize = CGSize(width: originalSize.width * heightRatio, height: originalSize.height * heightRatio)
            } else {
                newSize = CGSize(width: originalSize.width * widthRatio,  height: originalSize.height * widthRatio)
            }

            // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
            // Actually do the resizing to the rect using the ImageContext stuff
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            self.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage!
    }
}

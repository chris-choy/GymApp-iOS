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
        
//        label.layer.borderWidth = 1
        
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        
        label.text = "2020年11月3日"
        
       
        
//        label.layer.borderWidth = 1
        
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        
//        label.text = "运动列表\n1 × 单臂哑铃划船\n2 × 下腹抬腿"

        
        label.numberOfLines = 0
        label.sizeToFit()
        
//        label.layer.borderWidth = 1
        
        
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

//
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
//        addSubview(titleLabel)
//        addSubview(dateLabel)
//        addSubview(timeLabel)
//        addSubview(detailTextView)
//        setupStackView()
        
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
        
//        let att = dateLabel.attributedText
        
//        let estimateFrame = NSString("1111年11月11日").boundingRect(with: CGSize(width: 999, height: 20), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.: att], context: nil)
        
        NSLayoutConstraint.activate([
            dateImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: padding),
            dateImageView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            dateImageView.heightAnchor.constraint(equalToConstant: lineHeight),
            dateImageView.widthAnchor.constraint(equalToConstant: lineHeight)
        ])
        
//        dateLabel.font = UIFont.systemFont(ofSize: 15)
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: dateImageView.centerYAnchor),
            dateLabel.leftAnchor.constraint(equalTo: dateImageView.rightAnchor, constant: 5),
            dateLabel.heightAnchor.constraint(equalToConstant: lineHeight),
//            dateLabel.widthAnchor.constraint(equalToConstant: estimateFrame.width)
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
        
//        timeLabel.font = UIFont.systemFont(ofSize: 15)
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor),
            timeLabel.leftAnchor.constraint(equalTo: timeImageView.rightAnchor, constant: 5),
            timeLabel.heightAnchor.constraint(equalToConstant: lineHeight),
//            dateLabel.widthAnchor.constraint(equalToConstant: estimateFrame.width)
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
        
//        setupConstraints()
        
//        setupDateLabel()
//        setupTimeLabel()
    }
    
    func setupConstraints(){
        
        // StackView
//        NSLayoutConstraint.activate([
//            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -2*padding),
//            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -2*padding),
//            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
//        ])
        
        
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
//        stackView.addArrangedSubview(dateLabel)
//        stackView.addArrangedSubview(timeLabel)
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
        
        
        
//        label.attributedText = text
        
        dateLabel.attributedText = text
    }
    
    func setupTimeLabel(){
        
//        timeImageView.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
//        timeImageView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
//        let image = UIImage(named: "clock", scale: 0.5)
        
        timeLabel.text = "52min"
        
        if let image = timeImageView.image {
            
            let labelHeight = timeLabel.intrinsicContentSize.height
            
            timeImageView.image = image.resize(size: CGSize(width: labelHeight, height: labelHeight))
            
            timeImageView.contentMode = .center

        }
        
        
//        timeImageView.center = timeImageView.superview!.center
        
        
        
        
        
        /*
        let style = NSMutableParagraphStyle()
            style.alignment = .center
            style.minimumLineHeight = timeLabel.intrinsicContentSize.height
        
        
        let text = NSMutableAttributedString(string: " ",attributes: [NSAttributedString.Key.paragraphStyle: style])
        
        let clockAttachment = NSTextAttachment()
        clockAttachment.image = UIImage(named: "clock")
        clockAttachment.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        
        clockAttachment.bounds = CGRect(x: 0, y: 0, width: timeLabel.intrinsicContentSize.height, height: timeLabel.intrinsicContentSize.height)
        
        
        let totalTime = NSAttributedString(string: " 52min")
        
        text.append(NSAttributedString(attachment: clockAttachment))
        text.append(totalTime)
        
        timeLabel.attributedText = text
        */
        
//        timeImageView.bounds = CGRect(x: 0, y: 0, width: timeLabel.intrinsicContentSize.height, height: timeLabel.intrinsicContentSize.height)
        
//        timeImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
//        timeImageView.contentMode = .
        
//        timeLabel.text = "52min"
        
    }
    
    
    /*
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
            let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
            layoutIfNeeded()
            layoutAttributes.frame.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
            return layoutAttributes
        }*/
    
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

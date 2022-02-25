//
//  PlanBriefIntroductionView.swift
//  GymApp
//
//  Created by Chris on 2020/10/23.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

protocol ForBriefIntroductionViewProtocol {
    func startAction(planModel: PlanModel)
    func editAction(planModel: PlanModel)
}

class PlanBriefIntroductionView: UIView {

    override var bounds: CGRect {
        didSet {
            layer.masksToBounds = false
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.4
            layer.shadowOffset = .zero
            layer.shadowRadius = layer.cornerRadius
        }
    }

    let cellId = "cellId"
    let viewControllerProtocol: ForBriefIntroductionViewProtocol
    let planModel: PlanModel
    
    let detailLabel: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = ""

        label.layer.borderWidth = 1
        label.isScrollEnabled = true
        label.isSelectable = false

        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title测试"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        
        label.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height).isActive = true
        
        return label
    }()
    
    let startButton: UIButton = {
        let btn = UIButton()

        btn.setTitle("开始", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)

        btn.layer.cornerRadius = 10
        btn.backgroundColor = .systemPurple

        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    let editButton: UIButton = {
        let btn = UIButton()

        btn.setImage(UIImage(named: "edit"), for: .normal)

        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()

    let closeButton: UIButton = {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: "cross"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btn.backgroundColor = UIColor(red: 209, green: 209, blue: 214) // systemGray3
        
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()

    init(planModel: PlanModel, viewControllerProtocol: ForBriefIntroductionViewProtocol) {

        self.planModel = planModel
        self.viewControllerProtocol = viewControllerProtocol
        super.init(frame: CGRect.zero)
        
        loadData()
        setupViews()
        setupContraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(){

        titleLabel.text = planModel.name

        if (planModel.sectionList.count == 0){
            detailLabel.text = "\n尚未添加运动。\n"
            
        } else {
            for section in planModel.sectionList {

                if(!detailLabel.text!.isEmpty){
//                    detailLabel.text?.append("\n")
                }


                detailLabel.text?.append("\(section.sport.name)\n")
                
                for row in section.rowList {
                    detailLabel.text.append("   \(row.value) \(section.unit) × \(row.times)\n")
                }
            }
            
            
        }

        // Line Spacing.
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 20
        
        let font = UIFont.preferredFont(forTextStyle: .body)
        let attributes = [NSAttributedString.Key.paragraphStyle: style,
                          NSAttributedString.Key.font: font]
        
        detailLabel.attributedText = NSAttributedString(string: detailLabel.text, attributes: attributes)
        
        if (planModel.sectionList.count == 0) {
            detailLabel.textAlignment = .center
        }
        
        
    }

    func setupContraints(){
        /* Calculate the height for the views. */
        
        // Padding.
        let padding = CGFloat(10)
        
        // Title.
        let titleHeight = titleLabel.intrinsicContentSize.height
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor,constant: padding),
//            titleLabel.heightAnchor.constraint(equalToConstant: titleHeight)
        ])
        
        // Detail.
        var detailHeight = CGFloat(200)
        NSLayoutConstraint.activate([
            detailLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            detailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            detailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            detailLabel.heightAnchor.constraint(equalToConstant: detailHeight)
        ])
        
        // Start button.
        let buttonHeight = startButton.intrinsicContentSize.height
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.topAnchor.constraint(equalTo: detailLabel.bottomAnchor,constant: padding),
            startButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            startButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3)
        ])
        
        // Window .
        let windowWidth = UIScreen.main.bounds.width * (3/4)
        let windowHeight = CGFloat(4*padding) + titleHeight + detailHeight + buttonHeight

        // Close Button.
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -padding),
            closeButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            closeButton.widthAnchor.constraint(equalTo: titleLabel.heightAnchor),
        ])
        
        // Edit Button.
        NSLayoutConstraint.activate([
            editButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            editButton.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            editButton.heightAnchor.constraint(equalTo: closeButton.heightAnchor, multiplier: 0.8),
            editButton.widthAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 0.8)
        ])

        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: windowWidth),
            self.heightAnchor.constraint(equalToConstant: windowHeight),
        ])

    }
    
    func setupViews(){
        addSubview(titleLabel)
        addSubview(detailLabel)
        
        addSubview(startButton)
        startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        
        addSubview(editButton)
        editButton.addTarget(self, action: #selector(editAction), for: .touchUpInside)
        
        addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        
        // Self View Setting.
//        self.layer.borderWidth = 1
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        
        // Shadow.
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        
    }
    
    @objc func startAction(){
        viewControllerProtocol.startAction(planModel: planModel)
    }
    
    @objc func editAction(){
        viewControllerProtocol.editAction(planModel: planModel)
    }
    
    @objc func closeAction(){
        removeFromSuperview()
    }
    
}

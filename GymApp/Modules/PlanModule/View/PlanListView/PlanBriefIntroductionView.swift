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
    
//    override func willMove(toWindow newWindow: UIWindow?) {
//        super.willMove(toWindow: newWindow)
//        
//        print("will move: \(bounds)")
//        
//        
//        
//        layer.masksToBounds = false
//        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.4
//        layer.shadowOffset = .zero
//        layer.shadowRadius = layer.cornerRadius
//    }
//    
//    override func didMoveToWindow() {
//        super.didMoveToWindow()
//        
//        print("did move: \(bounds)")
//    }
    
    
    
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
//    let presenter: PlanEditPresenterProtocol
    let viewControllerProtocol: ForBriefIntroductionViewProtocol
    let planModel: PlanModel
    
    
    let detailLabel: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = ""

        label.layer.borderWidth = 1
        
        
        
        label.isScrollEnabled = false
        
        label.isSelectable = false
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title测试"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        
        label.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height).isActive = true
        
//        label.font = UIFont.systemFont(ofSize: 30*3/4)
        
//        label.layer.borderWidth = 1
        
        return label
    }()
    
    let startButton: UIButton = {
        let btn = UIButton()
//        btn.titleLabel?.text = "开始运动计划"
//        btn.titleLabel?.font = UIFont(name: "System", size: 14)
        
        btn.setTitle("开始", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        
        
//        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .systemBlue
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    let editButton: UIButton = {
        let btn = UIButton()
        
        /*
        btn.setTitle("edit", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        */
        
        btn.setImage(UIImage(named: "edit"), for: .normal)
        
        
//        btn.layer.borderWidth = 1
//        btn.backgroundColor = .lightGray
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    
    
    let closeButton: UIButton = {
        let btn = UIButton()
        
        /*
        btn.setTitle("Close", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        */
        
        
//        let image = UIImage(systemName: "Stop")
        
        btn.setImage(UIImage(named: "cross"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btn.backgroundColor = UIColor(red: 209, green: 209, blue: 214) // systemGray3
        
//        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    

//    init(delegate: UITableViewDelegate, dataSource: UITableViewDataSource, planmodel: PlanModel)
    
    init(planModel: PlanModel, viewControllerProtocol: ForBriefIntroductionViewProtocol) {
//        tableView.delegate = delegate
//        tableView.dataSource = dataSource
        
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
        
        /*
        for i in 0...10 {
            
            if(!detailLabel.text!.isEmpty){
                detailLabel.text?.append("\n")
            }
            
            detailLabel.text.append("asdfsdfs asdf * asdf\(i)")
        }
         */
        
        titleLabel.text = planModel.name
        
        if (planModel.sectionList.count == 0){
            detailLabel.text = "\n无运动\n"
            
        } else {
            for seciton in planModel.sectionList {

                if(!detailLabel.text!.isEmpty){
                    detailLabel.text?.append("\n")
                }

                let text = "\(seciton.sport.name)*\(seciton.rowList.count)"

                detailLabel.text?.append(text)
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
        detailLabel.sizeToFit()
        var detailHeight = detailLabel.frame.height
        NSLayoutConstraint.activate([
            detailLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            detailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            detailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding)
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
        var windowHeight = CGFloat(4*padding) + titleHeight + detailHeight + buttonHeight
        
        // Check the windows height.
//        let maxHeight = UIScreen.main.bounds.height*(2/3)
//        if (windowHeight > maxHeight) {
//
//            // test
//            print("befor:\(detailHeight)")
//            // end
//
//            detailHeight = detailHeight - (windowHeight - maxHeight)
//
//            // test
//            print("after:\(detailHeight)")
//            // end
//
//
//            detailLabel.isScrollEnabled = true
//
//            windowHeight = maxHeight
//        }
        
        
        
        /* Set the constraints. */
//        NSLayoutConstraint.activate([
//            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            detailLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
//        ])
        
        let views = ["v0": titleLabel,
                     "v1": detailLabel,
                     "v2": startButton]
        
        
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
        
        
        
//        let heightMetrics = ["padding": padding,
//                             "title": titleHeight,
//                             "detail": detailHeight,
//                             "button": buttonHeight] as [String : Any]
//
//        NSLayoutConstraint.activate(
//            NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[v0(title)]-padding-[v1(detail)]-padding-[v2]-padding-|", options: NSLayoutConstraint.FormatOptions(), metrics: heightMetrics, views: views)
//        )
        
        
        
        
        // test
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: windowWidth),
            self.heightAnchor.constraint(equalToConstant: windowHeight),
        ])
        // testend.
        
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
        
//        tableView.estimatedRowHeight
        
//        print(tableView.rowHeight)
        viewControllerProtocol.startAction(planModel: planModel)
        
    }
    
    @objc func editAction(){
        viewControllerProtocol.editAction(planModel: planModel)
    }
    
    @objc func closeAction(){
        removeFromSuperview()
    }
    
    
    
    
    
    
}

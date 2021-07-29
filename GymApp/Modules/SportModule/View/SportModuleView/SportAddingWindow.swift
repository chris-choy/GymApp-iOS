//
//  SportAddingWindow.swift
//  GymApp
//
//  Created by Chris on 2020/9/25.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

protocol ForAddingWindowProtocol {
    func updateTableView(newSport: SportModel)
//    func closeAddingWindow()
}

class SportAddingWindow: UIView {
    
    var dropDownMenu: SportDropDownMenu?
    var presenter: SportModulePresenterProtocol
    var parentView: ForAddingWindowProtocol
    let textFieldDelegate: UITextFieldDelegate

    
    let inputStackView: UIStackView = {
            let stack = UIStackView()
            stack.alignment = .fill
            stack.distribution = .fill
            stack.axis = .vertical
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
    }()
        
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "名称"
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "运动管理"
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        // View
        tf.backgroundColor = Color.lightBackground.value
        tf.layer.cornerRadius = 8
        tf.setLeftPaddingPoints(10)

        
        return tf
    }()
    
    let confirmBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("确认", for: .normal)
        return btn
    }()
    
    let cancelBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("取消", for: .normal)
        btn.backgroundColor = .systemRed
        
        return btn
    }()
    
    
    
    //tag view
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.text = "分类"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let tagButton: UIButton = {
        let button = UIButton()
        // View.
        button.setTitle("点击选择分类", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Color.lightBackground.value
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        button.addTarget(self, action: #selector(showTagMenuAction), for: .touchUpInside)
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    let unitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "单位"
        return label
    }()
    
    let unitButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        // View
        btn.setTitle("点击选择单位", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = Color.lightBackground.value
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.cornerRadius = 8
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return btn
    }()
    
    
    init(presenter: SportModulePresenterProtocol,
         parentView: ForAddingWindowProtocol,
         textFieldDelegate: UITextFieldDelegate){
        self.presenter = presenter
        self.parentView = parentView
        self.textFieldDelegate = textFieldDelegate
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        backgroundColor = .white
        
        setupViews()

        // test
        layer.borderWidth = 1

        // test end.
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: Setting Method
    func setupViews(){
        addSubview(inputStackView)
        inputStackView.addArrangedSubview(nameLabel)
        inputStackView.addArrangedSubview(nameTextField)
        inputStackView.addArrangedSubview(unitLabel)
        inputStackView.addArrangedSubview(unitButton)
        inputStackView.addArrangedSubview(tagLabel)
        inputStackView.addArrangedSubview(tagButton)
        
        // Set unit & tag button
        unitButton.addTarget(self, action: #selector(unitBtnAction), for: .touchUpInside)
        tagButton.addTarget(self, action: #selector(tagBtnAction), for: .touchUpInside)
        
        // Set the name textfield.
        nameTextField.delegate = textFieldDelegate
        
        
        // Title.
        addSubview(titleLabel)
        titleLabel.text = "添加运动"
        titleLabel.textColor = .black
        
        // Set confirm & cancel button
        addSubview(confirmBtn)
        confirmBtn.setTitleColor(.black, for: .normal)
        confirmBtn.layer.cornerRadius = 8
        confirmBtn.layer.borderWidth = 1
        confirmBtn.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        addSubview(cancelBtn)
        cancelBtn.setTitleColor(.white, for: .normal)
        cancelBtn.layer.cornerRadius = 8
        cancelBtn.layer.borderWidth = 1
        cancelBtn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        // Set constraints.
        setupConstraint()
    }
    
    func setupConstraint() {
        
        // StackView.
        NSLayoutConstraint.activate([
            inputStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            inputStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            inputStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        inputStackView.spacing = 5
        
        
        // nameTextField.
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // unitButton.
        NSLayoutConstraint.activate([
            unitButton.heightAnchor.constraint(equalTo: nameTextField.heightAnchor)
        ])
        
        // tagButton.
        NSLayoutConstraint.activate([
            tagButton.heightAnchor.constraint(equalTo: nameTextField.heightAnchor)
        ])
        
        
        
        // Title.
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30)
        ])
        
        
        // Buttons.
        NSLayoutConstraint.activate([
            // Confirm button.
            confirmBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            // Cancel button.
            cancelBtn.centerYAnchor.constraint(equalTo: confirmBtn.centerYAnchor)
        ])
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[confirm]-15-[cancel(==confirm)]-15-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["confirm":confirmBtn, "cancel":cancelBtn]))
        
        // inputStackView
        NSLayoutConstraint.activate([
//            inputStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            inputStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            inputStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
    
// MARK: Action Method
    @objc func confirmAction() {
        if let name = nameTextField.text,
           let unit = unitButton.titleLabel?.text,
           let tag = tagButton.titleLabel?.text
        {
            if name.isEmpty  {
                print("请输入")
            }
            
            if unit == "点击选择单位" {
                print("请选择。。。")
                return
            }

            if unit == "点击选择分类" {
                print("请选择。。。")
                return
            }
            
            if let result = presenter.createSport(name: name, unit: unit, tag: tag) {
                parentView.updateTableView(newSport: result)
                self.removeFromSuperview()
            }
            else {
                print("添加失败！")
            }
            
        }
//        let unit = unitButton.titleLabel?.text
//        let tag = tagButton.titleLabel?.text


        // Check the information.


        

        
        
    }
    
    @objc func cancelAction() {
        self.removeFromSuperview()
    }
    
    @objc func unitBtnAction() {
        
        if(dropDownMenu == nil) {
            dropDownMenu = SportDropDownMenu(dataManager: UnitManager(presenter: presenter), sourceButton: unitButton, parentWindow: self)
            addSubview(dropDownMenu!)
            
            // setup constraints.
            dropDownMenu!.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                dropDownMenu!.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
                dropDownMenu!.widthAnchor.constraint(equalTo: unitButton.widthAnchor),
                dropDownMenu!.topAnchor.constraint(equalTo: unitButton.bottomAnchor),
                dropDownMenu!.leftAnchor.constraint(equalTo: unitButton.leftAnchor),
            ])
        }
        else {
            // Hide menu.
            dropDownMenu?.removeFromSuperview()
            dropDownMenu = nil
        }
        
    }
    
    @objc func tagBtnAction() {
        
        if(dropDownMenu == nil) {
            // Create menu.
//            dropDownMenu = SportDropDownMenu(dataType: .tag,presenter: presenter, sourceButton: tagButton, parentWindow: self)
            dropDownMenu = SportDropDownMenu(dataManager: TagManager(presenter: presenter), sourceButton: tagButton, parentWindow: self)
            addSubview(dropDownMenu!)
            
            // setup constraints.
            dropDownMenu!.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                dropDownMenu!.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
                dropDownMenu!.widthAnchor.constraint(equalTo: tagButton.widthAnchor),
                dropDownMenu!.topAnchor.constraint(equalTo: tagButton.bottomAnchor),
                dropDownMenu!.leftAnchor.constraint(equalTo: tagButton.leftAnchor),
            ])
        } else {
            // Hide menu.
            dropDownMenu?.removeFromSuperview()
            dropDownMenu = nil
        }
        
        
    }
    
    
}



extension SportAddingWindow: ForDropDownWindowProtocol{
//    func createUnitOrTag(name: String, dataType: DataType) {}
    
    func closeDropDownWindow(){
        if dropDownMenu != nil {
            dropDownMenu?.removeFromSuperview()
            dropDownMenu = nil
        }
    }
}



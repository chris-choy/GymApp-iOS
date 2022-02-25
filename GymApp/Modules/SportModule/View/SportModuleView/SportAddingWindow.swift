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
    func saveSport(sport: SportModel)
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

    let tagLabel: UILabel = {
        let label = UILabel()
        label.text = "分类"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let unitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "单位"
        return label
    }()
    
    let unitTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        tf.backgroundColor = Color.lightBackground.value
        tf.layer.cornerRadius = 8
        tf.setLeftPaddingPoints(10)
        
        return tf
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
        layer.cornerRadius = 15
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
        inputStackView.addArrangedSubview(unitTextField)

        // Set unit & tag button
        inputStackView.bringSubviewToFront(unitTextField)
        
        // Set the name textfield.
        nameTextField.delegate = textFieldDelegate
        unitTextField.delegate = textFieldDelegate
        
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
            unitTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor)
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
            inputStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            inputStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
    
// MARK: Action Method
    @objc func confirmAction() {
        
        // 1. Check the information.
        if let name = nameTextField.text,
           let unit = unitTextField.text
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

            // 2. Start the operation.
            let sport = SportModel(id: 0, objectId: nil, name: name, unit: unit, user_id: 0, last_changed: 0)
            
            do {
                let str = try JSONEncoder().encode(sport)
            } catch {
                print("error")
            }
            
        }
        
    }
    
    @objc func cancelAction() {
        self.removeFromSuperview()
    }

}

extension SportAddingWindow: ForDropDownWindowProtocol{
    func closeDropDownWindow(){
        if dropDownMenu != nil {
            dropDownMenu?.removeFromSuperview()
            dropDownMenu = nil
        }
    }
}



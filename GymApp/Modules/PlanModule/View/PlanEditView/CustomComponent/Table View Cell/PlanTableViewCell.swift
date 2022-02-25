//
//  PlanTableviewCell.swift
//  GymApp
//
//  Created by Chris on 2020/6/24.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit


class PlanTableViewCell: UITableViewCell {

    var setNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center

        // Calculate the text max size.
        label.text = "99"
        label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width).isActive = true
        label.text = ""
        
        return label
        }()
    
    let deleteBtn: CustomDeleteButton = {
        let btn = CustomDeleteButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var valueTF: TextFieldWithIndex = {
       let tf = TextFieldWithIndex()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.dataType = .value
        
        // To calculate the max size.
        tf.text = "  数值  "
        tf.sizeToFit()
        tf.widthAnchor.constraint(equalToConstant: tf.frame.width).isActive = true

        tf.placeholder = "数值"

        return tf
    }()

    var timesTF: TextFieldWithIndex = {
        let tf = TextFieldWithIndex()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.dataType = .times
        
        // To Calculate the max size of the
        tf.text = "  次数  "
        tf.placeholder = "次数"
        tf.sizeToFit()
        tf.widthAnchor.constraint(equalToConstant: tf.frame.width).isActive = true

        return tf
    }()
    
    var multiplicationSymbol: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(imageLiteralResourceName: "cross")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return iv
    }()
    
    var lastValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .yellow
        label.textAlignment = .center
        
        
        // Calculate the width.
        label.text = "  上一次的记录  "
        label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width).isActive = true
        label.text = ""

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        setupView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
        selectionStyle = .none
        
        contentView.addSubview(setNumLabel)
        contentView.addSubview(lastValueLabel)
//        contentView.addSubview(unitLabel)
        contentView.addSubview(timesTF)
        contentView.addSubview(multiplicationSymbol)
        contentView.addSubview(valueTF)
        contentView.addSubview(deleteBtn)
        
        
        NSLayoutConstraint.activate([
            setNumLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            lastValueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timesTF.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            multiplicationSymbol.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            valueTF.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            deleteBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            deleteBtn.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            deleteBtn.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                                        withVisualFormat: "|-16-[v0]-16-[v1]-16-[v2]-8-[v4(16)]-[v5]-16-[v6]-16-|",
                                        options: NSLayoutConstraint.FormatOptions(), metrics: nil,
                                        views: ["v0":setNumLabel,
                                                "v1":lastValueLabel ,
                                                "v2":valueTF,
                                                "v4":multiplicationSymbol,
                                                "v5":timesTF,
                                                "v6":deleteBtn] ))
    }
    
}

class CustomDeleteButton: UIButton {
    var indexPath: IndexPath = []
}

class TextFieldWithIndex: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {

    enum TextFieldDataType {
        case value
        case times
    }
    var rowIndex : Int = 0
    var sectionIndex : Int = 0
    var dataType: TextFieldDataType = .value
    
    var times = 0
    
    let pickerView = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    @objc func doneAction(){
        self.endEditing(true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 50
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row+1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print("didselect")
        times = row+1
        text = "\(times)"
    }
    
    func setupTimesInputView(){
        pickerView.delegate = self
        self.inputView = pickerView
    }
    
}

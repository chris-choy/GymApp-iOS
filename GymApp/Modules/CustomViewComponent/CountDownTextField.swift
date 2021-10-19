//
//  CountDownTextField.swift
//  GymApp
//
//  Created by Chris on 2021/7/9.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit

class CountDownTextField: UITextField  {
    
    var rowIndex : Int = 0
    var sectionIndex : Int = 0
    
    public var sec: Int = 0 {
        didSet {
            
            // Set the text according to the sec value.
            let secPart = sec%60
            let minPart = sec/60
            
            if (minPart > 0) {
                self.text = "\(minPart)分钟\(secPart)秒"
                if secPart == 0{
                    self.text = "\(minPart)分钟"
                }
            } else{
                self.text = "\(sec%60)秒"
            }
            
            // Set the picker view row.
            pickerView.selectRow(minPart, inComponent: 0, animated: false)
            pickerView.selectRow(secPart, inComponent: 1, animated: false)
        }
    }
    
    let pickerView : UIPickerView = {
        let picker = UIPickerView()
        
        
        return picker
    }()
    
    let toolbar : UIToolbar = {
        let toolbar = UIToolbar()
        let btn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneAction))
        
        toolbar.setItems([btn], animated: true)
        
        // style
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        return toolbar
    }()
    
    
    
    @objc func doneAction(){
        sec = pickerView.selectedRow(inComponent: 0)*60 + pickerView.selectedRow(inComponent: 1)
        self.endEditing(true)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setPickerView()
        
        self.inputView = pickerView
        self.inputAccessoryView = toolbar

        self.tintColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPickerView(){
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let minLabel = UILabel()
        let secLabel = UILabel()
        
        minLabel.text = "分"
        secLabel.text = "秒"

        pickerView.addSubview(minLabel)
        pickerView.addSubview(secLabel)
        
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        secLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Get screen width.
        let width = UIScreen.main.bounds.width
        
        NSLayoutConstraint.activate([
            minLabel.centerYAnchor.constraint(equalTo: pickerView.centerYAnchor),
            secLabel.centerYAnchor.constraint(equalTo: pickerView.centerYAnchor),
            minLabel.leftAnchor.constraint(equalTo: pickerView.leftAnchor, constant: width*0.3),
            secLabel.leftAnchor.constraint(equalTo: pickerView.leftAnchor, constant: width*0.8),
        ])

    }
    

}

extension CountDownTextField : UIPickerViewDelegate, UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        switch component {
        case 0:
            return 20
        default:
            return 60
        }
        
    }
    
}

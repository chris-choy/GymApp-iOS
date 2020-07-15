//
//  SportVC+DropDownMenu.swift
//  GymApp
//
//  Created by Chris on 2020/4/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit

extension SportViewController {
    
    func createDropDownMenu(title: String, btn: UIButton, dataType: DataType){
    
        
        ddmDataType = dataType
        if(dataType == DataType.tag){
            ddmFetchTagData()
        } else{
            ddmFetchUnitData()
        }
        
        dropDownMenu = UIView()
        view.addSubview(dropDownMenu!)
        dropDownMenu?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dropDownMenu!.heightAnchor.constraint(equalToConstant: 300),
            dropDownMenu!.widthAnchor.constraint(equalTo: btn.widthAnchor),
            dropDownMenu!.topAnchor.constraint(equalTo: btn.bottomAnchor),
            dropDownMenu!.leadingAnchor.constraint(equalTo: btn.leadingAnchor)
        ])
        
        dropDownMenu?.layer.borderWidth = 1
        dropDownMenu?.layer.cornerRadius = 8
        dropDownMenu?.layer.borderColor = UIColor.black.cgColor
        
        ddmNavigationBar = UINavigationBar()
        ddmNavigationBar!.pushItem(UINavigationItem(), animated: false)
        ddmNavigationBar?.topItem?.title = title
        ddmNavigationBar?.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(ddmShowAddingWindow))
        ddmSearchBar = UISearchBar()
        ddmTableView = UITableView()
        
        ddmStackView = UIStackView(arrangedSubviews: [ddmNavigationBar!,ddmSearchBar!,ddmTableView!])
        dropDownMenu?.addSubview(ddmStackView!)
        ddmStackView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ddmStackView!.heightAnchor.constraint(equalTo: dropDownMenu!.heightAnchor),
            ddmStackView!.widthAnchor.constraint(equalTo: dropDownMenu!.widthAnchor)
        ])
        ddmStackView?.distribution = .fill
        ddmStackView?.alignment = .fill
        ddmStackView?.axis = .vertical
        
        ddmTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        ddmTableView?.dataSource = self
        ddmTableView?.delegate = self
        ddmTableView?.sectionHeaderHeight = 0
        
        
    }
    
    func removeDropDownMenu(){
        dropDownMenu?.removeFromSuperview()
        
        dropDownMenu = nil
        ddmNavigationBar = nil
        ddmSearchBar = nil
        ddmTableView = nil
        
        ddmStackView = nil

    }
    
    @objc func ddmShowAddingWindow(){
    //        print("add")
            ddmCreateAddingWindow()
        }
        
        
        
    func ddmCreateAddingWindow(){
        let alert = UIAlertController(title: "创建", message: "请输入需要创建的名称", preferredStyle: .alert)
        
        alert.addTextField{(textField) in
            textField.keyboardType = .default
        }
        
        let confirmAction = UIAlertAction(title: "确认", style: .default){
            UIAlertAction in
            let tf = alert.textFields![0]
            
            switch self.ddmDataType{
            case .tag:
                if(self.addTag(name: tf.text!) == true){
                    self.ddmFetchTagData()
                }else{
                    let failedAlert = UIAlertController(title: "提示", message: "添加失败!可能已存在相同的分类。", preferredStyle: .alert)
                    failedAlert.addAction(UIKit.UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
                    
                    self.present(failedAlert, animated: false, completion: nil)
                }
            case .unit:
                if(self.addUnit(name: tf.text!) == true){
                    self.ddmFetchUnitData()
                }
                else{
                    let failedAlert = UIAlertController(title: "提示", message: "添加失败!可能已存在相同的单位。", preferredStyle: .alert)
                    failedAlert.addAction(UIKit.UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
                
                    self.present(failedAlert, animated: false, completion: nil)
                }
                
            case .none:
                break
            }
            
            self.ddmTableView?.reloadData()
            
        }
        
        
        let cancelAction = UIAlertAction(title: "取消", style: .default){
            UIAlertAction in
            print("cancel")
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
        
    }
    
}

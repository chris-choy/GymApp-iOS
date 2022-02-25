//
//  CustomDropDownTextField.swift
//  GymApp
//
//  Created by Chris on 2021/8/10.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit

class CustomDropDownTextField: UITextField, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    let cellId = "cellId"
    
    let unitList = ["自定义","kg", "秒" , "分", "个"]
    
    let tableView: UITableView = {
        let tv = UITableView()
        
        return tv
    }()
    
    let navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.pushItem(UINavigationItem(), animated: false)
        return bar
    }()
    
    let stackView: UIStackView = {
        let s = UIStackView()
        
        return s
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // test
        self.layer.borderWidth = 1
        // test end.
        
        delegate = self
        
//        setupView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
        setupStackView()
        setupTableView()
    }
    
    
    func setupStackView(){
        navigationBar.topItem?.title = "单位"

        stackView.addArrangedSubview(navigationBar)
        stackView.addArrangedSubview(tableView)
        addSubview(stackView)
        
        stackView.axis = .vertical
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 200),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        // test
        stackView.layer.borderWidth = 1
        navigationBar.layer.borderWidth = 1
        // test end.
    }
    
    func setupTableView(){
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = 0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.backgroundColor = .white
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setupView()
        tableView.becomeFirstResponder()
        tableView.isScrollEnabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        stackView.removeFromSuperview()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("a")
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        cell?.textLabel?.text = "\(unitList[indexPath.row])"

        return cell ?? UITableViewCell()
    }

}

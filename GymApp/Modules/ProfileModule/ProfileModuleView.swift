//
//  ProfileModuleView.swift
//  GymApp
//
//  Created by Chris on 2020/10/31.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class ProfileModuleView: UITableViewController {
    
    var presenter: ProfileModulePresenterProtocol?
    
    let detailCell = "detailCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // test
        // SystemGray5
        view.backgroundColor = UIColor(red: 242, green: 242, blue: 247)
        
        title = "我"
        
//        let label = UILabel()
//        label.text = "Profile Module."
//        view.addSubview(label)
//        label.frame = CGRect(x: 0, y: 0, width: label.intrinsicContentSize.width, height: 50)
//        label.center = view.center
        
//        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)

        // testend
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ProfileDetailsCellTableViewCell.self, forCellReuseIdentifier: detailCell)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 2:
            return 1
        default:
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0 && indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: detailCell) as! ProfileDetailsCellTableViewCell
            
//            cell.textLabel?.text = "Profile"
            cell.selectionStyle = .none
            
            return cell
            
        }
        
        if(indexPath.section == 1){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            cell?.accessoryType = .disclosureIndicator
            
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = "null"
            case 1:
                cell?.imageView?.image = UIImage(named: "set")
                cell?.textLabel?.text = "设置"
            case 2:
                cell?.imageView?.image = UIImage(named: "prompt")
                cell?.textLabel?.text = "关于"
            default:
                cell?.textLabel?.text = "\(indexPath.section) : \(indexPath.row)"
            }
            
            return cell!
        }
        
        if(indexPath.section == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = "退出登录"
            cell?.textLabel?.textAlignment = .center
            return cell!
        }
        
        
        
        // For test, maybe error.
        return UITableViewCell()
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.section == 0 && indexPath.row == 0){
            return 300
        }
        
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if(section == 1 || section == 2){
            
            let v = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            v.backgroundColor = UIColor(red: 242, green: 242, blue: 247)
            
            return v
        } else{
            return UIView()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 0
        } else {
            return 10
        }
        
    }
    
    
    
    
    
    
    

}

extension ProfileModuleView: ProfileModuleViewProtocol {
    
}

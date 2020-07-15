//
//  PlanListView.swift
//  GymApp
//
//  Created by Chris on 2020/7/6.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit

class PlanListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var presenter: PlanCreatePresenterProtocol?
    var planList: [Plan]?
    let cellId = "planCell"

    fileprivate func setupNavigationView() {
        title = "运动计划"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        let attributes = [
            //            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.black]
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.largeTitleTextAttributes = attributes
        } else {
            // Fallback on earlier versions
        }
    }
    
    fileprivate func setupCollectionView() {
        collectionView.register(PlanCollcetionCell.self, forCellWithReuseIdentifier: cellId)
        
        // View.
        collectionView.contentInset.top = 10
        let backgroundView = UIView()
        backgroundView.backgroundColor = Color.background.value
        backgroundView.tintColor = .blue
        collectionView.backgroundView = backgroundView
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ############ 生命周期问题！！！！！！！
//        planList = planDataManager.fetchAllPlans()
        
//        if let plans = planList {
//            for i in plans{
//                print(i)
//                testList.append(i)
//            }
//
//            print("\n\n\n")
//        }
        
        
        setupNavigationView()
        setupCollectionView()
        
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = planList?.count {
            return count
        }
        
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PlanCollcetionCell
        
        if let p = planList {
            
            cell.nameLabel.text = p[indexPath.row].name
        }
  
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Select to edit plan.
        // Build a PlanModule with the PlanEditPage.
        
        
//        let router  = PlanCreateRouter()
        
        if let plans = planList {
            let planEditView = PlanCreateRouter.buildPlanEditView(plan: plans[indexPath.row])
            navigationController?.pushViewController(planEditView, animated: true)
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width-20, height: 150)
    }
}

extension PlanListViewController: PlanCreateViewProtocol {
    func addSection(sections: [PlanSection]) {
        
    }
    
    func addSection(sports: [Sport]) {
        
    }
    
    
    func loadData(plans: [Plan]) {
        viewDidLoad()
        planList = plans
    }
    
    
    
}


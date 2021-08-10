//
//  PlanListView.swift
//  GymApp
//
//  Created by Chris on 2020/7/6.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class PlanListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var presenter: PlanModulePresenterProtocol?
    var planList: [PlanModel] = []
    let cellId = "planCell"

    var introductionView : PlanBriefIntroductionView?
    
    let loadingAnimationView = LoadingAnimationView()
    
    var planEditViewController: PlanEditView?
    

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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addAction))
        
    }
    
    @objc func addAction(){

//        let vc = presenter!.buildPlanEditViewToCreate()
        // Create a empty plan model for editting.
        let vc = PlanEditView(plan: PlanModel(id: 0,
                                              objectId: nil,
                                              name: "",
                                              sectionList: [],
                                              last_changed: 0,
                                              seq: planList.count,
                                              user_id: planList.first?.user_id ?? 0),
                              listView: self)
        
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    fileprivate func setupCollectionView() {
        collectionView.register(PlanCollcetionCell.self, forCellWithReuseIdentifier: cellId)
        
        // View.
        collectionView.contentInset.top = 10
        
        let backgroundView = UIView()
//        backgroundView.backgroundColor = Color.background.value
        backgroundView.backgroundColor = UIColor(red: 246, green: 249, blue: 255)
        backgroundView.tintColor = .blue
        collectionView.backgroundView = backgroundView
        collectionView.alwaysBounceVertical = true
//        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
//        collectionView.backgroundColor = UIColor(red: 246, green: 249, blue: 255)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("viewDidAppear")
        
        super.viewDidAppear(animated)
        
        if introductionView != nil {
//            introductionView?.layer.cornerRadius = 10
            introductionView?.layer.masksToBounds = false
            introductionView?.layer.shadowPath = UIBezierPath(rect: introductionView!.bounds).cgPath
            introductionView?.layer.shadowColor = UIColor.black.cgColor
            introductionView?.layer.shadowOpacity = 0.4
            introductionView?.layer.shadowOffset = .zero
            introductionView?.layer.shadowRadius = introductionView!.layer.cornerRadius
            
        }
        
        if planEditViewController != nil {
            loadData()
            planEditViewController = nil
        }
        
    }
    
    
    fileprivate func setupLoadingAnimationView() {
        view.addSubview(loadingAnimationView)
        
        loadingAnimationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load data.
        setupLoadingAnimationView()
        
        loadData()
        
        
        setupNavigationView()
        setupCollectionView()

    }
    
    func loadData() {
        loadingAnimationView.show()
        presenter?.loadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PlanCollcetionCell
        
        cell.nameLabel.text = planList[indexPath.row].name
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if introductionView != nil {
            introductionView?.removeFromSuperview()
            introductionView = nil
        }
        
        introductionView = PlanBriefIntroductionView(planModel: planList[indexPath.row], viewControllerProtocol: self)
        view.addSubview(introductionView!)
        NSLayoutConstraint.activate([
            introductionView!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            introductionView!.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-20, height: 150)
    }

    
}

extension PlanListViewController: ForBriefIntroductionViewProtocol {
    func startAction(planModel: PlanModel) {
        print("start")
        
        let vc = presenter?.buildExercisingModuleView(planModel: planList[0])
        navigationController?.pushViewController(vc!, animated: true)
        
        introductionView?.removeFromSuperview()
        introductionView = nil
    }
    
    func editAction(planModel: PlanModel) {
        
        // Build a PlanModule with the PlanEditPage.
        
//        let vc = presenter?.buildPlanEditViewToEdit(plan: planModel)
        
        
        if planEditViewController == nil {
            planEditViewController = PlanEditView(plan: planModel, listView: self)
            
            
            navigationController?.pushViewController(planEditViewController!, animated: true)
            introductionView?.removeFromSuperview()
            introductionView = nil
        }
        
        

        
        
    }
    
    
}


extension PlanListViewController: PlanModuleViewProtocol {
    func addSection(sections: [PlanSectionModel]) {
        planEditViewController?.addSection(sections: sections)
    }
    
    
    func showData(planModel: [PlanModel]) {
        planList = planModel
        collectionView.reloadData()
        loadingAnimationView.hide()
    }
    
    func showUpdateError(){
        if let planEditView = planEditViewController{
            planEditView.showSaveError()
        }
    }
    
    func showUpdateSuccessfully(){
        if let planEditView = planEditViewController{
            planEditView.saveSuccessfully()
        }
    }

//    func addSection(sections: [PlanSectionModel]) {
//
//    }
//
//    func addSection(sports: [Sport]) {
//
//    }
    
    func showErrorAlert(){
        let alert = UIAlertController(title: "提示", message: "读取数据出错", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension PlanListViewController: ForPlanEditViewProtocol{
    func savePlan(planModel: PlanModel) {
        presenter?.savePlan(plan: planModel)
    }
    
    func buildSportListView(sections: [PlanSectionModel]) -> UIViewController {
        return presenter!.buildSportListView(sections: sections)
    }
}



protocol ForPlanEditViewProtocol {
    func savePlan(planModel: PlanModel)
    func buildSportListView(sections: [PlanSectionModel]) -> UIViewController
}


class ShadowView: UIView {
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)

    }
    
}






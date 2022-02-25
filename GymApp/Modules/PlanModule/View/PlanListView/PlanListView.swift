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
    
    var planEditViewController: PlanEditView?

    let loadingAnimationView = LoadingAnimationView()
    
    fileprivate func setupLoadingAnimationView() {
        view.addSubview(loadingAnimationView)
        
        loadingAnimationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    

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
    
    fileprivate func setupRrefreshControl() {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.attributedTitle = NSAttributedString(string: "下拉更新计划数据")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func refresh(){
        loadData()
    }
    
    @objc func addAction(){

        // Create a empty plan model for editting.
        planEditViewController = PlanEditView(plan: PlanModel(id: 0,
                                              objectId: nil,
                                              name: "",
                                              sectionList: [],
                                              last_changed: 0,
                                              seq: planList.count+1,
                                              user_id: planList.first?.user_id ?? 0),
                              listView: self)

        navigationController?.modalPresentationStyle = .popover
        
        navigationController?.pushViewController(planEditViewController!, animated: true)
        
    }
    
    fileprivate func setupCollectionView() {
        collectionView.register(PlanCollcetionCell.self, forCellWithReuseIdentifier: cellId)
        
        // View.
        collectionView.contentInset.top = 10
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: "PlanListBackground")
        backgroundView.tintColor = .blue
        collectionView.backgroundView = backgroundView
        collectionView.alwaysBounceVertical = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if introductionView != nil {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load data.
        setupLoadingAnimationView()
        
        loadData()
        
        setupNavigationView()
        setupCollectionView()
        
        setupRrefreshControl()

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
        cell.detailText.text = self.getDetailText(index: indexPath.row)
        
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
        
        // Animation.
        introductionView?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        introductionView?.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.introductionView?.alpha = 1
            self.introductionView?.transform = CGAffineTransform.identity
        }
        
    }
    
    func getDetailText(index: Int) -> String{
        let planModel = planList[index]
        var text = ""
        
        for (index, section) in planModel.sectionList.enumerated(){
            text.append("\(section.sport.name) × \(section.rowList.count)")
            if (index != planModel.sectionList.endIndex-1){
                text.append("\n")
            }
        }
        
        return text
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-20,
                      height: PlanCollcetionCell.getHeight(planModel: planList[indexPath.row]))
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
        collectionView.refreshControl?.endRefreshing()
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

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}

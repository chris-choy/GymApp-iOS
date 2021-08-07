//
//  LoadingViewController.swift
//  GymApp
//
//  Created by Chris on 2021/7/28.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController {
    
    
    let loadingView = LoadingAnimationView()
    
    let showBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    let hideBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    let stackview = UIStackView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
    
    let successAnimation = AnimationView(name: "success-animation")
//    let successAnimation = AnimationView(name: "success-animation-purple")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showBtn.addTarget(nil, action: #selector(showAction), for: .touchUpInside)
        hideBtn.addTarget(nil, action: #selector(hideAction), for: .touchUpInside)
        

        view.addSubview(stackview)
        
        stackview.axis = .vertical
        
        
        stackview.addArrangedSubview(showBtn)
        stackview.addArrangedSubview(hideBtn)
        
        
        showBtn.setTitle("show", for: .normal)
        showBtn.setTitleColor(.black, for: .normal)
        
        hideBtn.setTitle("hide", for: .normal)
        hideBtn.setTitleColor(.black, for: .normal)
        
        showBtn.layer.borderWidth = 1
        hideBtn.layer.borderWidth = 1
        
        
        
        view.backgroundColor = .cyan
        
        setLoadingView()
        
    }
    
    func setLoadingView() {
//        view.addSubview(loadingView)
//
////        loadingView.center = view.center
//
//        loadingView.translatesAutoresizingMaskIntoConstraints = false
////
//        NSLayoutConstraint.activate([
//            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//        ])
//
////        loadingView.showLoadingAnimationView()
        
        
        
        
        view.addSubview(successAnimation)

//        successAnimation.frame = CGRect(x: <#T##Double#>, y: <#T##Double#>, width: <#T##Double#>, height: <#T##Double#>)
        
        successAnimation.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        successAnimation.center = view.center
//        successAnimation.backgroundColor = .white
        
    }
    
    
    @objc func showAction(){
//        loadingView.show()
        successAnimation.loopMode = .loop
        successAnimation.play()
        
    }
    
    @objc func hideAction(){
//        loadingView.hide()
    }
    

}

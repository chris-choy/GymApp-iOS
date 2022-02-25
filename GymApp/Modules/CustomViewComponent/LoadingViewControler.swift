//
//  LoadingViewControler.swift
//  GymApp
//
//  Created by Chris on 2021/12/30.
//  Copyright © 2021 Chris. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LoadingViewController: UIViewController {
    
    private let animationView: AnimationView = .init(name:"loading-animation")
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        setupLoadingAnimationView()
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    fileprivate func setupLoadingAnimationView() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo : view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo : view.centerYAnchor),
            animationView.widthAnchor.constraint(equalTo   : view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo  : view.heightAnchor)
        ])
        animationView.loopMode = .loop
        show()
    }
    
    public func show() {
        animationView.isHidden = false
//        view.isUserInteractionEnabled = true
        
        animationView.play()
    }
    
    public func hide() {
        animationView.pause()
        animationView.isHidden = true
//        self.isUserInteractionEnabled = false
    }
    
    override func viewDidLoad() {

    }
}

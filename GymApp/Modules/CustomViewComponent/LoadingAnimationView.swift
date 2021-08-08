//
//  LoadingAnimationView.swift
//  GymApp
//
//  Created by Chris on 2021/7/28.
//  Copyright © 2021 Chris. All rights reserved.
//

import Foundation
import Lottie

class LoadingAnimationView: UIView {
    
    private let animationView: AnimationView = .init(name:"loading-animation")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLoadingAnimationView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLoadingAnimationView() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            animationView.widthAnchor.constraint(equalTo: self.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        animationView.loopMode = .loop
        hide()
    }
    
    public func show() {
        animationView.isHidden = false
        self.isUserInteractionEnabled = true
        animationView.play()
    }
    
    public func hide() {
        animationView.pause()
        animationView.isHidden = true
        self.isUserInteractionEnabled = false
    }
    
}

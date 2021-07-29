////
////  PlanEditViewController.swift
////  GymApp
////
////  Created by Chris on 2020/4/23.
////  Copyright © 2020 Chris. All rights reserved.
////
//
//import UIKit
//
//class PlanEditViewController: UIViewController , UIScrollViewDelegate{
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        
//        view.backgroundColor = .white
//        
//        let scrollView = UIScrollView()
//        view.addSubview(scrollView)
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            scrollView.widthAnchor.constraint(equalToConstant: 200),
//            scrollView.heightAnchor.constraint(equalToConstant: 200)
//        ])
//        
//        scrollView.delegate = self
//        scrollView.isPagingEnabled = true
//        
//        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        label1.text = "111"
//        label1.textColor = .black
//        view1.addSubview(label1)
//        
//        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        label2.text = "222"
//        label2.textColor = .black
//        view2.addSubview(label2)
//        
//        scrollView.addSubview(view1)
//        scrollView.addSubview(view2)
//        
//    }
//    
//    
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

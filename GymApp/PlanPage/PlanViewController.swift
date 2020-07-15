//
//  PlanViewController.swift
//  GymApp
//
//  Created by Chris on 2020/4/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class PlanViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let text = UITextView()

    let cellId = "planCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }

        collectionView.contentInset.top = 10

        let backgroundView = UIView()
        backgroundView.backgroundColor = Color.background.value
        backgroundView.tintColor = .blue

        collectionView.backgroundView = backgroundView


        title = "运动计划"

        let attributes = [
//            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white]
//            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
//            NSAttributedString.Key.strokeWidth: -3.0] as [NSAttributedString.Key : Any]

        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.largeTitleTextAttributes = attributes
        } else {
            // Fallback on earlier versions
        }

        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.register(PlanCollcetionCell.self, forCellWithReuseIdentifier: cellId)

        //test!!!!!!!!!
        //jump to the detail view
//        let planDetail = PlanDetailViewController(text:"asdf", collectionViewLayout: UICollectionViewFlowLayout())
        let planDetail = PlanDetailViewController()
        navigationController?.pushViewController(planDetail, animated: true)

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

//        let planDetail = PlanDetailViewController(text: "hi")

//        let planDetail = PlanDetailViewController(text:"asdf",collectionViewLayout: UICollectionViewFlowLayout())
        let planDetail = PlanDetailViewController()
        navigationController?.pushViewController(planDetail, animated: true)

        print("Click \(indexPath.row)")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {



//        let size = CGSizeMake(view.frame.width,50)

        return CGSize(width: view.frame.width-20, height: 150)
    }


}

//class PlanCollcetionCell: UICollectionViewCell {
//    override init(frame: CGRect){
//        super.init(frame: frame)
//
//        setupViews()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "腿部训练"
//        label.textColor = .black
//        label.font = UIFont.boldSystemFont(ofSize: 17)
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
//
//    let imageView: UIImageView = {
//        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.heightAnchor.constraint(equalToConstant: 64).isActive = true
//        image.widthAnchor.constraint(equalToConstant: 64).isActive = true
//        image.backgroundColor = Color.darkBackground.value
//        return image
//    }()
//
//    let contentText: UILabel = {
//        let label = UILabel()
//        label.text = "跑步\n酒杯深蹲\n哑铃甩摆\nAA\nbb\ncc"
//        label.textColor = .black
//        label.font = UIFont.boldSystemFont(ofSize: 14)
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.numberOfLines = 5
//        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
//
//        return label
//    }()
//
//    func setupViews(){
//        backgroundColor = Color.intermidiateBackground.value
//
//        self.layer.cornerRadius = 8
//
//        addSubview(nameLabel)
//        addSubview(imageView)
//        addSubview(contentText)
//
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
//            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            nameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 15),
//            nameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant:   15),
//            contentText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
//            contentText.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
//
//
//        ])
//
//    }
//
//}

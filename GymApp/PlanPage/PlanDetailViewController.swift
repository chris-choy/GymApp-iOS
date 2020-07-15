//
//  PlanDetailViewController.swift
//  GymApp
//
//  Created by Chris on 2020/4/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

import Lottie

class PlanDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var text: String = ""
    
    let cellId = "PlanDetailCell"
    
    let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()

// MARK: TopBar
    let topBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let topBarStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.backgroundColor = UIColor.red
        stack.axis = .vertical
        
        
        return stack
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "XXX计划"
//        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "编辑计划-选择运动项目"
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let tagFilterButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        let icon = UIImage(named: "filter")
        btn.setImage(icon, for: .normal)
        btn.tintColor = .black
        
        return btn
    }()
    
    let searchBar:UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.searchBarStyle = .minimal
        
        return bar
    }()
    
    func setupTopBar(){
//        topBarView.addSubview(titleLabel)
//        topBarView.addSubview(captionLabel)
//        topBarView.addSubview(tagFilterButton)
//        topBarView.addSubview(searchBar)
        topBarView.addSubview(topBarStackView)
        
        //TopBarStack
        topBarStackView.layer.backgroundColor = UIColor.red.cgColor
        topBarStackView.addArrangedSubview(titleLabel)
        topBarStackView.addArrangedSubview(captionLabel)
        topBarStackView.addArrangedSubview(searchBar)
//        topBarStackView.addArrangedSubview(tagFilterButton)
        
        NSLayoutConstraint.activate([
            topBarStackView.widthAnchor.constraint(equalTo: topBarView.widthAnchor, constant: -60),
            topBarStackView.heightAnchor.constraint(equalTo: topBarView.heightAnchor,constant: -60),
            topBarStackView.centerXAnchor.constraint(equalTo: topBarView.centerXAnchor),
            topBarStackView.centerYAnchor.constraint(equalTo: topBarView.centerYAnchor)
        ])
        
        // TopBarView layout
        // Calculate the topbar height
        let win = UIApplication.shared.keyWindow?.safeAreaLayoutGuide
        let height  = 0.22 * win!.layoutFrame.height
        print("height:\(height)")
        
        topBarView.backgroundColor = .lightGray
        NSLayoutConstraint.activate([
            topBarView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topBarView.heightAnchor.constraint(equalToConstant: height),
            topBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        
        
        // Title and caption layout
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: topBarView.topAnchor, constant: 30),
//            titleLabel.leftAnchor.constraint(equalTo: topBarView.leftAnchor, constant: 30),
//            captionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
//            captionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
//            tagFilterButton.heightAnchor.constraint(equalToConstant: 22),
//            tagFilterButton.widthAnchor.constraint(equalToConstant: 22),
//            tagFilterButton.rightAnchor.constraint(equalTo: topBarView.rightAnchor, constant: -30),
//            tagFilterButton.bottomAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: -30)
//        ])
        
        // SearchBar and filterButton layout
        
//        NSLayoutConstraint.activate([
//            searchBar.rightAnchor.constraint(equalTo: tagFilterButton.leftAnchor, constant: -15),
//            searchBar.centerYAnchor.constraint(equalTo: tagFilterButton.centerYAnchor),
//            searchBar.leftAnchor.constraint(equalTo: topBarView.leftAnchor, constant: 15),
//            tagFilterButton.heightAnchor.constraint(equalToConstant: 22),
//            tagFilterButton.widthAnchor.constraint(equalToConstant: 22),
//            tagFilterButton.rightAnchor.constraint(equalTo: topBarView.rightAnchor, constant: -30),
//            tagFilterButton.bottomAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: -30)
//        ])
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = Color.background.value
//        title = "（计划名称）"
        
//        navigationController?.navigationBar.backgroundColor = UIColor.blue
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: .plain, target: self, action: #selector(rightButtonAction))
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .brown
        
        
        
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
        
        
        
        

        //Set the status bar background color
        
        
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
//            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        } else {
            // Fallback on earlier versions
        }
        
        view.addSubview(topBarStackView)
        view.addSubview(topBarView)
        view.addSubview(collectionView)
        setupCollectionView()
        setupTopBar()
        
        // Test
//        goToPlanEditView()
        
    }
    
    
    
    func setupCollectionView(){
        collectionView.register(PlanDetailViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
    
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            collectionView.topAnchor.constraint(equalTo: topBarView.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: topBarStackView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
//    init(text: String ,collectionViewLayout: UICollectionViewLayout) {
//        super.init(collectionViewLayout: collectionViewLayout)
//
//        self.text = text
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    @objc func rightButtonAction(){
        goToPlanEditView()
    }
    
    func goToPlanEditView(){
        let planEdit = PlanEditViewController()
        navigationController?.pushViewController(planEdit, animated: true)
        
    }

}

class PlanDetailViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let tagList = ["腿部","背部","三角肌","肱二头肌"]
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "深蹲"
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    //This label is used to calculate the size of the text
    //For TagViewCell to setting the fit size
    let sizeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect.zero
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    
    let checkBox: AnimatedButton = {
        /// Create a button.
        let button = AnimatedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        /// Set an animation on the button.
        button.animation = Animation.named("checkbox3")
        
        /// Turn off clips to bounds, as the animation goes outside of the bounds.
        button.clipsToBounds = false
        
        /// Set animation play ranges for touch states
        
        /// Set the button state
        button.isSelected = false
        button.setPlayRange(fromProgress: 0, toProgress: 0.46, event: .touchUpInside)
        
        return button
    }()
    
    let tagCellId = "tagCellId"
    
    let tagCollectionView : UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
        let layout = LeftAlignedCollectionViewFlowLayout()
        
        layout.minimumInteritemSpacing = 5
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        
        return collection
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: tagCellId, for: indexPath) as! TagViewCell
        
        cell.text = tagList[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        sizeLabel.text = tagList[indexPath.row]
        sizeLabel.sizeToFit()
        
        //Widh and height increase 6 to have a marin
        return CGSize(width: sizeLabel.frame.width + 6, height: sizeLabel.frame.height + 6)
    }

    
// MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCell()
        setupSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewCell(){
        let borderLayer = CALayer()
        self.layer.addSublayer(borderLayer)

        borderLayer.frame = CGRect(x: 15, y: layer.bounds.height - 1, width: layer.bounds.width, height: 1)
        borderLayer.borderColor = UIColor.gray.cgColor
        borderLayer.borderWidth = 1
    }
    
    @objc func checkBoxAction(){
        print(checkBox.isSelected)
        if(checkBox.isSelected == false){
            checkBox.isSelected = true
            checkBox.setPlayRange(fromProgress: 46, toProgress: 1, event: .touchUpInside)
        } else{
            checkBox.isSelected = false
            checkBox.setPlayRange(fromProgress: 0, toProgress: 0.46, event: .touchUpInside)
        }
    }
    
    func setupSubView(){
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 15)
        ])
        
        
        // Setup checkbox layout
        addSubview(checkBox)
        NSLayoutConstraint.activate([
            checkBox.heightAnchor.constraint(equalToConstant: 30),
            checkBox.widthAnchor.constraint(equalToConstant: 30),
            checkBox.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -5),
            checkBox.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
        ])
        
        checkBox.addTarget(self, action: #selector(checkBoxAction), for: .touchUpInside)
 
 
        //Setup the tagCollectionView
        addSubview(tagCollectionView)
        NSLayoutConstraint.activate([
            tagCollectionView.heightAnchor.constraint(equalToConstant: 70),
            tagCollectionView.widthAnchor.constraint(equalToConstant: 200),
            tagCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 15),
            tagCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15)
        ])
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagViewCell.self, forCellWithReuseIdentifier: tagCellId)
        
    }
    
}

class TagViewCell : UICollectionViewCell {
    
    var text : String? {
        didSet{
            textLabel.text = text
        }
    }
    
    let textLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = Color.bodyText.value
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        backgroundColor = .clear
        layer.borderWidth = 1
        layer.borderColor = Color.borderColor.value.cgColor
        
        self.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        
//        self.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            self.heightAnchor.constraint(equalToConstant: 10),
//            self.widthAnchor.constraint(equalToConstant: 10)
//        ])
        
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            textLabel.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        
        
    }
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}






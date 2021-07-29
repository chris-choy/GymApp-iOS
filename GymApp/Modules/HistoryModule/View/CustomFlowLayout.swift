//
//  CustomFlowLayout.swift
//  GymApp
//
//  Created by Chris on 2021/3/3.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit



// https://stackoverflow.com/a/51231881

final class CustomFlowLayout: UICollectionViewFlowLayout {
    
    //作用：返回rect中的所有元素的布局属性。
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)?.map{ $0.copy() } as? [UICollectionViewLayoutAttributes]
        
        layoutAttributesObjects?.forEach({ layoutAttributes in
            if layoutAttributes.representedElementCategory == .cell {
                if let newFrame = layoutAttributesForItem(at: layoutAttributes.indexPath)?.frame {
                    layoutAttributes.frame = newFrame
                }
            }
        })
        return layoutAttributesObjects
    }
    
    
    //作用：返回对应indexPath的位置的cell的布局属性。
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView else {
            fatalError()
        }
        guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
            return nil
        }

        layoutAttributes.frame.origin.x = sectionInset.left
        layoutAttributes.frame.size.width = collectionView.safeAreaLayoutGuide.layoutFrame.width - sectionInset.left - sectionInset.right
        return layoutAttributes
    }

}

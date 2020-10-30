//
//  CustomHeaderLayout.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 10/21/20.
//

import UIKit

class CustomHeaderLayout: UICollectionViewFlowLayout {
   
   override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      let layoutAttributes = super.layoutAttributesForElements(in: rect)
      
      layoutAttributes?.forEach({ (attributes) in
         if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0 {
            
            guard let collectionView = collectionView else { return }
            let contentOffSetY = collectionView.contentOffset.y
            
            if contentOffSetY > 0 {
               sectionHeadersPinToVisibleBounds = true
            } else {
               sectionHeadersPinToVisibleBounds = false
            }
            
            let width = collectionView.frame.width
            let height = attributes.frame.height - contentOffSetY
            
            attributes.frame = .init(x: 0, y: contentOffSetY, width: width, height: height)
            
         }
      })
      
      return layoutAttributes
   }
   
   override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
      true
   }

}

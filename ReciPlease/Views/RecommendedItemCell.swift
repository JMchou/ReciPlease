//
//  RecommendedItemCell.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 9/30/20.
//

import UIKit

class RecommendedItemCell: UICollectionViewCell {
   
   @IBOutlet weak var foodImage: UIImageView!
   @IBOutlet weak var foodName: UILabel!
   
   static var identifer: String {
      String(describing: RecommendedItemCell.self)
   }
   
}

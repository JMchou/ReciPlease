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
   @IBOutlet weak var calorieLabel: UILabel!
   
   static var identifer: String {
      String(describing: RecommendedItemCell.self)
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
   }
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      layer.cornerRadius = 20
      clipsToBounds = true
      layer.borderWidth = 0.2
      layer.borderColor = UIColor(white: 0.3, alpha: 0.3).cgColor
   }
   
}

//
//  TitleCollectionViewCell.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 10/23/20.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
   
   @IBOutlet weak var foodTitle: UILabel!
   @IBOutlet weak var scoreLabel: UILabel!
   
   @IBOutlet weak var firstStar: UIImageView!
   @IBOutlet weak var secondStar: UIImageView!
   @IBOutlet weak var thirdStar: UIImageView!
   @IBOutlet weak var fourthStar: UIImageView!
   @IBOutlet weak var fivthStar: UIImageView!
   
   static var identifier: String {
      String(describing: TitleCollectionViewCell.self)
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      displayStars()
   }
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
   }
   
   
   private func displayStars() {
      
   }
   
}

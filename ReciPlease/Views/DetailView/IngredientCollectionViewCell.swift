//
//  IngredientCollectionViewCell.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 10/20/20.
//

import UIKit

class IngredientCollectionViewCell: UICollectionViewCell {
    
   @IBOutlet weak var ingredientName: UILabel!
   @IBOutlet weak var IngredientAmount: UILabel!
   
   static var identifier: String {
      String(describing: IngredientCollectionViewCell.self)
   }
}

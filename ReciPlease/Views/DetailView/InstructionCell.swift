//
//  InstructionCell.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 10/28/20.
//

import UIKit

class InstructionCell: UICollectionViewCell {
   
   @IBOutlet weak var iconImage: UIImageView!
   @IBOutlet weak var instructionText: UILabel!
   
   static var identifier: String {
      String(describing: InstructionCell.self)
   }
}

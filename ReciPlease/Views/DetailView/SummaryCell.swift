//
//  SummaryCell.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 10/23/20.
//

import UIKit

class SummaryCell: UICollectionViewCell {
   
   @IBOutlet weak var summaryText: UILabel!
   
   static var identifier: String {
      String(describing: SummaryCell.self)
   }
}

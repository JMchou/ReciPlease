//
//  DetailHeaderView.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 10/20/20.
//

import UIKit

class DetailHeaderView: UICollectionReusableView {
   
   @IBOutlet weak var headerImage: UIImageView!
   
   static var identifier: String {
      String(describing: DetailHeaderView.self)
   }
        
   
}

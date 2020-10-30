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



//MARK: - Custom Footer view

class DetailFooterView: UICollectionReusableView {
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      backgroundColor = .white
   }
   
   required init?(coder: NSCoder) {
      fatalError()
   }
   
   static var identifier: String {
      String(describing: DetailFooterView.self)
   }
}

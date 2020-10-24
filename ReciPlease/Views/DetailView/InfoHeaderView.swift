//
//  InfoHeaderView.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 10/23/20.
//

import UIKit

class InfoHeaderView: UICollectionReusableView {
   
   var sectionTitle: UILabel = {
      let label = UILabel()
      return label
   }()
   
   static var identifier: String {
      String(describing: InfoHeaderView.self)
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      backgroundColor = .white
      addSubview(sectionTitle)
      configureView()
   }
   
   required init?(coder: NSCoder) {
      fatalError("failed to initialize info Header view")
   }
   
   private func configureView() {
      
      sectionTitle.translatesAutoresizingMaskIntoConstraints = false
      sectionTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
      sectionTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
   }
        
}

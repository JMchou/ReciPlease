//
//  tabBarViewController.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 9/27/20.
//

import UIKit

class tabBarViewController: UITabBarController {
   
   override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      tabBar.layer.masksToBounds = true
      tabBar.barStyle = .default
      tabBar.layer.cornerRadius = 35
      tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      // Do any additional setup after loading the view.
   }
   
}


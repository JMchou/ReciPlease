//
//  HomeViewController.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 9/25/20.
//

import UIKit

class HomeViewController: UIViewController {
   
   @IBOutlet weak var topBackground: UIImageView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
   
      // Do any additional setup after loading the view.
      configureUI()
   }
   
   
   /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    }
    */
   
}



//MARK: - Configure UI

extension HomeViewController {
   
   private func configureUI() {
      
//      let topBackgroundHeight = topBackground.frame.height
//      topBackground.layer.cornerRadius = topBackgroundHeight / 5
//      topBackground.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
   }
}

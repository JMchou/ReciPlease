//
//  DetailViewController.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 10/4/20.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   @IBAction func backButtonPressed(_ sender: UIButton) {
      
      navigationController?.popViewController(animated: true)
   }
   
   
}

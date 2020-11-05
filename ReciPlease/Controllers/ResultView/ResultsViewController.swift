//
//  ResultsViewController.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 10/7/20.
//

import UIKit

class ResultsViewController: UIViewController {
   
   var query: String? {
      didSet {
         print(query)
      }
   }
   
   @IBOutlet weak var tableView: UITableView!
   
   static var identifier: String {
      String(describing: ResultsViewController.self)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      tableView.dataSource = self
      // Do any additional setup after loading the view.
   }
   
   @IBAction func returnButtonPressed(_ sender: UIButton) {
      
      navigationController?.popViewController(animated: true)
   }
   
   fileprivate func fetchRecipe(query: String) {
      
   }
   
}

//MARK: - TableView Datasource & Delegate methods

extension ResultsViewController: UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 5
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      guard let cell  = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell") as? ResultTableViewCell
      else {
         fatalError()
      }
      cell.cellView.layer.cornerRadius = 20
      cell.cellView.layer.masksToBounds = true
      cell.layer.cornerRadius = 20
      return cell
   }
}



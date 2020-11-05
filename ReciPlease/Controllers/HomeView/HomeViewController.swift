//
//  HomeViewController.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 9/25/20.
//

import UIKit
import Firebase
import SDWebImage

class HomeViewController: UIViewController {
   
   //MARK: - IBOutlets
   @IBOutlet weak var topBackground: UIImageView!
   @IBOutlet weak var profileImage: UIImageView!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   @IBOutlet weak var searchBar: TextFieldWithPadding!
   
   @IBOutlet weak var ketoButton: UIButton!
   @IBOutlet weak var spicyButton: UIButton!
   @IBOutlet weak var veganButton: UIButton!
   @IBOutlet weak var seafoodButton: UIButton!
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   //MARK: - Properties
   enum Section {
      case main
   }
   
   var dataSource: UICollectionViewDiffableDataSource<Section, Recipes>!
   
   var returnedRecipes = [Recipes]()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
      // ...
      collectionView.delegate = self
      searchBar.delegate = self
      
      configureUI()
      let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
      tap.cancelsTouchesInView = false
      view.addGestureRecognizer(tap)
      
      collectionView.collectionViewLayout = configureCollectionViewLayout()
      configureDiffDataSource()
      activityIndicator.startAnimating()
      fetchData()
   }
   
   fileprivate func fetchData() {
      
      NetworkClient.shared.fetchRandomRecipe() { (result, error) in
         if let error = error {
            print("Failed to retrieve data \(error)")
         }
         
         self.returnedRecipes = result?.results ?? []
         DispatchQueue.main.async {
            self.updateTableView()
            self.activityIndicator.stopAnimating()
         }
      }
   }
   
   //MARK: - IBActions
   
   @IBAction func categoryButtonPressed(_ sender: UIButton) {
      //set recommendation food type categories
      
      ketoButton.backgroundColor = UIColor(named: "category")
      spicyButton.backgroundColor = UIColor(named: "category")
      veganButton.backgroundColor = UIColor(named: "category")
      seafoodButton.backgroundColor = UIColor(named: "category")
      
      sender.backgroundColor = UIColor(named: "selected")
   }
   
   @IBAction func searchPressed(_ sender: UIButton) {
      
      //Present result tableView
     // guard let queryString = searchBar.text else { return }
      
      if let resultsVC = storyboard?.instantiateViewController(identifier: ResultsViewController.identifier) as? ResultsViewController {
         resultsVC.query = "I love you"
         navigationController?.pushViewController(resultsVC, animated: true)
      }
      
      searchBar.resignFirstResponder()
   }
   
}


//MARK: - Configure UI

extension HomeViewController {
   
   private func configureUI() {
      
      navigationController?.isNavigationBarHidden = true
      
      profileImage.layoutIfNeeded()
      let profileImageWidth = profileImage.frame.width
      profileImage.layer.cornerRadius = profileImageWidth / 2
      
      searchBar.layoutIfNeeded()
      let searchBarHeight = searchBar.frame.height
      searchBar.layer.cornerRadius = searchBarHeight / 2
      searchBar.overrideUserInterfaceStyle = .light
      
      ketoButton.layoutIfNeeded()
      let buttonsWidth = ketoButton.frame.width
      ketoButton.layer.cornerRadius = buttonsWidth / 2
      spicyButton.layer.cornerRadius = buttonsWidth / 2
      veganButton.layer.cornerRadius = buttonsWidth / 2
      seafoodButton.layer.cornerRadius = buttonsWidth / 2
      
      let paddingSize = (0.10 * buttonsWidth)
      ketoButton.imageEdgeInsets = .init(top: paddingSize, left: paddingSize, bottom: paddingSize, right: paddingSize)
      spicyButton.imageEdgeInsets = .init(top: paddingSize, left: paddingSize, bottom: paddingSize, right: paddingSize)
      veganButton.imageEdgeInsets = .init(top: paddingSize, left: paddingSize, bottom: paddingSize, right: paddingSize)
      seafoodButton.imageEdgeInsets = .init(top: paddingSize, left: paddingSize, bottom: paddingSize, right: paddingSize)
      
   }
}


//MARK: - Collection View Layout configuration & DataSource

extension HomeViewController {
   
   //configure the layout of the collectionView
   func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
      
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .groupPaging
      
      return UICollectionViewCompositionalLayout(section: section)
   }
   
   //configure the datasource and setup the initial data snapshot
   func configureDiffDataSource() {
      dataSource = UICollectionViewDiffableDataSource<Section, Recipes>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
         
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedItemCell.identifer, for: indexPath) as? RecommendedItemCell else {
            fatalError("Cannot create new cell")
         }
         
         cell.foodName.text = item.title
         cell.foodImage.contentMode = .scaleAspectFill
         cell.foodImage.sd_setImage(with: URL(string: item.image), completed: nil)
         
         let calorie = item.nutrition.nutrients[0].amount
         let unit = item.nutrition.nutrients[0].unit
      
         let caloriesString = String(format: "%.2f", calorie) + " \(unit)"
         cell.calorieLabel.text = caloriesString
         
         return cell
      }
      
      var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Recipes>()
      initialSnapshot.appendSections([.main])
      initialSnapshot.appendItems(returnedRecipes, toSection: .main)
      
      dataSource.apply(initialSnapshot, animatingDifferences: false)
   }
   
   func updateTableView() {
      var snapShot = NSDiffableDataSourceSnapshot<Section, Recipes>()
      snapShot.appendSections([.main])
      snapShot.appendItems(returnedRecipes, toSection: .main)
      dataSource.apply(snapShot, animatingDifferences: false)
   }
   
}

//MARK: - Collection View delegate methods

extension HomeViewController: UICollectionViewDelegate {
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
      // go to detail view
      if let detailVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
         detailVC.modalTransitionStyle = .flipHorizontal
         navigationController?.pushViewController(detailVC, animated: true)
      }
   }
}


//MARK: - Textfield Delegate methods

extension HomeViewController: UITextFieldDelegate {
   
   //Make api calls when user finishing typing.
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      guard let queryString = textField.text else { return false }
      
      print(queryString)
      searchBar.resignFirstResponder()
      return true
   }
}

//
//  HomeViewController.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 9/25/20.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
   
   //MARK: - IBOutlets
   @IBOutlet weak var topBackground: UIImageView!
   @IBOutlet weak var profileImage: UIImageView!
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
   
   var dataSource: UICollectionViewDiffableDataSource<Section, RecommendedItem>!
   
   
   let source = [RecommendedItem(name: "jiaming"), RecommendedItem(name: "Rongjia"), RecommendedItem(name: "xiaozhu")]
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
      // ...
      configureUI()
      collectionView.collectionViewLayout = configureCollectionViewLayout()
      configureDiffDataSource()
   }
   
   //MARK: - IBActions
   
   @IBAction func redButton(_ sender: UIButton) {
      
      
      let displayName = "Jiaming Chou"
      
      let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
      changeRequest?.displayName = displayName
      changeRequest?.commitChanges { (error) in
         // ...
      }
   }
   
   @IBAction func blackButton(_ sender: UIButton) {
      
      let user = Auth.auth().currentUser
      if let user = user {
         // The user's ID, unique to the Firebase project.
         print(user.displayName ?? "No names")
         print(user.uid)
      }
   }
}


//MARK: - Configure UI

extension HomeViewController {
   
   private func configureUI() {
      
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
      
      let section = NSCollectionLayoutSection(group: group)
      
      return UICollectionViewCompositionalLayout(section: section)
   }
   
   //configure the datasource and setup the initial data snapshot
   func configureDiffDataSource() {
      dataSource = UICollectionViewDiffableDataSource<Section, RecommendedItem>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
         
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedItemCell.identifer, for: indexPath) as? RecommendedItemCell else {
            fatalError("Cannot create new cell")
         }
         cell.nameLabel.text = item.name
         cell.layer.cornerRadius = 20
         
         return cell
      }
      
      var initialSnapshot = NSDiffableDataSourceSnapshot<Section, RecommendedItem>()
      initialSnapshot.appendSections([.main])
      initialSnapshot.appendItems(source, toSection: .main)
      
      dataSource.apply(initialSnapshot, animatingDifferences: false)
   }
   
}

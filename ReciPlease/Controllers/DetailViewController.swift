//
//  DetailViewController.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 10/4/20.
//

import UIKit

class DetailViewController: UIViewController {

   @IBOutlet weak var collectionView: UICollectionView!
   
   override func viewDidLoad() {
        super.viewDidLoad()
      
      collectionView.dataSource = self
      collectionView.delegate = self
      collectionView.contentInsetAdjustmentBehavior = .never
      collectionView.collectionViewLayout = CustomHeaderLayout()
      collectionView.register(InfoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InfoHeaderView.identifier)
        // Do any additional setup after loading the view.
    }
}

//MARK: - CollectionView Delegate and DataSource methods

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
   func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 3
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      switch section {
      case 0:
         return 1
      case 1:
         return 1
      default:
         return 1
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let section = indexPath.section
      
      switch section {
      case 0:
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            fatalError("Failed to dequeue ingredient cell.")
         }
         return cell
      case 1:
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCell.identifier, for: indexPath) as? SummaryCell else {
            fatalError("Failed to dequeue ingredient cell.")
         }
         return cell
      default:
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCollectionViewCell.identifier, for: indexPath) as? IngredientCollectionViewCell else {
            fatalError("Failed to dequeue ingredient cell.")
         }
         return cell
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      
      let section = indexPath.section
      
      switch section {
      case 0:
         guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeaderView.identifier, for: indexPath) as? DetailHeaderView else {
            fatalError("Failed to dequeue headerView")
         }
         return header
         
      case 1:
         guard let infoHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InfoHeaderView.identifier, for: indexPath) as? InfoHeaderView else {
            fatalError("Failed to dequeue headerView")
         }
         infoHeader.sectionTitle.text = "OverView"
         return infoHeader
      default:
         guard let infoHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InfoHeaderView.identifier, for: indexPath) as? InfoHeaderView else {
            fatalError("Failed to dequeue headerView")
         }
         infoHeader.sectionTitle.text = "Ingredient"
         return infoHeader
      }
   }
   
   
}
 
//MARK: - CollectionView Layout Configuration

extension DetailViewController: UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      let section = indexPath.section
      
      switch section {
      case 0:
         return .init(width: self.view.frame.width, height: 100)
      case 1:
         return .init(width: self.view.frame.width, height: 300)
      default:
         return .init(width: self.view.frame.width, height: collectionView.cellForItem(at: indexPath)?.frame.height ?? 50)
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      
      switch section {
      case 0:
         return .init(width: view.frame.width, height: view.frame.height/3)
      default:
         return .init(width: view.frame.width, height: view.frame.height/10)
      }
   }
   
}

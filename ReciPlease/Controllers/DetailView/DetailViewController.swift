//
//  DetailViewController.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 10/4/20.
//

import UIKit

class DetailViewController: UIViewController {
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   let sampleText = "Chicken Wings can be paired with Chardonnay, Pinot Noir, and Sauvignon Blanc. White meat is typically paired with white wine as to not overpower the flavor of the meat, so chardonnay and sauvignon blanc are safe choices. Chicken prepared with a tomato sauce or certainly a red wine sauce can and should be served with a red like a pinot noir. You could try William Hill Estate Winery Chardonnay , Official Wine of the PGA TOUR. Reviewers quite like it with a 5 out of 5 star rating and a price of about 23 dollars per bottle."
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      collectionView.dataSource = self
      collectionView.delegate = self
      
      configureCollectionView()
      // Do any additional setup after loading the view.
   }
   
   private func configureCollectionView() {
      
      collectionView.contentInsetAdjustmentBehavior = .never
      
      //Register headerView
      collectionView.collectionViewLayout = CustomHeaderLayout()
      collectionView.register(InfoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InfoHeaderView.identifier)
      
      collectionView.register(DetailFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DetailFooterView.identifier)
   }
}

//MARK: - CollectionView Delegate and DataSource methods

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
   func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 4
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      switch section {
      case 0:
         return 1
      case 1:
         return 1
      case 3:
         return 5
      default:
         return 5
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
         cell.summaryText.text = sampleText
         return cell
         
      case 3:
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstructionCell.identifier, for: indexPath) as? InstructionCell else {
            fatalError("Failed to dequeue ingredient cell.")
         }
         let imageName = "\(indexPath.item + 1).circle.fill"
         cell.iconImage.image = UIImage(systemName: imageName)
         
         
         return cell
         
      default:
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCollectionViewCell.identifier, for: indexPath) as? IngredientCollectionViewCell else {
            fatalError("Failed to dequeue ingredient cell.")
         }
         return cell
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      
      if kind == UICollectionView.elementKindSectionHeader {
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
            infoHeader.sectionTitle.text = "—  OverView  —"
            return infoHeader
            
         case 3:
            guard let infoHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InfoHeaderView.identifier, for: indexPath) as? InfoHeaderView else {
               fatalError("Failed to dequeue headerView")
            }
            infoHeader.sectionTitle.text = "—  Instructions  —"
            return infoHeader
            
         default:
            guard let infoHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InfoHeaderView.identifier, for: indexPath) as? InfoHeaderView else {
               fatalError("Failed to dequeue headerView")
            }
            infoHeader.sectionTitle.text = "—  Ingredients  —"
            return infoHeader
         }
      }  else {
         
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DetailFooterView.identifier, for: indexPath) as? DetailFooterView else {
               fatalError("Failed to dequeue headerView")
            }
            return footer
         
      }
   }
   
   
   //Update layout setting when collectionView is scroll to upward. 
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let contentOffSet = collectionView.contentOffset.y
      if contentOffSet < 0 {
         collectionView.collectionViewLayout.invalidateLayout()
      }
   }
   
   
}

//MARK: - CollectionView Layout Configuration

extension DetailViewController: UICollectionViewDelegateFlowLayout {
   
   //Configure the cell size for each section
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      let section = indexPath.section
      
      switch section {
      case 0:
         return .init(width: self.view.frame.width, height: 150)
      case 1:
         
         let size = CGSize(width: view.frame.width - 20, height: 500)
         let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
         let estimatedFrame = NSString(string: sampleText).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
         
         return CGSize(width: self.view.frame.width, height: estimatedFrame.height)
      default:
         return .init(width: self.view.frame.width, height: collectionView.cellForItem(at: indexPath)?.frame.height ?? 50)
      }
   }
   
   //Setting the minimum line space between cell for each section to 0
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
   }
   
   //Configure the header size for each section
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      
      switch section {
      case 0:
         return .init(width: view.frame.width, height: view.frame.height/3)
      default:
         return .init(width: view.frame.width, height: view.frame.height/10)
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
      switch section {
      case 3:
         return .init(width: view.frame.width, height: 100)
      default:
         return .init(width: view.frame.width, height: 0)
      }
      
   }
   
}

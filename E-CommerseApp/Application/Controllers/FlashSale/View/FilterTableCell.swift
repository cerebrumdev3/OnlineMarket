//
//  FilterTableCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 29/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class FilterTableCell: UITableViewCell {
    
    //MARK:- outlet and variables
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var kCollectionHeight: NSLayoutConstraint!
    var filterArray = ["All","men shirts","Men's Flip-Flop & Slippers","Fashion","women wear","shoes"]
    
    private let spacing:CGFloat = 2.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.collectionViewLayout.invalidateLayout()
        
        
        
//        let layout = UICollectionViewFlowLayout()
//                  layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//                  layout.minimumLineSpacing = spacing
//                  layout.minimumInteritemSpacing = spacing
//                  self.collectionView?.collectionViewLayout = layout
                      collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//MARK:- CollectionView Delegate and DataSource
extension FilterTableCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.FilterCollectionCell, for: indexPath) as? FilterCollectionCell
        {
            // cell.setView()
            cell.lblFilterType.text = filterArray[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
    
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let text = self.filterArray[indexPath.row]
           let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:10.0)]).width + 38.0
           return CGSize(width: cellWidth, height: 38.0)
       }
    // Swift 3.0
//MARK:- FlowLayout
//func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//{
////    let noOfCellsInRow = 3  //number of column you want
////    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
////    let totalSpace = flowLayout.sectionInset.left
////        + flowLayout.sectionInset.right
////        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
////    let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
////    return CGSize(width: size, height: 38)
//
//   // return CGSize(width: collectionView.bounds.size.width, height: CGFloat(38))
//
//  if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.FilterCollectionCell, for: indexPath) as? FilterCollectionCell
//  {
//           cell.lblFilterType.text = "Newest" //this is for the "Newest" cell. Of curse you should set the proper title for each indexPath
//           cell.setNeedsLayout()
//        //   cell.layoutIfNeede()
//           return CGSize(width: cell.contentView.frame.width , height: cell.contentView.frame.height)
//       }  else {
//           return CGSize(width: 10, height: 10)
//       }
//
//}
    
    
}

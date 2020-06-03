//
//  MiddleBannerTableCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 25/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class MiddleBannerTableCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var recommendedList = [Recommended]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
//MARK:- Delegate and DataSource

extension MiddleBannerTableCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.MiddleBannerCollectionCell, for: indexPath) as? MiddleBannerCollectionCell
        {
            cell.setView(recommendedList:recommendedList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
      }
    
    // UICollectionViewDelegateFlowLayout
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //
    //        let noOfCellsInRow = 2  //number of column you want
    //               let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
    //               let totalSpace = flowLayout.sectionInset.left
    //                   + flowLayout.sectionInset.right
    //                   + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
    //               let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
    //               return CGSize(width: size, height: 104)
    //       //return CGSize(width: 233.0, height: 120.0)
    //    }
    
    
}

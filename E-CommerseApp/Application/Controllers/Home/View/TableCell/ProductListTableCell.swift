//
//  ProductListTableCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 25/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class ProductListTableCell: UITableViewCell {
    //MARK:- Outlet and variables
    
    @IBOutlet weak var kCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    let margin: CGFloat = 14
    private let spacing:CGFloat = 14.0
     var recommendedList = [Recommended]()
    var serviceList = [Service1]()
    var isFromFlashSale : Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.collectionViewLayout.invalidateLayout()
       
       // collectionView.reloadData()
        
        //MARK:- SetLayout Collection Cell
//               guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//
//               flowLayout.minimumInteritemSpacing = margin
//               flowLayout.minimumLineSpacing = margin
//               flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let layout = UICollectionViewFlowLayout()
           layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
           layout.minimumLineSpacing = spacing
           layout.minimumInteritemSpacing = spacing
           self.collectionView?.collectionViewLayout = layout
               collectionView.reloadData()
    }
    
    //MARK:- SetView
       func setView()
       {
        var listCount = 0
        if isFromFlashSale == true
        {
            listCount = serviceList.count
        }
        else{
           listCount = recommendedList.count
        }
      //  kCollectionHeight.constant = 0
        if (listCount > 1){
            kCollectionHeight.constant = ((kCollectionHeight.constant / 2) * CGFloat(listCount) + 98)
        }
        else{
            kCollectionHeight.constant = ((kCollectionHeight.constant) * CGFloat(listCount))

        }
           collectionView.reloadData()
       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension ProductListTableCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var listCount = 0
        if isFromFlashSale == true
        {
            listCount = serviceList.count
        }
        else{
           listCount = recommendedList.count
        }
        return listCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.ProductListCollectionCell, for: indexPath) as? ProductListCollectionCell
        {
            if isFromFlashSale == true
                   {
                    cell.setSaleData(recommendedList:serviceList[indexPath.row])
                   }
        else{
            cell.setView(recommendedList:recommendedList[indexPath.row])
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
    
   //MARK:- FlowLayout
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
           let noOfCellsInRow = 2  //number of column you want
           let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
           let totalSpace = flowLayout.sectionInset.left
               + flowLayout.sectionInset.right
               + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
           let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
           return CGSize(width: size, height: 282)
       }
    
 
    
}

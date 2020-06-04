//
//  FlashSaleTableCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 25/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class FlashSaleTableCell: UITableViewCell {
     //MARK:- Outlet and variables
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnSeeMore: UIButton!
    
    var viewDelegate :HomeVcDelegate?
     var saleList = [Sale]()
    var recommendedList = [Recommended1]()
    var isFromDetail = false
    var currency :String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }
    //MARK:- other functions
    func  setView()
    {
       btnSeeMore.setTitleColor(Appcolor.klightOrangeColor, for: .normal)
    }
    //MARK:- ACtions
    @IBAction func seeMoreAction(_ sender: Any) {
        viewDelegate?.flashSale()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//MARK:- Delegate and DataSource

extension FlashSaleTableCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if isFromDetail == true
        {
            count = recommendedList.count
        }
        else{
            count = saleList.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.FlashSaleCollectionCell, for: indexPath) as? FlashSaleCollectionCell
        {
            if isFromDetail == true
            {
                cell.setDetailView(saleList:recommendedList[indexPath.row],currency:currency)
            }
            else{
                cell.setView(saleList:saleList[indexPath.row],currency:currency)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        viewDelegate?.productDetail(id:saleList[indexPath.row].id, title: saleList[indexPath.row].name ?? "")
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

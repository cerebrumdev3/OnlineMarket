//
//  SelectSizeTableCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 27/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit
import Cosmos

class SelectSizeTableCell: UITableViewCell {
    
    //MARK:-outlet and Variables
    @IBOutlet weak var collectionViewSize: UICollectionView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var btnAddFavorite: UIButton!
    @IBOutlet weak var lblProductNAme: UILabel!
    
    var sizeArray = [StockQunatity]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewSize.delegate = self
        collectionViewSize.dataSource = self
        collectionViewSize?.collectionViewLayout.invalidateLayout()
    }
    //MARK:- Actions
    
    @IBAction func btnAddFavorite(_ sender: Any) {
    }
    
    //MARK:- Other functions
    
    func  setView(allData:Body12?)
    {
        lblPrice.textColor = Appcolor.kTheme_Color
        lblProductNAme.text = allData?.name ?? ""
        lblPrice.text = (allData?.currency ?? "") + (allData?.originalPrice ?? "")
        viewRating.rating = Double(allData?.rating ?? 0)
        
        if let sizeData = allData?.productSpecifications{
        if sizeData.count > 0
        {
            for data in sizeData{
                if let sizeList = data.stockQunatity{
                    for avaliableProduct in sizeList{
                        if avaliableProduct.stock != "0"
                        {
                            sizeArray = sizeList
                        }
                    }
                
                }
            }
        }
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//MARK:- Delegate and DataSource
extension SelectSizeTableCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sizeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.SelectSizeCollectionCell, for: indexPath) as? SelectSizeCollectionCell
        {
            cell.setView(sizeArray:sizeArray[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
       collectionView.deselectItem(at: indexPath, animated: false)
             if let cell = collectionView.cellForItem(at: indexPath) as? SelectSizeCollectionCell {
                cell.viewBack.borderColor = Appcolor.kSelectedBlueColor
             }
         }
    
       
//        // Swift 3.0
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return CGSize(width: CGFloat((collectionView.frame.size.width / 4) - 4), height: CGFloat(60))
//        }
    
    
    
}

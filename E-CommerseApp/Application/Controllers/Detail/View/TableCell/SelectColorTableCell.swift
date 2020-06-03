//
//  SelectColorTableCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 27/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class SelectColorTableCell: UITableViewCell {
    
//MARK:- outlet and variables
    @IBOutlet weak var collectionViewColor: UICollectionView!
    @IBOutlet weak var lblSelectColor: UILabel!
    
    var colorList = [ProductSpecification12]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewColor.delegate = self
        collectionViewColor.dataSource = self
        collectionViewColor?.collectionViewLayout.invalidateLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//MARK:- Delegate and DataSource
extension SelectColorTableCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.SelectColorCollectionCell, for: indexPath) as? SelectColorCollectionCell
        {
            cell.setView(colorList:colorList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
    
    // Swift 3.0
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: CGFloat((collectionView.frame.size.width / 4) - 4), height: CGFloat(122))
//    }
    
    
    
}

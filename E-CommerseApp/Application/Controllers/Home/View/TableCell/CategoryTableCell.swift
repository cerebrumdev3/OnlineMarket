//
//  CategoryTableCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 25/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class CategoryTableCell: UITableViewCell {
    //MARK:- outlet and variables
    
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblCategory: UILabel!
    let margin: CGFloat = 4
    var viewDelegate:HomeVcDelegate?
    var categoryList = [CategoryElement]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.collectionViewLayout.invalidateLayout()
        
        //MARK:- SetLayout Collection Cell
        guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.reloadData()
        
    }
   func  setView(){
    btnMore.setTitleColor(Appcolor.klightOrangeColor, for: .normal)
    }
    
    @IBAction func moreCategoryAction(_ sender: Any) {
        viewDelegate?.moreCategories(index: (sender as AnyObject).tag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
//MARK:- Delegate and DataSource

extension CategoryTableCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.CategoryCollectionCell, for: indexPath) as? CategoryCollectionCell
        {
            cell.setView(categoryList:categoryList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        viewDelegate?.cotegorySelected(id:categoryList[indexPath.row].id ?? "")
    }
    
  // Swift 3.0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: CGFloat((collectionView.frame.size.width / 4) - 4), height: CGFloat(122))
   }
    
    
    
}

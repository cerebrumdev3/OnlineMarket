//
//  TableViewCell.swift
//  DynamicHeightCollectionView
//
//  Created by Payal Gupta on 11/02/19.
//  Copyright © 2019 Payal Gupta. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    //MARK:- outlet and variables
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var kCollectionHeight: NSLayoutConstraint!
    
    var arr = [String]()
    //    var categoryList = [FiltersCategory]()
    //    var brandList = [BrandCategory]()
    var category,brand,rating,sortBy :Bool?
    
    func configure() {
        //   self.arr = arr
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
    }
    
    
}

extension TableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if  category == true{
            count = FlasSaleVC.categoryList.count
        }
        else if brand == true{
            count = FlasSaleVC.brandList.count
        }
        else if rating == true{
            count = FlasSaleVC.ratingList.count
        }
        else{
            count = FlasSaleVC.sortByList.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        if  category == true{
            cell.textLabel.text = FlasSaleVC.categoryList[indexPath.row].name ?? ""
            if FlasSaleVC.categoryList[indexPath.row].isSelected == true
            {
                cell.contentView.layer.borderColor = Appcolor.kTheme_Color.cgColor
                cell.contentView.backgroundColor = Appcolor.kbtnlightOrangeColor
                cell.imgTick.isHidden = false
                cell.kImgWidth.constant = 20
            }
            else
            {
                cell.contentView.layer.borderColor = UIColor.gray.cgColor
                cell.contentView.backgroundColor = UIColor.white
                cell.imgTick.isHidden = true
                cell.kImgWidth.constant = 0
            }
        }
        else if brand == true{
            cell.textLabel.text = FlasSaleVC.brandList[indexPath.row].id ?? ""
            
            if FlasSaleVC.brandList[indexPath.row].isSelected == true
            {
                cell.contentView.layer.borderColor = Appcolor.kTheme_Color.cgColor
                cell.contentView.backgroundColor = Appcolor.kbtnlightOrangeColor
                cell.imgTick.isHidden = false
                cell.kImgWidth.constant = 20
            }
            else
            {
                cell.contentView.layer.borderColor = UIColor.gray.cgColor
                cell.contentView.backgroundColor = UIColor.white
                cell.imgTick.isHidden = true
                cell.kImgWidth.constant = 0
            }
        }
        else if rating == true{
            cell.textLabel.text = FlasSaleVC.ratingList[indexPath.row].name ?? ""
            
            if FlasSaleVC.ratingList[indexPath.row].isSelected == true
            {
                cell.contentView.layer.borderColor = Appcolor.kTheme_Color.cgColor
                cell.contentView.backgroundColor = Appcolor.kbtnlightOrangeColor
                cell.imgTick.isHidden = false
                cell.kImgWidth.constant = 20
            }
            else
            {
                cell.contentView.layer.borderColor = UIColor.gray.cgColor
                cell.contentView.backgroundColor = UIColor.white
                cell.imgTick.isHidden = true
                cell.kImgWidth.constant = 0
            }
        }
        else{
            cell.textLabel.text = FlasSaleVC.sortByList[indexPath.row].name ?? ""
            
            if FlasSaleVC.sortByList[indexPath.row].isSelected == true
            {
                cell.contentView.layer.borderColor = Appcolor.kTheme_Color.cgColor
                cell.contentView.backgroundColor = Appcolor.kbtnlightOrangeColor
                cell.imgTick.isHidden = false
                cell.kImgWidth.constant = 20
            }
            else
            {
                cell.contentView.layer.borderColor = UIColor.gray.cgColor
                cell.contentView.backgroundColor = UIColor.white
                cell.imgTick.isHidden = true
                cell.kImgWidth.constant = 0
            }
        }
        //  cell.textLabel.text = self.arr[indexPath.row]
        return cell
    }
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if category == true{
            if FlasSaleVC.categoryList[indexPath.row].isSelected == false
            {
                FlasSaleVC.categoryList[indexPath.row].isSelected = true
            }
            else
            {
                FlasSaleVC.categoryList[indexPath.row].isSelected = false
            }
        }
        else if rating == true{
            if FlasSaleVC.ratingList[indexPath.row].isSelected == false
            {
                FlasSaleVC.ratingList[indexPath.row].isSelected = true
            }
            else
            {
                FlasSaleVC.ratingList[indexPath.row].isSelected = false
            }
        }
        else if brand == true{
            if FlasSaleVC.brandList[indexPath.row].isSelected == false
            {
                FlasSaleVC.brandList[indexPath.row].isSelected = true
            }
            else
            {
                FlasSaleVC.brandList[indexPath.row].isSelected = false
            }
        }
        else{
            var index = 0
            for selectedDate in  FlasSaleVC.sortByList
            {
                if selectedDate.isSelected == true
                {
                    FlasSaleVC.sortByList[index].isSelected = false
                }
                index = index + 1
            }
            FlasSaleVC.sortByList[indexPath.row].isSelected = true
            
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var text = ""
        if category == true{
            text = FlasSaleVC.categoryList[indexPath.row].name ?? ""
        }
        else if brand == true{
            text = FlasSaleVC.brandList[indexPath.row].id ?? ""
        }
        else{
            text = FlasSaleVC.sortByList[indexPath.row].name ?? ""
        }
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:12.0)]).width + 38.0
        return CGSize(width: cellWidth, height: 38.0)
    }
}

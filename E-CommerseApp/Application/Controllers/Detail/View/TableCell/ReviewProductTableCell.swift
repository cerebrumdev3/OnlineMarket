//
//  ReviewProductTableCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 27/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit
import Cosmos

class ReviewProductTableCell: UITableViewCell {
    
    //MARK:- outlet and variables 
    @IBOutlet weak var collectionViewImages: UICollectionView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var viewUserRating: CosmosView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblTotalRate: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var btnSeeMore: UIButton!
    
    var viewDelegate : DetailVCDelegate?
    var ratingReviewsList:Ratings?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewImages.delegate = self
        collectionViewImages.dataSource = self
        collectionViewImages?.collectionViewLayout.invalidateLayout()
    }
    
    //MARK:- other functions
    func setView(){
        lblDetail.textColor = Appcolor.ktextGrayColor
        lblTotalRate.textColor = Appcolor.ktextGrayColor
        btnSeeMore.setTitleColor(Appcolor.kTheme_Color, for: .normal)
        lblDate.textColor = Appcolor.ktextGrayColor
        
        //setData
        lblUserName.text = (ratingReviewsList?.user?.firstName ?? "") + (ratingReviewsList?.user?.lastName ?? "")
        viewRating.rating = Double(ratingReviewsList?.rating ?? "") ?? 0.0
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func seeMoreAction(_ sender: Any)
    {
        viewDelegate?.moreReviews(index: (sender as AnyObject).tag)
    }
}

//MARK:- Delegate and DataSource

extension ReviewProductTableCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.ProductImagesCollectionCell, for: indexPath) as? ProductImagesCollectionCell
        {
           // cell.setView()
            cell.contentView.layer.cornerRadius = 4
            cell.contentView.clipsToBounds = true
            return cell
        }
        return UICollectionViewCell()
    }
    
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
    
    // Swift 3.0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 4) - 4), height: CGFloat(80))
    }
    
    
    
}

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
    @IBOutlet weak var kCollectionHeight: NSLayoutConstraint!
    
    var viewDelegate : DetailVCDelegate?
    var ratingReviewsList:Ratings?
    var imagesList = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewImages.delegate = self
        collectionViewImages.dataSource = self
        collectionViewImages?.collectionViewLayout.invalidateLayout()
    }
    
    //MARK:- other functions
    func setView(allData:Body12?){
        lblDetail.textColor = Appcolor.ktextGrayColor
        lblTotalRate.textColor = Appcolor.ktextGrayColor
        btnSeeMore.setTitleColor(Appcolor.kTheme_Color, for: .normal)
        lblDate.textColor = Appcolor.ktextGrayColor
        
        self.imgUser.layer.cornerRadius = self.imgUser.frame.height/2
        self.imgUser.clipsToBounds = true
        
        //setData
        viewRating.rating = Double(allData?.rating ?? 0) 
        lblUserName.text = (ratingReviewsList?.user?.firstName ?? "") + (ratingReviewsList?.user?.lastName ?? "")
        viewUserRating.rating = Double(ratingReviewsList?.rating ?? "") ?? 0.0
        lblDetail.text = ratingReviewsList?.review ?? ""
       
        if let url = ratingReviewsList?.user?.image{
              self.imgUser.setImage(with: url, placeholder: kplaceholderProfile)
       }
        else{
            self.imgUser.image = UIImage(named: kplaceholderProfile)
        }
        lblTotalRate.text = "\(allData?.rating ?? 0)(\(allData?.ratingCount ?? 0) Reviews)"
        if let imagesData = ratingReviewsList?.reviewImages{
        if imagesData.count > 0{
            kCollectionHeight.constant = 80
            imagesList = imagesData
            collectionViewImages.reloadData()
        }
        else{
             kCollectionHeight.constant = 0
        }
        }
        
        let dateFormatterGet = DateFormatter()
               //Fri Apr 3 2020 2:00 PM
               dateFormatterGet.dateFormat = "yyyy-mm-dd"
               //MonthFormateWithDay
               let dateFormatterMonth = DateFormatter()
               //2020-03-30 14:00:00
               dateFormatterMonth.dateFormat = "MMMM dd,yyyy"
               if let date = dateFormatterGet.date(from: ratingReviewsList?.createdAt ?? "")
               {
                print(dateFormatterMonth.string(from: date))
                 lblDate.text = dateFormatterMonth.string(from: date)
               }
               else
               {
                   print("There was an error decoding the string")
               }
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
        return imagesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.ProductImagesCollectionCell, for: indexPath) as? ProductImagesCollectionCell
        {
           // cell.setView()
            cell.imgView.setImage(with: imagesList[indexPath.row], placeholder: kNoImage)
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

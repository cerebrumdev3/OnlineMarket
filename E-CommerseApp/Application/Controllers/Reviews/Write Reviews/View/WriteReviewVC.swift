//
//  WriteReviewVC.swift
//  E-CommerseApp
//
//  Created by Mohit Sharma on 6/3/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit
import Cosmos
import KMPlaceholderTextView

class WriteReviewVC: CustomController
{
    
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var collcnView: UICollectionView!
    @IBOutlet var viewRatings: CosmosView!
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var tfReview: KMPlaceholderTextView!
    
    private var selectedPicker: ImagePickers?
    var ImagePath : URL?
    var imageArray = [[String:Any]]()
    
    var viewModel:AddReview_ViewModel?
    
    let cellID = "cellClass_WriteReview"
    
    enum ImagePickers
    {
        case Profile
        init()
        {
            self = .Profile
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setUI()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func moveBack(_ sender: Any)
    {
        self.moveBACK(controller: self)
    }
    
    
    @IBAction func actionAddImages(_ sender: Any)
    {
        self.lblCount.text = "\(self.viewRatings.rating)"
        if(self.imageArray.count >= 5)
        {
            self.showErrorToast(msg: "Sorry you can not add more than 5 images", img: KSignalY)
        }
        else
        {
            selectedPicker = ImagePickers.Profile
            OpenGalleryCamera(camera: true, imagePickerDelegate: self, isVideoAlso: false)
        }
    }
    
    @IBAction func actionSubmit(_ sender: UIButton)
    {
        self.lblCount.text = "\(self.viewRatings.rating)"
        if(self.viewRatings.rating == 0)
        {
            self.showErrorToast(msg: "Pleas add some ratings", img: KSignalY)
        }
        else if(self.tfReview.text.count == 0)
        {
            self.showErrorToast(msg: "Pleas add some thoughts", img: KSignalY)
        }
        else
        {
            //submit
        }
    }
    
    
    @IBAction func cellActionDelete(_ sender: UIButton)
    {
        self.lblCount.text = "\(self.viewRatings.rating)"
        self.imageArray.remove(at: sender.tag)
        self.collcnView.reloadData()
    }
    
    
    func setUI()
    {
        self.tfReview.layer.cornerRadius = 5
        self.tfReview.layer.borderColor = Appcolor.kTextColorGray.cgColor
        self.tfReview.layer.borderWidth = 1
        
        btnSubmit.backgroundColor = Appcolor.getThemeColor()
    }
    
}

//MARK:- UIImagePickerDelegate
extension WriteReviewVC: UIImagePickerDelegate
{
    func SelectedMedia(image: UIImage?, imageURL: URL?, videoURL: URL?)
    {
        switch selectedPicker
        {
        case .Profile:
            //  ivProfile.image = image
            let obj = ["path":imageURL!,"data":image ?? UIImage()] as [String : Any]
            self.imageArray.append(obj)
            self.collcnView.reloadData()
            self.lblCount.text = "\(self.viewRatings.rating)"
            
        default: break
            
        }
    }
    
    func selectedImageUrl(url: URL)
    {
        switch selectedPicker
        {
        case .Profile:
            ImagePath = url
            
        default: break
        }
    }
    
    func cancelSelectionOfImg()
    {
        
    }
}

extension WriteReviewVC : UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)as! cellClass_WriteReview
        cell.btnDelete.tag = indexPath.row
        let obj = self.imageArray[indexPath.row]
        cell.iv.image = obj["data"] as? UIImage ?? UIImage()
        
        
        
        return cell
    }
}
extension WriteReviewVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 80, height: 80)
    }
}


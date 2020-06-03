//
//  BannerTableCell.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 25/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class BannerTableCell: UITableViewCell {
//MARK:- Outlet and variables
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isFromFlashSale :Bool?
    var bannerList = [Sale]()
    var bannerFlash = [Sale1]()
    var isFromDetail = false
    var imageList = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        //pageController.hidesForSinglePage = true
        collectionView.isPagingEnabled = true
        collectionView?.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
        
        if isFromDetail != true{
            startTimer()
        }
       
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
     //MARK:- SetScrollTime
     func startTimer() {

         let timer =  Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollToNextCell), userInfo: nil, repeats: true)

       }
    
       @objc func scrollToNextCell(){
          
         if let coll  = collectionView {
                for cell in coll.visibleCells {
                    let indexPath: IndexPath? = coll.indexPath(for: cell)
                    if ((indexPath?.row)! < bannerList.count - 1){
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                        self.pageController.currentPage = indexPath1?.row ?? 0
                        coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                    }
                    else{
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                        self.pageController.currentPage = 0
                        coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                    }

                }
            }

       }


}

//MARK:- CollectionView DataSource and Delegate
extension BannerTableCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var count = 0
        if isFromFlashSale == true{
          count = bannerFlash.count
        }
       else if isFromDetail == true{
           count = imageList.count
        }
        else{
       count = bannerList.count
        }
         pageController.numberOfPages = count
       //  pageController.isHidden = !(count > 1)

        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.BannerCollectionCell, for: indexPath) as? BannerCollectionCell
         {
              //  cell.setView()
            if isFromFlashSale == true{ cell.setFlashBanner(bannerList:self.bannerFlash[indexPath.row])
                
            }
           else if isFromDetail == true
            {
                cell.setProductImages(images:imageList[indexPath.row])
            }
            else{
                cell.setBanner(bannerList:self.bannerList[indexPath.row])
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //self.pageController.currentPage = indexPath.section
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//       let pageWidth:CGFloat = scrollView.frame.width
//           let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
//           //Change the indicator
//           self.pageController.currentPage = Int(currentPage);
//
//        }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageController.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height:collectionView.frame.height)
      }
  

}


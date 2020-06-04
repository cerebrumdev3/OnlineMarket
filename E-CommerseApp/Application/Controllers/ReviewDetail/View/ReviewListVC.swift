//
//  ReviewListVC.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 28/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class ReviewListVC: UIViewController {
    
    //MARK:- outlet and variables
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnWriteReview: CustomButton!
    @IBOutlet weak var tableViewReview: UITableView!
    
    var allDetailData : Body12?
    var viewModel : ReviewlistViewModel?
    var serviceId :String?
    var page = 1
    var limit = 10
    var fillterSelected = ""
    
    //MARK:- life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    //MARK:- other functions
    func setView()
    {
        viewModel = ReviewlistViewModel.init(Delegate: self, view: self)
        //TableView
        self.tableViewReview.delegate = self
        self.tableViewReview.dataSource = self
        tableViewReview.separatorStyle = .none
        // extendedLayoutIncludesOpaqueBars = true
        
        //collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.collectionViewLayout.invalidateLayout()
        
       // setColor
                btnWriteReview.setTitleColor(Appcolor.kTextColorWhite, for: .normal)
                btnWriteReview.backgroundColor = Appcolor.kTheme_Color
        //hit api
        getReviewsListApi()
    }
    
    //MARK:- Other functions
    func getReviewsListApi(){
        viewModel?.getProductAllReviewsApi(serviceId: serviceId ?? "", page: page , filterRating: fillterSelected, limit: limit , completion: { (data) in
            if let responce = data.body{
                
            }
        })
    }
    //MARK:- Actions
    
    @IBAction func writeReviewAction(_ sender: Any) {
    }
}

//MARK:- TableView Delegate and DataSource
extension ReviewListVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.ReviewProductTableCell, for: indexPath) as? ReviewProductTableCell
        {
            cell.setView(allData: allDetailData)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK:- CollectionView Delegate and DataSource
extension ReviewListVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if ( indexPath.row == 0)
        {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.FilterAllReviewCell, for: indexPath) as? FilterAllReviewCell
            {
                // cell.setView()
                return cell
            }
        }
        else{
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.FilterRateCollectionCell, for: indexPath) as? FilterRateCollectionCell
                {
                    // cell.setView()
                    return cell
                }
            }
            
            return UICollectionViewCell()
        }
        
        //didSelect
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
            
        }
        
      //   Swift 3.0
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
            }
        
        
        
}

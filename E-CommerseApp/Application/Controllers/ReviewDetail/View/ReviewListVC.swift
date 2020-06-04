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
    
    //var allDetailData : Body12?
    var viewModel : ReviewlistViewModel?
    var serviceId :String?
    var page = 1
    var limit = 10
    var fillterSelected = ""
    var reviewList = [Datum]()
    var isFetching:Bool = false
    var isScroll = false
    var filterList = [RatingFilter]()
    
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
        
        let array = ["All Reviews","1","2","3","4","5"]
        var selectedIndex = 0
        var selctedRate = false
        for data in array{
            if selectedIndex == 0{
                selctedRate = true
            }
            else{
                selctedRate = false
            }
            let dict = RatingFilter.init(rate: data, isSelected: selctedRate)
            self.filterList.append(dict)
            selectedIndex = selectedIndex + 1
        }
        //hit api
        getReviewsListApi()
    }
    
    //MARK:- Other functions
    func getReviewsListApi(){
        viewModel?.getProductAllReviewsApi(serviceId: serviceId ?? "", page: page , filterRating: fillterSelected, limit: limit , completion: { (data) in
            if let responce = data.body?.data{
                if responce.count > 0{
                    self.isFetching = true
                    self.reviewList = responce
                    self.lblNoRecord.isHidden = true
                    self.tableViewReview.isHidden = false
                    self.tableViewReview.reloadData()
                }
                else{
                    self.lblNoRecord.isHidden = false
                    self.tableViewReview.isHidden = true
                }
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
        return reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.ReviewProductTableCell, for: indexPath) as? ReviewProductTableCell
        {
            cell.setReviewListData(reviewList: reviewList[indexPath.row])
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
        return self.filterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if ( indexPath.row == 0)
        {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.FilterAllReviewCell, for: indexPath) as? FilterAllReviewCell
            {
                // cell.setView()
                cell.lblAll.text = filterList[0].rate
                if filterList[0].isSelected == true{
                    cell.viewBack.backgroundColor = Appcolor.kbtnExtralightOrangeColor
                    cell.lblAll.textColor = Appcolor.kTheme_Color
                }
                else{
                    cell.viewBack.backgroundColor = Appcolor.kTextColorWhite
                    cell.lblAll.textColor = UIColor.black
                }
                return cell
            }
        }
        else{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.FilterRateCollectionCell, for: indexPath) as? FilterRateCollectionCell
            {
                // cell.setView()
                cell.lblRate.text = filterList[indexPath.row].rate
                
                if filterList[indexPath.row].isSelected == true{
                    cell.viewBack.backgroundColor = Appcolor.kbtnExtralightOrangeColor
                   // cell.lblRate.textColor = Appcolor.kTheme_Color
                }
                else{
                    cell.viewBack.backgroundColor = Appcolor.kTextColorWhite
                  //  cell.lblRate.textColor = UIColor.black
                }
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print(self.filterList[indexPath.row])
        var index = 0
        for selectedDate in  self.filterList
        {
            if selectedDate.isSelected == true
            {
                self.filterList[index].isSelected = false
            }
            index = index + 1
        }
        self.filterList[indexPath.row].isSelected = true
        collectionView.reloadData()
        
        if(filterList[indexPath.row].rate ?? "" == "All Reviews"){
          fillterSelected = ""
        }
        else{
           fillterSelected = filterList[indexPath.row].rate ?? ""
        }
        
        self.getReviewsListApi()
    }
    
    //   Swift 3.0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    
    
}

extension ReviewListVC : UIScrollViewDelegate{
    
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == tableViewReview{
            if ((tableViewReview.contentOffset.y + tableViewReview.frame.size.height) >= tableViewReview.contentSize.height)
            {
                if isFetching == true
                {
                    isScroll = true
                    isFetching = false
                    self.page = self.page+1
                    getReviewsListApi()
                }
                else{
                    isScroll = false
                }
            }
        }
    }
}

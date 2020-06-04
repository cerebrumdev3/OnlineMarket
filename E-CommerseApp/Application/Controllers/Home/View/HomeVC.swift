//
//  HomeVC.swift
//  E-CommerseApp
//
//  Created by Mohit Sharma on 5/19/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

protocol HomeVcDelegate:class {
    func moreCategories(index:Int?)
    func flashSale()
    func productDetail(id:String?)
}

class HomeVC: CustomController
{
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnDrawer: UIBarButtonItem!
    @IBOutlet weak var btnNotification: UIBarButtonItem!
    @IBOutlet weak var btnFavorite: UIBarButtonItem!
    
    var viewModel : HomeViewModel?
    var allData : Body?
    var isFirstTimeCallDelegate = false
    private let searchController = UISearchController(searchResultsController: nil)
    //lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //   searchController.isActive = false
    }
    
    @IBAction func notificationAction(_ sender: Any)
    {
       let controller = Navigation.GetInstance(of: .WriteReviewVC) as! WriteReviewVC
       push_To_Controller(from_controller: self, to_Controller: controller)
    }
    @IBAction func favoriteAction(_ sender: Any) {
        let controller = Navigation.GetInstance(of: .FavoriteProductVC) as! FavoriteProductVC
        push_To_Controller(from_controller: self, to_Controller: controller)
    }
    
    //MARK:- SETTING UI APPROACH
    func setView()
    {
        viewModel = HomeViewModel.init(Delegate: self, view: self)
        //NAvigationBAR
        btnDrawer.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //TableView
        self.tblView.delegate = self
        self.tblView.dataSource = self
        tblView.separatorStyle = .none
        
        //SearchBar
        
        searchController.searchBar.setImage(UIImage(named: "searchIcon"), for: .search, state: .normal)
        searchController.searchBar.delegate = self
        searchController.definesPresentationContext = true
        if #available(iOS 13.0, *) {
            searchController.automaticallyShowsCancelButton = false
        } else {
            searchController.searchBar.showsCancelButton = false
        }
        searchController.dimsBackgroundDuringPresentation = false
        
        // searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        //searchController.searchBar.searchTextField.placeholder = "Search Product"
        
        var searchTextField: UITextField?
        if let searchField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField = searchField
            searchTextField?.textColor = .black
            searchTextField?.backgroundColor = .white
            searchTextField?.layer.borderWidth = 0.5
            searchTextField?.layer.borderColor = UIColor.lightGray.cgColor
            searchTextField?.layer.cornerRadius = 8
            searchTextField?.layer.masksToBounds = true
            searchTextField?.placeholder = "Search Product"
        }
        self.navigationItem.titleView = searchController.searchBar
        //  tblView.tableHeaderView = searchController.searchBar
        // Don't hide the navigation bar because the search bar is in it.
        searchController.hidesNavigationBarDuringPresentation = false
        
        //hit api
        getHomeListApi()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.isActive = false
    }
    
    //MARK:- other functions
    
    func getHomeListApi(){
        viewModel?.getHomeServicesApi(completion: { (response) in
            if let data = response.body{
                print(data)
                self.allData = data
                self.tblView.reloadData()
            }
        })
    }
}

//MARK:- TableView Delegate and DataSource
extension HomeVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row
        {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.BannerTableCell, for: indexPath) as? BannerTableCell
            {
                if let bannerData = self.allData?.sales{
                    cell.bannerList = bannerData
                    cell.collectionView.reloadData()
                }
                return cell
            }
            break
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.CategoryTableCell, for: indexPath) as? CategoryTableCell
            {
                cell.setView()
                cell.viewDelegate = self
                if let category = self.allData?.categories{
                    cell.categoryList = category
                    cell.collectionView.reloadData()
                }
                //                            if self.trendingServicesList.count > 0
                //                            {
                //                                if let cartData = self.trendingServicesList[indexPath.row].cart?.id
                //                                {
                //                                    if cartData != ""
                //                                    {
                //                                        isCartAdded = true
                //
                //                                    }
                //                                }
                //                                lblNoTrendingServices.isHidden = true
                //                                cell.collectionViewTrendingServiceList.isHidden = false
                //                                cell.delegateTrendingService = self
                //                                cell.trendingServicesList = self.trendingServicesList
                //                                cell.collectionViewTrendingServiceList.reloadData()
                //                            }else
                //                            {
                //                                cell.collectionViewTrendingServiceList.isHidden = true
                //                                lblNoTrendingServices.isHidden = false
                //                            }
                //
                return cell
            }
            break
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.FlashSaleTableCell, for: indexPath) as? FlashSaleTableCell
            {
                
                cell.viewDelegate = self
                cell.setView()
                if let SaleData = self.allData?.sales{
                    cell.saleList = SaleData
                    cell.currency = self.allData?.currency ?? ""
                    cell.collectionView.reloadData()
                }
                return cell
            }
            break
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.MiddleBannerTableCell, for: indexPath) as? MiddleBannerTableCell
            {
                if let recommended = self.allData?.recommended{
                    cell.recommendedList = recommended
                    cell.collectionView.reloadData()
                }
                
                return cell
            }
            break
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.ProductListTableCell, for: indexPath) as? ProductListTableCell
            {
                if let recommended = self.allData?.recommended{
                    cell.recommendedList = recommended
                     cell.curency = self.allData?.currency ?? ""
                    if isFirstTimeCallDelegate == false{
                        isFirstTimeCallDelegate = true
                        cell.setView()
                     }
                     cell.collectionView.reloadData()
                }
               
                return cell
            }
            break
        default:
            break
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK:- SearchDelegate
extension HomeVC:UISearchBarDelegate
{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        //   self.present(UINavigationController(rootViewController: SearchVC()), animated: false, completion: nil)
        //searchController.hidesNavigationBarDuringPresentation = true
        view.endEditing(true)
        searchController.isActive = false
        let controller = Navigation.GetInstance(of: .SearchVC) as! SearchVC
        push_To_Controller(from_controller: self, to_Controller: controller)
        
    }
}

//MARK:- View Delegate
extension HomeVC:HomeVcDelegate{
    func productDetail(id: String?) {
        let controller = Navigation.GetInstance(of: .DetailVC) as! DetailVC
        controller.serviceId = id
        push_To_Controller(from_controller: self, to_Controller: controller)
    }
    
    func flashSale() {
        let controller = Navigation.GetInstance(of: .FlasSaleVC) as! FlasSaleVC
       // controller.ctegoryId = 
        push_To_Controller(from_controller: self, to_Controller: controller)
    }
    
    func moreCategories(index: Int?) {
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.isActive = false
        let controller = Navigation.GetInstance(of: .CategoryVC) as! CategoryVC
        push_To_Controller(from_controller: self, to_Controller: controller)
    }
}

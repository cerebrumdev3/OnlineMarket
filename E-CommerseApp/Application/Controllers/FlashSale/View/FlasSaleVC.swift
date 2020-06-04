//
//  FlasSaleVC.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 27/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class FlasSaleVC: BaseUIViewController {
    
    //MARK:- outlet and Variables
    @IBOutlet weak var imgBackFilter: UIImageView!
    @IBOutlet weak var btnApplyFilter: UIButton!
    @IBOutlet weak var btnClearAll: UIButton!
    @IBOutlet weak var viewFilterPrice: UIView!
    @IBOutlet weak var viewFilter: CustomUIView!
    @IBOutlet weak var tbleViewFilter: UITableView!
    @IBOutlet weak var tbleView: UITableView!
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var btnBAck: UIBarButtonItem!
    @IBOutlet weak var collectionViewFillter: UICollectionView!
    @IBOutlet weak var lblMinimunPrice: UILabel!
    @IBOutlet weak var lblMaxmimumPrice: UILabel!
    @IBOutlet weak var slider: RangeSeekSlider!
    
    var isFirstTimeCallDelegate = false
    var categoryId : String?
    var filter:Filters?
    var viewModel : FlashViewModel?
    var isFetching:Bool = false
    var isScroll = false
    var page = 1
    var limit = 10
    var allData : Body1?
    var category,brand,rating,sortBy:Bool?
    var selectedFilterCat = [String]()
    var selectedFilterBrand = [String]()
    var selectedFilterPrice = [String:Any]()
    var selectedSortBy = [String:Any]()
    var filterArray = [String]()
    static var categoryList = [FiltersCategory]()
    static var brand = [Brand]()
   // static var brandList = [BrandCategory]()
    static var brandList = [SelectedBrand]()
    static var ratingList = [RatingCategory]()
    static var sortByList = [SortByCategory]()
    let sortArray = ["Price low to high","Price high to low","Offer high to low","Offer low to high","Rating high to low","Rating low to high","New arrivals","Sorting by name"]
    var orderBy,orderType :String?
    var isFirstTime = false
    var searchText:String?
    
    //MARK:- life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // categoryId = "05619abf-589d-4f4c-98c6-3d3a07d77ba4"
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK:- other functions
    func setView(){
        
        viewModel = FlashViewModel.init(Delegate: self, view: self)
        //TableView
        self.tbleView.delegate = self
        self.tbleView.dataSource = self
        self.tbleView.separatorStyle = .none
        
        self.tbleViewFilter.delegate = self
        self.tbleViewFilter.dataSource = self
        self.tbleViewFilter.separatorStyle = .none
        self.tbleViewFilter.tableFooterView = UIView()
        
        extendedLayoutIncludesOpaqueBars = true
        
        //collectionView
        collectionViewFillter.delegate = self
        collectionViewFillter.dataSource = self
        collectionViewFillter?.collectionViewLayout.invalidateLayout()
        
        slider.delegate = self
        
        //setColor
        btnClearAll.setTitleColor(Appcolor.kTheme_Color, for: .normal)
        btnApplyFilter.setTitleColor(Appcolor.kTheme_Color, for: .normal)
        slider.tintColor = Appcolor.kTheme_Color
        
        lblMinimunPrice.text = String(format: "%.0f", slider.minValue)
        lblMaxmimumPrice.text = String(format: "%.0f", slider.maxValue)
        
        //Set Search bar in navigation
        self.setSearchBarInNavigationController(placeholderText: "Search Flash Sale", navigationTitle: "Super Flash Sale", navigationController: self.navigationController, navigationSearchBarDelegates: self)
        
       
        let ratingArray = ["All","5 Star","4 Star","3 Star"]
        FlasSaleVC.ratingList.removeAll()
        for rating in ratingArray{
            let data = RatingCategory.init(name: rating, isSelected: false)
            FlasSaleVC.ratingList.append(data)
        }
        
        
        
        //hitApi
        getProductList(page: page)
    }
    
    //MARK:- hitApi
    func getProductList(page:Int?){
        viewModel?.getServices(category: categoryId ?? "", page: page ?? 0, brandArray: selectedFilterBrand, catArray: selectedFilterCat, priceRange: selectedFilterPrice, orderByInfo: selectedSortBy, search: searchText ?? "", completion: { (response) in
            if let data = response.body{
                self.filter = data.filters
                self.isFetching = true
                 self.allData = data
                self.tbleView.isHidden = false
                self.lblNoRecord.isHidden = true
                
                if self.isFirstTime == false{
                    self.isFirstTime = true
                    self.filterArray = ["Category","Brand","Price","Sort By"]
                    self.collectionViewFillter.reloadData()
                    //categoryFilterList
                FlasSaleVC.categoryList.removeAll()
                if let categoryList = self.filter?.categories{
                    FlasSaleVC.categoryList = categoryList
                }
                    //BrandFilterList
                FlasSaleVC.brandList.removeAll()
                FlasSaleVC.brand.removeAll()
                if let brandList = self.filter?.brands{
                    FlasSaleVC.brand = brandList
                    
                    for data in brandList{
                        let brandData = SelectedBrand.init(id: data.id, companyName: data.companyName, isSelected: false)
                        FlasSaleVC.brandList.append(brandData)
                    }
                }
               
                //SortBYFilterList
                FlasSaleVC.sortByList.removeAll()
                for sort in self.sortArray{
                    if sort == "Price low to high"{
                        self.orderType = "DESC"
                        self.orderBy = "price"
                    }
                    else if sort == "Price high to low"{
                        self.orderType = "ASC"
                        self.orderBy = "price"
                    }
                    if sort == "Offer low to high"{
                        self.orderType = "DESC"
                        self.orderBy = "offer"
                    }
                    else if sort == "Offer high to low"{
                        self.orderType = "ASC"
                        self.orderBy = "offer"
                    }
                    if sort == "Rating low to high"{
                        self.orderType = "DESC"
                        self.orderBy = "rating"
                    }
                    else if sort == "Rating high to low"{
                        self.orderType = "ASC"
                        self.orderBy = "rating"
                    }
                    if sort == "Sorting by name"{
                        self.orderType = "ASC"
                        self.orderBy = "name"
                    }
                    if sort == "New arrivals"{
                        self.orderType = "ASC"
                        self.orderBy = "createdAt"
                    }
                    let data = SortByCategory.init(name: sort, isSelected: false, orderby: self.orderBy, orderType: self.orderType)
                    FlasSaleVC.sortByList.append(data)
                    }
                }
                self.tbleView.reloadData()
            }
            else{
                self.isFetching = false
            }
        })
    }
    //MARK:- Actions
    @IBAction func applyFilterAction(_ sender: Any) {
        
        isScroll = false
        page = 1
        self.selectedFilterCat.removeAll()
        for selectedCategory in FlasSaleVC.categoryList
        {
            if selectedCategory.isSelected == true
            {
                self.selectedFilterCat.append(selectedCategory.id ?? "")
            }
        }
        self.selectedFilterBrand.removeAll()
        for selectedCategory in FlasSaleVC.brandList
        {
            if selectedCategory.isSelected == true
            {
                self.selectedFilterBrand.append(selectedCategory.id ?? "")
            }
        }
        self.selectedSortBy.removeAll()
        var allOrderBy = ""
        for selectedCategory in FlasSaleVC.sortByList
        {
            if selectedCategory.isSelected == true
            {
                
                self.selectedSortBy = ["orderby" : selectedCategory.orderby ?? "","orderType" : selectedCategory.orderType ?? ""]
                //selectedCategory.orderType ??
            }
        }
        
        let priceDict = ["start":lblMinimunPrice.text ?? "","end":lblMaxmimumPrice.text ?? ""]
        self.selectedFilterPrice = priceDict as [String : Any]
        
        getProductList(page: page)
        viewFilter.isHidden = true
        imgBackFilter.isHidden = true
        
    }
    @IBAction func clearFilterAction(_ sender: Any) {
        isScroll = false
        self.isFirstTime = false
        page = 1
        viewFilter.isHidden = true
        imgBackFilter.isHidden = true
        self.selectedFilterCat.removeAll()
        self.selectedFilterBrand.removeAll()
        self.selectedSortBy.removeAll()
        self.selectedFilterPrice.removeAll()
       // collectionViewFillter.reloadData()
        
        getProductList(page: page)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}

//MARK:- TableView Delegate and DataSource
extension FlasSaleVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbleView{
            return 2
        } else{
            var count = 0
            if category == true
            {
                count = 1
            }
            else if (brand == true)
            {
                count = FlasSaleVC.brand.count
            }
            else if(rating == true){
                count = 1
            }
            else{
                count = 1
            }
            
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbleView{
            switch indexPath.row
            {
            case 0:
                if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.BannerTableCell, for: indexPath) as? BannerTableCell
                {
                    cell.pageController.isHidden = true
                    cell.collectionView.layer.cornerRadius = 8
                    cell.collectionView.clipsToBounds = true
                    if let bannerData = self.allData?.sales
                    {
                        cell.bannerFlash = bannerData
                        cell.isFromFlashSale = true
                        cell.collectionView.reloadData()
                    }
                    return cell
                }
                break
                
            case 1:
                if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.ProductListTableCell, for: indexPath) as? ProductListTableCell
                {
                    
                    if let serviceData = self.allData?.services
                    {
                        if serviceData.count > 0{
                            
                            cell.collectionView.setEmptyMessage("")
                            lblNoRecord.isHidden = true
                            cell.isFromFlashSale = true
                            cell.serviceList = serviceData
                            cell.curency = self.allData?.currency ?? ""
                            
                            //                        if isFirstTimeCallDelegate == false{
                            //                            isFirstTimeCallDelegate = true
                            cell.setView()
                        }
                        else{
                            if self.isScroll == true{}
                            else
                            {
                                //lblNoRecord.isHidden = false
                               // cell.collectionView.isHidden = true
                                cell.serviceList.removeAll()
                                cell.collectionView.setEmptyMessage("No Record Found !")
                            }
                        }
                        //}
                    }
                    
                    cell.collectionView.reloadData()
                    return cell
                }
                break
            default:
                break
                
            }
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            if category == true
            {
                // cell.categoryList = categoryList
                cell.category = true
                cell.brand = false
                cell.rating = false
                cell.lblTitle.text = "Categories"
            }
            else if brand == true{
                
                //cell.brandList = brandList[indexPath.row].categories
                cell.brand = true
                cell.category = false
                cell.rating = false
                cell.lblTitle.text = "Brands" //FlasSaleVC.brand[indexPath.row].companyName ?? ""
            }
            else if(rating == true)
            {
                cell.brand = false
                cell.category = false
                cell.rating = true
                cell.lblTitle.text = "Rating"
            }
            else{
                cell.brand = false
                cell.category = false
                cell.rating = false
                cell.sortBy = true
                cell.lblTitle.text = "Sort By"
            }
            cell.configure()
            let height = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
            cell.kCollectionHeight.constant = height
            cell.collectionView.reloadData()
            cell.collectionView.setNeedsLayout()
            return cell
            //            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.FilterTableCell, for: indexPath) as? FilterTableCell
            //                       {
            //                        let height = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
            //                        cell.kCollectionHeight.constant = height
            //                        cell.collectionView.reloadData()
            //                         cell.collectionView.setNeedsLayout()
            //                           return cell
            //                       }
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


//MARK:- UISearchController Bar Delegates
extension FlasSaleVC : NavigationSearchBarDelegate{
    
    func textDidChange(searchBar: UISearchBar, searchText: String) {
        viewModel?.isSearching = true
        //        arr_Classlist.removeAll()
        //                self.viewModel?.classList(Search: searchText, Skip: KIntegerConstants.kInt0,PageSize: KIntegerConstants.kInt10,SortColumnDir: "",  SortColumn: "", ParticularId : HODdepartmentId)
        self.searchText = searchText
        self.getProductList(page: page)
        
    }
    
    func cancelButtonPress(uiSearchBar: UISearchBar) {
        viewModel?.isSearching = false
        DispatchQueue.main.async {
            //            self.arr_Classlist.removeAll()
            //            self.viewModel?.classList(Search: "", Skip: KIntegerConstants.kInt0,PageSize: KIntegerConstants.kInt10,SortColumnDir: "",  SortColumn: "", ParticularId : self.HODdepartmentId)
            //                        self.viewModel?.classList(searchText: "", pageSize: KIntegerConstants.kInt10, filterBy: 0, skip: KIntegerConstants.kInt0)
            
            self.searchText = ""
            self.getProductList(page: self.page)
        }
    }
}

//MARK:- CollectionView Delegate and DataSource
extension FlasSaleVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIdentifiers.FilterCollectionCell, for: indexPath) as? FilterCollectionCell
        {
            // cell.setView()
            cell.viewBack.borderColor = UIColor.gray
            cell.lblFilterType.text = filterArray[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    //didSelect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        viewFilter.isHidden = false
        imgBackFilter.isHidden = false
        collectionView.deselectItem(at: indexPath, animated: false)
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionCell {
            cell.viewBack.borderColor = Appcolor.kTheme_Color
            if cell.lblFilterType.text == "Category"{
                tbleViewFilter.isHidden = false
                viewFilterPrice.isHidden = true
                category = true
                brand = false
            }
            else if (cell.lblFilterType.text == "Brand"){
                tbleViewFilter.isHidden = false
                viewFilterPrice.isHidden = true
                category = false
                brand = true
                
            }
            else if (cell.lblFilterType.text == "Price"){
                viewFilterPrice.isHidden = false
                tbleViewFilter.isHidden = true
            }
            else if (cell.lblFilterType.text == "Rating"){
                tbleViewFilter.isHidden = false
                viewFilterPrice.isHidden = true
                category = false
                brand = false
                rating = true
            }
                
            else{
                tbleViewFilter.isHidden = false
                viewFilterPrice.isHidden = true
                category = false
                brand = false
                sortBy = true
            }
            tbleViewFilter.reloadData()
        }
        
    }
    
    // Swift 3.0
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: CGFloat((collectionView.frame.size.width / 4) - 4), height: CGFloat(122))
    //    }
    
    
    
}
extension FlasSaleVC : UIScrollViewDelegate{
    
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == tbleView{
            if ((tbleView.contentOffset.y + tbleView.frame.size.height) >= tbleView.contentSize.height)
            {
                if isFetching == true
                {
                    isScroll = true
                    isFetching = false
                    self.page = self.page+1
                    
                    getProductList(page: self.page)
                }
                else{
                    isScroll = false
                }
            }
        }
    }
}

// MARK: - RangeSeekSliderDelegate

extension FlasSaleVC: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        print("Custom slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        
        lblMinimunPrice.text =  String(format: "%.0f", minValue)
        lblMaxmimumPrice.text = String(format: "%.0f", maxValue)
        
    }
    
    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}

//
//  DetailVC.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 27/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

protocol DetailVCDelegate:class {
    func moreReviews(index :Int?)
    func setDataAccToColor(index:Int?)
}

class DetailVC: UIViewController {
    
    //MARK:- outlet and variables
    
    @IBOutlet weak var lblEstimateDelivery: UILabel!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var btnAddToCart: CustomButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnAddress: UIButton!
    @IBOutlet weak var kbtnAddCartHeight: NSLayoutConstraint!
    @IBOutlet weak var kEstimateView: NSLayoutConstraint!
    
    var viewModel : DetailViewModel?
    var serviceId :String?
    var allDetailData : Body12?
    var productSpecification = [ProductSpecification12]()
    var productImages: [String]?
    var recommendedList = [Recommended1]()
    var addrssID = ""
    static  var colorList = [ProductSpecification11]()
    var sizeList = [StockQunatity11]()
    
    
    //MARK:- life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    //MARK:- other functions
    func setView()
    {
        // serviceId = "05619abf-589d-4f4c-98c6-3d3a07d77ba4"
        viewModel = DetailViewModel.init(Delegate: self, view: self)
        //TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .none
        extendedLayoutIncludesOpaqueBars = true
        
        //setColor
        btnAddToCart.setTitleColor(Appcolor.kTextColorWhite, for: .normal)
        btnAddToCart.backgroundColor = Appcolor.kTheme_Color
        if AppDefaults.shared.userHomeAddress != ""{
            lblAddress.text = "Deliver to - " + AppDefaults.shared.userHomeAddress
            addrssID = AppDefaults.shared.userAddressID
        }
        else{
            lblAddress.text = "Select Address"
        }
        
        //hit api
        getDetail()
    }
    //MARK:- hitAPi
    func getDetail(){
        viewModel?.getProductDetailApi(serviceId: serviceId ?? "",addressId:addrssID, completion: { (data) in
            if let response = data.body
            {
                self.allDetailData = response
                self.lblEstimateDelivery.text =  (self.allDetailData?.estimatDelivery ?? "")
                if self.allDetailData?.estimatDelivery ?? "" == ""{
                    self.btnAddToCart.isHidden = true
                    self.kbtnAddCartHeight.constant = 0
                    self.kEstimateView.constant = 0
                }
                else{
                    self.btnAddToCart.isHidden = false
                     self.kbtnAddCartHeight.constant = 58
                    self.kEstimateView.constant = 36
                }
                if let detail = response.productSpecifications{
                    self.productSpecification = detail
                    // for imagesList in self.productSpecification{
                    if self.productSpecification.count > 0{
                        self.productImages = self.productSpecification[0].productImages
                        
                        //setColorList
                        var colorIndex = 0
                        var selectedColor = false
                        DetailVC.colorList.removeAll()
                        for data in self.productSpecification{
                            if colorIndex == 0{
                                selectedColor = true
                            }
                            else{
                                selectedColor = false
                            }
                            let colorData = ProductSpecification11.init(id: data.id, productColor: data.productColor, isColorSelected: selectedColor)
                            
                            DetailVC.colorList.append(colorData)
                            colorIndex = colorIndex + 1
                        }
                       
                        
                        //sizeList
                        var sizeIndex = 0
                        var selectedSize = false
                        self.sizeList.removeAll()
                        //                        for data in self.productSpecification
                        //                        {
                        if let sizeList = self.productSpecification[0].stockQunatity
                        {
                            for avaliableProduct in sizeList{
                                if sizeIndex == 0{
                                    selectedSize = true
                                }
                                else{
                                    selectedSize = false
                                }
                                if avaliableProduct.stock != "0"
                                {
                                    let sizeArray = StockQunatity11.init(id:avaliableProduct.id
                                        , size: avaliableProduct.size, stock: avaliableProduct.stock, isSizeSelected: selectedSize)
                                    
                                    self.sizeList.append(sizeArray)
                                }
                                sizeIndex = sizeIndex + 1
                            }
                        }
                        // }
                        
                    }
                    //  }
                }
                self.tableView.reloadData()
            }
        })
    }
    //MARK:- Actions
    @IBAction func addToCartAction(_ sender: Any) {
    }
    
    @IBAction func selectAddressAction(_ sender: Any)
    {
        let controller = Navigation.GetInstance(of: .ChooseAddressVC) as! ChooseAddressVC
        controller.modalPresentationStyle = .overCurrentContext
        controller.delegateCheckout = self
        present(controller, animated: true, completion: nil)
    }
    @IBAction func backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
}

//MARK:- TableView Delegate and DataSource
extension DetailVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row
        {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.BannerTableCell, for: indexPath) as? BannerTableCell
            {
                cell.isFromDetail = true
                cell.isFromFlashSale = false
                if let productImages = productImages{
                    cell.imageList = productImages
                    cell.collectionView.reloadData()
                }
                return cell
            }
            break
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.SelectSizeTableCell, for: indexPath) as? SelectSizeTableCell
            {
                
                cell.setView(allData:allDetailData)
                cell.sizeArray = self.sizeList
                cell.collectionViewSize.reloadData()
                
                return cell
            }
            break
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.SelectColorTableCell, for: indexPath) as? SelectColorTableCell
            {
                //cell.colorList = self.colorList
                cell.viewDelegate = self
                cell.collectionViewColor.reloadData()
                return cell
            }
            break
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.SpecificationTableCell, for: indexPath) as? SpecificationTableCell
            {
                cell.setView(allData:allDetailData)
                return cell
            }
            break
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.ReviewProductTableCell, for: indexPath) as? ReviewProductTableCell
            {
                cell.ratingReviewsList = allDetailData?.ratings
                cell.viewDelegate = self
                cell.setView(allData:allDetailData)
                return cell
            }
            break
        case 5:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.FlashSaleTableCell, for: indexPath) as? FlashSaleTableCell
            {
                cell.isFromDetail = true
                if let data = self.allDetailData?.recommended{
                    cell.recommendedList = data
                    cell.currency =  self.allDetailData?.currency ?? ""
                    cell.collectionView.reloadData()
                }
                cell.setView()
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

//MARK:- ViewDelegate

extension DetailVC : DetailVCDelegate
{
    func setDataAccToColor(index: Int?) {
        
        //sizeList
        var sizeIndex = 0
        var selectedSize = false
        self.sizeList.removeAll()
        
        if self.productSpecification.count > 0{
            self.productImages = self.productSpecification[index ?? 0].productImages
            
            if let sizeList = self.productSpecification[index ?? 0].stockQunatity
            {
                for avaliableProduct in sizeList{
                    if sizeIndex == 0{
                        selectedSize = true
                    }
                    else{
                        selectedSize = false
                    }
                    if avaliableProduct.stock != "0"
                    {
                        let sizeArray = StockQunatity11.init(id:avaliableProduct.id
                            , size: avaliableProduct.size, stock: avaliableProduct.stock, isSizeSelected: selectedSize)
                        
                        self.sizeList.append(sizeArray)
                    }
                    sizeIndex = sizeIndex + 1
                }
            }
            
        }
        tableView.reloadData()
    }
    
    func moreReviews(index: Int?) {
        let controller = Navigation.GetInstance(of: .ReviewListVC) as! ReviewListVC
        push_To_Controller(from_controller: self, to_Controller: controller)
    }
    
}

//MARK:- AddressDelegate
extension DetailVC : UpdateAddressOnCheckout_Delegate
{
    func addressFound(addrss:String,type:String,adrssID:String)
    {
        self.lblAddress.text = "Deliver to - " + addrss
        // self.lblAddressType.text = type
        self.addrssID = adrssID
        
         getDetail()
        
    }
    
    func goToAddNewAddress()
    {
        let controller = Navigation.GetInstance(of: .AddNewAddressVC) as! AddNewAddressVC
        self.push_To_Controller(from_controller: self, to_Controller: controller)
    }
    
}

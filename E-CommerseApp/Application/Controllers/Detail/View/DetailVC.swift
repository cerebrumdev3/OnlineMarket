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
}

class DetailVC: UIViewController {
    
    //MARK:- outlet and variables
    
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var btnAddToCart: CustomButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnAddress: UIButton!
    
    var viewModel : DetailViewModel?
    var serviceId :String?
    var allDetailData : Body12?
    var productSpecification = [ProductSpecification12]()
    var productImages: [String]?
    var recommendedList = [Recommended1]()
    var addrssID = ""

    
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
        
        //hit api
        getDetail()
    }
    //MARK:- hitAPi
    func getDetail(){
        viewModel?.getProductDetailApi(serviceId: serviceId ?? "", completion: { (data) in
            if let response = data.body
            {
                self.allDetailData = response
                if let detail = response.productSpecifications{
                self.productSpecification = detail
                    for imagesList in self.productSpecification{
                        self.productImages = imagesList.productImages
                    }
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
                cell.collectionViewSize.reloadData()
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.SelectColorTableCell, for: indexPath) as? SelectColorTableCell
            {
                cell.colorList = self.productSpecification
                cell.collectionViewColor.reloadData()
                return cell
            }
            break
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.SpecificationTableCell, for: indexPath) as? SpecificationTableCell
            {
                cell.setView()
                return cell
            }
            break
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.ReviewProductTableCell, for: indexPath) as? ReviewProductTableCell
            {
                cell.viewDelegate = self
                cell.setView()
                return cell
            }
            break
        case 5:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.FlashSaleTableCell, for: indexPath) as? FlashSaleTableCell
            {
                cell.isFromDetail = true
                if let data = self.allDetailData?.recommended{
                cell.recommendedList = data
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
        self.lblAddress.text = addrss
       // self.lblAddressType.text = type
        self.addrssID = adrssID
        
    }
    
    func goToAddNewAddress()
    {
        let controller = Navigation.GetInstance(of: .AddNewAddressVC) as! AddNewAddressVC
        self.push_To_Controller(from_controller: self, to_Controller: controller)
    }
    
}

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
    func addFavorite()
    func setDataAccToSize(index:Int?)
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
    //  @IBOutlet var viewCart: UIView!
    @IBOutlet var alphaImage: UIImageView!
    @IBOutlet var bottomConstantSlotView: NSLayoutConstraint!
    
    //MARK: SLOTS VIEW OUTLETS
    @IBOutlet var lblFinalPrice: UILabel!
    @IBOutlet var blurViewSlots: UIVisualEffectView!
    @IBOutlet var lblSericeCount: UILabel!
    @IBOutlet var stepper: UIStepper!
    @IBOutlet var btnProceed: UIButton!
    
    var viewModel : DetailViewModel?
    var serviceId :String?
    var allDetailData : Body12?
    var productSpecification = [ProductSpecification12]()
    var productImages: [String]?
    var recommendedList = [Recommended1]()
    var addrssID = ""
    static  var colorList = [ProductSpecification11]()
    static var sizeList = [StockQunatity11]()
    var companyId : String?
    var addedinFavorite = false
    var orderPrice,orderTotalPrice,quantity,color,size:String?
    var previousValueStepper = 0
    var price = 0
    var selectedIndx = -2
    
    //MARK:- life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //hit api
        getDetail()
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
        // self.blurViewSlots.roundCorners_TOPLEFT_TOPRIGHT(val: 20)
        alphaImage.isHidden = true
        //setColor
        btnAddToCart.setTitleColor(Appcolor.kTextColorWhite, for: .normal)
        btnAddToCart.backgroundColor = Appcolor.kTheme_Color
        btnProceed.setTitleColor(Appcolor.kTextColorWhite, for: .normal)
        btnProceed.backgroundColor = Appcolor.kTheme_Color
        if AppDefaults.shared.userHomeAddress != ""{
            lblAddress.text = "Deliver to - " + AppDefaults.shared.userHomeAddress
            addrssID = AppDefaults.shared.userAddressID
        }
        else{
            lblAddress.text = "Select Address"
        }
      
    }
    
    //MARK: VIEW HANDLING
    
    func HideSlotsView()
    {
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.bottomConstantSlotView.constant = -1000
            
            self.view.layoutIfNeeded()
        }) { _ in
            
            self.alphaImage.isHidden = true
            // self.viewCart.isHidden = false
            
        }
    }
    
    func trash_slotsData()
    {
        self.selectedIndx = -2
        //           self.selectedLotsID = ""
        //           self.selectedIndxDate = -2
        //           self.selectedDate = ""
        stepper.value = 0
        previousValueStepper = 0
        self.lblSericeCount.text = "0"
        //  self.slots = NSArray()
        // self.price = Int(objData?.price ?? "0")!
        self.lblFinalPrice.text = ""
    }
    //MARK:- ShowView For add items in cart
    func ShowSlotsView()
    {
        // self.viewCart.isHidden = true
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.bottomConstantSlotView.constant = 0
            
            self.view.layoutIfNeeded()
        }) { _ in
            
            self.alphaImage.isHidden = false
            
        }
    }
    //MARK:- Change price acc, stteper
    func handlePrice()
    {
        if Int(stepper.value) > previousValueStepper
        {
            if (Int(stepper.value) == 1)
            {
                self.price = Int(orderPrice ?? "0")!
                self.lblFinalPrice.text = "Price: \(AppDefaults.shared.currency)\(String(describing: self.price))"
            }
            else  if (Int(stepper.value) == 0)
            {
                self.price = Int(orderPrice ?? "0")!
                self.lblFinalPrice.text = ""
            }
            else
            {
                self.price = self.price + Int(orderPrice ?? "0")!
                self.lblFinalPrice.text = "Price: \(AppDefaults.shared.currency)\(String(describing: self.price))"
            }
        }
        else
        {
            if (Int(stepper.value) == 1)
            {
                self.price = Int(orderPrice ?? "0") ?? 0
                self.lblFinalPrice.text = "Price: \(AppDefaults.shared.currency)\(String(describing: self.price))"
            }
            else  if (Int(stepper.value) == 0)
            {
                self.price = Int(orderPrice ?? "0") ?? 0
                self.lblFinalPrice.text = ""
            }
            else
            {
                self.price = self.price - (Int(orderPrice ?? "0") ?? 0)
                self.lblFinalPrice.text = "Price: \(AppDefaults.shared.currency)\(String(describing: self.price))"
            }
        }
        
        previousValueStepper = Int(stepper.value)
    }
    
    //MARK:- hitAPi
    func getDetail(){
        viewModel?.getProductDetailApi(serviceId: serviceId ?? "",addressId:addrssID, completion: { (data) in
            if let response = data.body
            {
                self.allDetailData = response
                
                if let cart = self.allDetailData?.cart{
                    if (cart.addressId != "")
                    {
                        self.btnAddToCart.backgroundColor = UIColor.red
                        self.btnAddToCart.setTitle("Remove From Cart?", for: .normal)
                    }
                    else
                    {
                        self.btnAddToCart.backgroundColor = Appcolor.kTheme_Color
                        self.btnAddToCart.setTitle("Add To Cart", for: .normal)
                    }
                }
                else{
                    self.btnAddToCart.backgroundColor = Appcolor.kTheme_Color
                    self.btnAddToCart.setTitle("Add To Cart", for: .normal)
                }
                
                self.companyId = self.allDetailData?.companyId ?? ""
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
                                self.color = data.productColor ?? ""
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
                        DetailVC.sizeList.removeAll()
                        //                        for data in self.productSpecification
                        //                        {
                        if let sizeList = self.productSpecification[0].stockQunatity
                        {
                            for avaliableProduct in sizeList{
                                if sizeIndex == 0{
                                    selectedSize = true
                                    self.size = avaliableProduct.size ?? ""
                                }
                                else{
                                    selectedSize = false
                                }
                                if avaliableProduct.stock != "0"
                                {
                                    let sizeArray = StockQunatity11.init(id:avaliableProduct.id
                                        , size: avaliableProduct.size, stock: avaliableProduct.stock, isSizeSelected: selectedSize,price:avaliableProduct.price,originalPrice: avaliableProduct.originalPrice)
                                    
                                    DetailVC.sizeList.append(sizeArray)
                                }
                                sizeIndex = sizeIndex + 1
                            }
                        }
                        // }
                        self.price = Int(DetailVC.sizeList[0].price ?? "") ?? 0
                        self.orderPrice = DetailVC.sizeList[0].price ?? ""
                        
                    }
                    //  }
                }
                self.tableView.reloadData()
            }
        })
    }
    
    //MARK: ADDING MORE SERVICE USING STEPPER
    @IBAction func actionAddMoreService(_ sender: UIStepper)
    {
        let val = Int(sender.value).description
        
        self.selectedIndx = -2
        //   self.selectedLotsID = ""
        
        if (val == "0")
        {
            self.lblSericeCount.text = "0"
            // self.price = Int(objData?.price ?? "0")!
            self.lblFinalPrice.text = ""
            self.previousValueStepper = 0
            self.showAlertMessage(titleStr: "Oops", messageStr: "Minimum quantity should be one")
        }
        else
        {
            self.lblSericeCount.text = "\(val)"
            self.handlePrice()
            // self.viewModel?.getServiceSlots(sId: objData?.id ?? "0", qntity: "\(val)")
        }
        
    }
    
    @IBAction func actionProceedAfterSlots(_ sender: UIButton)
    {
        if (self.lblSericeCount.text == "0")
        {
            sender.shake()
            self.showAlertMessage(titleStr: kAppName, messageStr: "Please add at-least one quantity!")
        }
            
        else
        {
            viewModel?.addToCartApi(serviceId: serviceId ?? "", companyId: companyId ?? "", addressId: addrssID, orderPrice: orderPrice, quantity: self.lblSericeCount.text ?? "", color: color, size: size, orderTotalPrice: "\(self.price)", completion: { (data) in
                self.AlertMessageWithOkAction(titleStr: kAppName, messageStr: data.message ?? "", Target: self) {
                    self.trash_slotsData()
                    self.HideSlotsView()
                    let controller = Navigation.GetInstance(of: .CartListVC) as! CartListVC
                    self.push_To_Controller(from_controller: self, to_Controller: controller)
                }
            })
        }
    }
    
    @IBAction func actionHideSlotsView(_ sender: Any)
    {
        self.HideSlotsView()
        self.trash_slotsData()
    }
    //MARK:- Actions
    @IBAction func addToCartAction(_ sender: Any) {
        if let cart = allDetailData?.cart{
            if (cart.addressId != "")
            {
                self.viewModel?.deleteCartItem(cartID:cart.id ?? "0")
            }
            else
            {
                self.lblSericeCount.text = "1"
                stepper.value = 1
                self.handlePrice()
                self.ShowSlotsView()
                
            }
        }
        else{
            self.lblSericeCount.text = "1"
            stepper.value = 1
            self.handlePrice()
            self.ShowSlotsView()
        }
        
        
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
                    cell.collectionView.setEmptyMessage("")
                    cell.collectionView.reloadData()
                }
                else{
                    cell.imageList.removeAll()
                    cell.collectionView.setEmptyMessage("No Record Found!")
                }
                return cell
            }
            break
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.SelectSizeTableCell, for: indexPath) as? SelectSizeTableCell
            {
                cell.viewDelegate = self
                if DetailVC.sizeList.count > 0{
                    self.price = Int(DetailVC.sizeList[indexPath.row].price ?? "") ?? 0
                    self.orderPrice = DetailVC.sizeList[indexPath.row].price ?? ""
                    self.size = DetailVC.sizeList[indexPath.row].size ?? ""
                    cell.collectionViewSize.setEmptyMessage("")
                }
                else{
                    
                    cell.collectionViewSize.setEmptyMessage("No Size Found!")
                }
                cell.orderPrice = orderPrice ?? ""
                cell.setView(allData:allDetailData)
                //  cell.sizeArray = self.sizeList
                cell.collectionViewSize.reloadData()
                
                return cell
            }
            break
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeIdentifiers.SelectColorTableCell, for: indexPath) as? SelectColorTableCell
            {
                //cell.colorList = self.colorList
                if DetailVC.colorList.count > 0{
                   cell.collectionViewColor.setEmptyMessage("")
                }
                else{
                    cell.collectionViewColor.setEmptyMessage("No Color Found!")
                }
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
                    cell.collectionView.setEmptyMessage("")
                    cell.currency =  self.allDetailData?.currency ?? ""
                    cell.collectionView.reloadData()
                }
                else{
                    cell.recommendedList.removeAll()
                    cell.collectionView.setEmptyMessage("No Record Found!")
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
    func setDataAccToSize(index: Int?) {
        self.price = Int(DetailVC.sizeList[index ?? 0].price ?? "") ?? 0
        self.orderPrice = DetailVC.sizeList[index ?? 0].price ?? ""
        self.size = DetailVC.sizeList[index ?? 0].size ?? ""
        tableView.reloadData()
    }
    
    func addFavorite() {
        //        AlertMessageWithOkCancelAction(titleStr: kAppName, messageStr: "Are you sure you want to add this product in favorite?", Target: self) { (alert) in
        //            if alert == ""{
        //
        //            }
        //        }
        if allDetailData?.favourite == ""{
            viewModel?.Set_Favorite(serviceId: serviceId ?? "", companyId: companyId, completion: { (data) in
                
                // self.showAlertMessage(titleStr: kAppName, messageStr: data.message ?? "")
                self.getDetail()
            })
        }
        else{
            viewModel?.Set_UNFavorite(favId: allDetailData?.favourite ?? "", completion: { (data) in
                //    self.showAlertMessage(titleStr: kAppName, messageStr: data.message ?? "")
                self.getDetail()
            })
        }
    }
    
    func setDataAccToColor(index: Int?) {
        
        //sizeList
        var sizeIndex = 0
        var selectedSize = false
        DetailVC.sizeList.removeAll()
        
        if self.productSpecification.count > 0{
             self.color = self.productSpecification[index ?? 0].productColor ?? ""
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
                            , size: avaliableProduct.size, stock: avaliableProduct.stock, isSizeSelected: selectedSize,price:avaliableProduct.price,originalPrice: avaliableProduct.originalPrice)
                        
                        DetailVC.sizeList.append(sizeArray)
                    }
                    sizeIndex = sizeIndex + 1
                }
                
                
            }
            
        }
        tableView.reloadData()
    }
    
    func moreReviews(index: Int?) {
        let controller = Navigation.GetInstance(of: .ReviewListVC) as! ReviewListVC
        controller.serviceId = serviceId ?? ""
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

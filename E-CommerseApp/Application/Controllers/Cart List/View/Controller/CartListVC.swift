//
//  CartListVC.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 4/1/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit


class CartListVC: UIViewController
{
    
    @IBOutlet var tfCode: UITextField!
    @IBOutlet var lblImport: UILabel!
    @IBOutlet var lblShipping: UILabel!
    @IBOutlet var tblHeight: NSLayoutConstraint!
    @IBOutlet var btnClearAll: UIBarButtonItem!
  //  @IBOutlet var ivArrowCoupon: UIImageView!
    @IBOutlet var viewCheckOut: UIView!
    @IBOutlet var viewItems: UIView!
    @IBOutlet var tableViewCartList: UITableView!
    @IBOutlet var lblTotal_Items: UILabel!
    @IBOutlet var lblTotal_Price: UILabel!
    @IBOutlet var lblFinal_Price: UILabel!
    @IBOutlet var btnCheckout: UIButton!
    @IBOutlet var lblStrikeThru: UILabel!
 //   @IBOutlet var btnCoupon: UIButton!
    
 //   @IBOutlet var constant_WidthRemoveButton: NSLayoutConstraint!
    
    var isSkeleton_Service = true
    var skeletonItems_Service = 5
    var apiData : [CartListResult]?
    let cellID = "CellClass_CartList"
    var viewModel:CartList_ViewModel?
    var sumTotal = 0
    var sumItems = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setUI()
        self.viewModel = CartList_ViewModel.init(Delegate: self, view: self)
      //  self.viewModel!.getCartList()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
       // self.viewModel!.getCartList()
        self.tblHeight.constant = 5*120
    }
    
    
    
    @IBAction func actionClearCart(_ sender: Any)
    {
        self.AlertMessageWithOkCancelAction(titleStr: kAppName, messageStr: "Are you sure you want to clear your cart?", Target: self)
        { (actn) in
            if (actn == KYes)
            {
                self.viewModel?.ClearCartList()
            }
        }
    }
    
    
    @IBAction func moveBack(_ sender: Any)
    {
        self.moveBACK(controller: self)
    }
    
    
    @IBAction func cellAction_DeleteItem(_ sender: UIButton)
    {
        let obj = self.apiData![sender.tag]
        
        self.AlertMessageWithOkCancelAction(titleStr: kAppName, messageStr: "Are you sure you want to remove it?", Target: self)
        { (actn) in
            if (actn == KYes)
            {
                self.viewModel?.deleteCartItem(cartID: obj.id)
            }
        }
    }
    
    
    @IBAction func cellActionFav(_ sender: Any)
    {
        
    }
    
    
    
    @IBAction func applyCoupon(_ sender: UIButton)
    {
        if(tfCode.text?.count == 0)
        {
            self.showErrorToast(msg: "Please enter coupon code!", img: KSignalY)
        }
        else
        {
            
        }
    }
    
    
    @IBAction func actionRemoveCoupon(_ sender: Any)
    {
        
    }
    
    
    @IBAction func actionCheckout(_ sender: Any)
    {
        
       // let controller = Navigation.GetInstance(of: .CheckAvailabilityVC)as! CheckAvailabilityVC
       // controller.items = self.apiData?.count ?? 0
      //  self.push_To_Controller(from_controller: self, to_Controller: controller)

    }
    
    
    
    
    func setUI()
    {
        self.lblStrikeThru.text = ""
       // self.viewCheckOut.isHidden = true
        self.btnCheckout.backgroundColor = Appcolor.getThemeColor()
        self.btnCheckout.setTitleColor(Appcolor.kTextColorWhite, for: .normal)
        self.lblFinal_Price.textColor = Appcolor.getThemeColor()
       // self.constant_WidthRemoveButton.constant = 0
    }
    
    func checkCouponApplied()
    {
        self.handleCoupon_Removal()
    }
    
    
    func handleCoupon_Removal()
    {
//        UIView.animate(withDuration: 0.6, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
//            self.ivArrowCoupon.isHidden = false
//            self.lblStrikeThru.attributedText = NSAttributedString(string: "")
//            self.view.layoutIfNeeded()
//        }, completion: nil)
    }
    
    
    
    
}

extension CartListVC : CartListVCDelegate
{
    func getData(subcats : [CartListResult],sum:Int,items:Int)
    {
        DispatchQueue.main.async
            {
                if (subcats.count > 0)
                {
                    self.sumTotal = sum
                    self.sumItems = items
                    self.navigationItem.rightBarButtonItem = self.btnClearAll
                    self.viewCheckOut.isHidden = false
                    self.apiData = subcats
                    self.isSkeleton_Service = false
                    self.tableViewCartList.restore()
                    self.tableViewCartList.reloadData()
                    self.lblTotal_Price.text = "\(subcats.count)"
                    self.lblFinal_Price.text = "\(AppDefaults.shared.currency)\(sum)"
                    self.checkCouponApplied()
                }
                else
                {
                    self.nothingFound()
                }
        }
    }
    
    func nothingFound()
    {
        self.navigationItem.rightBarButtonItem = nil
        self.viewCheckOut.isHidden = true
        self.isSkeleton_Service = false
        self.apiData = nil
      //  self.tableViewCartList.setEmptyImage(imgName: "empCart")
        self.tableViewCartList.setEmptyMessage(kDataNothingTOSHOW)
        self.tableViewCartList.reloadData()
    }
    
}

/*extension CartListVC : UpdateViewAfterSuccess_Delegate
{
    func refreshController(approach: String)
    {
        if (approach == "home")
        {
            let controller = Navigation.GetInstance(of: .HomeVC)as! HomeVC
            self.push_To_Controller(from_controller: self, to_Controller: controller)
        }
    }
} */

extension CartListVC : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isSkeleton_Service == true
        {
            return skeletonItems_Service
        }
        
        return apiData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)as! CellClass_CartList
        
        if let obj = apiData?[indexPath.row]
        {
            let img = obj.service.icon
            cell.iv.setImage(with: img, placeholder: kplaceholderImage)
            cell.btnDelete.tag = indexPath.row
            cell.lblName.text = obj.service.name
            cell.lblPrice.text = "\(AppDefaults.shared.currency)\(obj.orderPrice)"
            cell.iv.CornerRadius(radius: 10.0)
            
            cell.hideAnimation()
        }
        else
        {
            cell.showAnimation()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120.0
    }
}


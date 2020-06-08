//
//  OrderListVC.swift
//  E-CommerseApp
//
//  Created by Mohit Sharma on 6/4/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class OrderListVC: CustomController
{
    
    @IBOutlet var tblOrders: UITableView!
    @IBOutlet var btnDrawer: UIBarButtonItem!
    
    let cellID = "CellClass_OrderDetails"
    var viewModel:OrderList_ViewModel?
    var skeletonItems_Service = 5
    var isSkeleton_Service = true
    
   // var apiData : [CartListResult]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.viewModel = OrderList_ViewModel.init(Delegate: self, view: self)
        
        btnDrawer.target = self.revealViewController()
        btnDrawer.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.setTapGestureOnSWRevealontroller(view: self.view, controller: self)

        // Do any additional setup after loading the view.
    }
    

}

extension OrderListVC : OrderListVCDelegate
{
    func getData()
    {
        
    }
    
    func nothingFound()
    {
        self.isSkeleton_Service = false
       // self.apiData = nil
        self.tblOrders.setEmptyMessage(kDataNothingTOSHOW)
        self.tblOrders.reloadData()
    }
    
}


extension OrderListVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)as! CellClass_OrderDetails
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let controller = Navigation.GetInstance(of: .OrderDetailsVC) as! OrderDetailsVC
        push_To_Controller(from_controller: self, to_Controller: controller)
    }
    
}

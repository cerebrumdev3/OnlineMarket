//
//  OrderDetailsVC.swift
//  E-CommerseApp
//
//  Created by Mohit Sharma on 6/3/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit

class OrderDetailsVC: UIViewController
{
    
    @IBOutlet var lblOrderNumber: UILabel!
    @IBOutlet var lblOrderDate: UILabel!
    @IBOutlet var lblPurchaseDate: UILabel!
    @IBOutlet var lblEstimatedDelivery: UILabel!
    
    @IBOutlet var lblDate1: UILabel!
    @IBOutlet var ivtick1: UIImageView!
    @IBOutlet var ivPipe: UIImageView!
    @IBOutlet var lblDate2: UILabel!
    @IBOutlet var ivTick2: UIImageView!
    @IBOutlet var ivPipe2: UIImageView!
    @IBOutlet var lblDate3: UILabel!
    @IBOutlet var ivTick3: UIImageView!
    @IBOutlet var ivPipe3: UIImageView!
    @IBOutlet var lblDate4: UILabel!
    @IBOutlet var ivTick4: UIImageView!
    
    @IBOutlet var lblDetailsItems: UILabel!
    @IBOutlet var lblItemsPrice: UILabel!
    @IBOutlet var lblShippingPrice: UILabel!
    @IBOutlet var lblImportPrice: UILabel!
    @IBOutlet var lblTotalPrice: UILabel!
    
    
    
    @IBOutlet var tbleHeight: NSLayoutConstraint!
    @IBOutlet var tblviewOrders: UITableView!
    
    var viewModel:OrderDetails_ViewModel?
    
    let cellID = "CellClass_OrderDetails"

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.viewModel = OrderDetails_ViewModel.init(Delegate: self, view: self)

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.tbleHeight.constant = 2*130
    }
    
    @IBAction func moveBack(_ sender: Any)
    {
        self.moveBACK(controller: self)
    }
    
    func handlePickUp()
    {
        self.ivtick1.image = UIImage(named:"tickDone")
        
        self.ivPipe.backgroundColor = Appcolor.kTextColorGray
        self.ivTick2.image = UIImage(named:"tickUD")
        self.ivPipe2.backgroundColor = Appcolor.kTextColorGray
        self.ivTick3.image = UIImage(named:"tickUD")
        self.ivPipe3.backgroundColor = Appcolor.kTextColorGray
        self.ivTick4.image = UIImage(named:"tickUD")
    }
    func handleDispached()
    {
        self.ivtick1.image = UIImage(named:"tickDone")
        self.ivPipe.backgroundColor = Appcolor.getThemeColor()
        self.ivTick2.image = UIImage(named:"tickDone")
        
        self.ivPipe2.backgroundColor = Appcolor.kTextColorGray
        self.ivTick3.image = UIImage(named:"tickUD")
        self.ivPipe3.backgroundColor = Appcolor.kTextColorGray
        self.ivTick4.image = UIImage(named:"tickUD")
    }
    func handleArrived()
    {
        self.ivtick1.image = UIImage(named:"tickDone")
        self.ivPipe.backgroundColor = Appcolor.getThemeColor()
        self.ivTick2.image = UIImage(named:"tickDone")
        self.ivPipe2.backgroundColor = Appcolor.getThemeColor()
        self.ivTick3.image = UIImage(named:"tickDone")
        
        self.ivPipe3.backgroundColor = Appcolor.kTextColorGray
        self.ivTick4.image = UIImage(named:"tickUD")
    }
    func handleDelivered()
    {
        self.ivtick1.image = UIImage(named:"tickDone")
        self.ivPipe.backgroundColor = Appcolor.getThemeColor()
        self.ivTick2.image = UIImage(named:"tickDone")
        self.ivPipe2.backgroundColor = Appcolor.getThemeColor()
        self.ivTick3.image = UIImage(named:"tickDone")
        self.ivPipe3.backgroundColor = Appcolor.getThemeColor()
        self.ivTick4.image = UIImage(named:"tickDone")
    }

}

extension OrderDetailsVC : OrderDetailsVCDelegate
{
    func getData()
    {
        
    }
    
    func nothingFound()
    {
        
    }
    
}



extension OrderDetailsVC : UITableViewDelegate,UITableViewDataSource
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
    
}

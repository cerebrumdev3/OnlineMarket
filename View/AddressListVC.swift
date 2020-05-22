//
//  AddressListVC.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 3/23/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit

class AddressListVC: CustomController
{
    
    @IBOutlet var btnAdd: CustomButton!
    @IBOutlet var tableView_List: UITableView!
    @IBOutlet var btnDrawer: UIBarButtonItem!
    
    var apiDATA : [AddressList_Result]?
    let cellID = "CellClass_AddressList"
    var viewModel:AddressList_ViewModel?
    
    var row = 0
    var isSkeleton = true
    var skeletonItems = 4
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.viewModel = AddressList_ViewModel.init(Delegate: self, viewMain: self, view: self)
        setUI()
        btnDrawer.target = self.revealViewController()
        btnDrawer.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.setTapGestureOnSWRevealontroller(view: self.view, controller: self)
        self.tableView_List.setEmptyMessage("Addresses Not Available!")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.viewModel?.getAddressList()
    }
    
    @IBAction func actionAddMoreAddress(_ sender: Any)
    {
        let controller = Navigation.GetInstance(of: .AddNewAddressVC) as! AddNewAddressVC
        self.push_To_Controller(from_controller: self, to_Controller: controller)
    }
    
    
    @IBAction func cellAction_SetDefaultLocation(_ sender: UIButton)
    {
        let obj = apiDATA![sender.tag]
        
        let adrsID = "\(String(describing: obj.id))"
        let adrsname = "\(String(describing: obj.addressName))"
        let adrscity = "\(String(describing: obj.city))"
        let adrsLat = "\(String(describing: obj.latitude))"
        let adrsLong = "\(String(describing: obj.longitude))"
        var status = "0"
        var txt = ""
        
        if (obj.bodyDefault == 0)
        {
            status = "1"
            txt = "Are you sure you want to set this address as your default location?"
           // AppDefaults.shared.userAddressType = obj.addressType
            AppDefaults.shared.userHomeAddress = adrsname
           // AppDefaults.shared.userAddressID = adrsID
        }
        else
        {
            status = "0"
            txt = "Are you sure you want to remove this location from default?"
           // AppDefaults.shared.userAddressType = ""
            AppDefaults.shared.userHomeAddress = ""
           // AppDefaults.shared.userAddressID = ""
        }
        
        self.AlertMessageWithOkCancelAction(titleStr: kAppName, messageStr: txt, Target: self)
        { (actn) in
            if (actn == KYes)
            {
                self.row = sender.tag
                self.viewModel?.Make_Address_Default_Undefault(addressId: adrsID, addressName: adrsname, city: adrscity, lat: adrsLat, long: adrsLong, defaultStatus: status)
            }
        }
    }
    
    
    @IBAction func cellActionDelete(_ sender: UIButton)
    {
        let obj = apiDATA![sender.tag]
        let adrsID = "\(String(describing: obj.id))"
        
        self.AlertMessageWithOkCancelAction(titleStr: kAppName, messageStr: "Do you want to delete this address?", Target: self)
        { (actn) in
            if (actn == KYes)
            {
                if (self.apiDATA?.count == 1)//empty address
                {
                  //  AppDefaults.shared.userAddressType = ""
                    AppDefaults.shared.userHomeAddress = ""
                  //  AppDefaults.shared.userAddressID = ""
                }
                self.row = sender.tag
                self.viewModel?.DeleteAddress(addressID: adrsID)
            }
        }
        
        
    }
    
    func setUI()
    {
        self.btnAdd.backgroundColor = Appcolor.getThemeColor()
        self.btnAdd.setTitleColor(Appcolor.kTextColorWhite, for: UIControl.State.normal)
    }
    
    func deleteCellROW()
    {
        let indxpth = IndexPath(row: self.row, section: 0)
        apiDATA?.remove(at: self.row)
        self.tableView_List.deleteRows(at: [indxpth], with: .fade)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
        {
            if (self.apiDATA?.count == 0)
            {
                self.tableView_List.setEmptyMessage("Addresses Not Available!")
            }
            self.tableView_List.reloadData()
        }
    }
    
    func saveAddressDetail_forDefault()
    {
        if let obj =  self.apiDATA?[0]
        {
          //  AppDefaults.shared.userAddressType = obj.addressType
            AppDefaults.shared.userHomeAddress = obj.addressName
          //  AppDefaults.shared.userAddressID = obj.id
        }
    }
}

extension AddressListVC : AddressListVCDelegate
{
    func getData(model: [AddressList_Result])
    {
        if (model.count > 0)
        {
           // AppDefaults.shared.userAddressAdded = "true"
            isSkeleton = false
            self.apiDATA = model
            self.tableView_List.reloadData()
            self.tableView_List.setEmptyMessage("")
            if (model.count == 1)
            {
                self.saveAddressDetail_forDefault()
            }
        }
        else
        {
            isSkeleton = true
            skeletonItems = 0
            self.tableView_List.reloadData()
            self.tableView_List.setEmptyMessage("Addresses Not Available!")
        }
    }
    
    func nothingFound()
    {
        self.apiDATA = nil
        self.tableView_List.setEmptyMessage("Addresses Not Available!")
        self.skeletonItems = 0
        self.isSkeleton = false
        self.tableView_List.reloadData()
    }
}

extension AddressListVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (isSkeleton == false)
        {
            return self.apiDATA?.count ?? 0
        }
        return skeletonItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CellClass_AddressList
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDefault.tag = indexPath.row
        
        if let data =  self.apiDATA?[indexPath.row]
        {
            cell.hideAnimation()
            cell.lblType.text = data.addressType
            cell.lblLocation.text = data.addressName
            
            if (data.bodyDefault == 0)
            {
                cell.btnDefault.setBackgroundImage(UIImage(named: "radio_unselected"), for: .normal)
            }
            else
            {
                cell.btnDefault.setBackgroundImage(UIImage(named: "radio_selected"), for: .normal)
            }
            
            if (data.addressType == "Home")
            {
                cell.ivMarker.image = UIImage(named:"home")
            }
            else if (data.addressType == "Work")
            {
                cell.ivMarker.image = UIImage(named:"work")
            }
            else
            {
                cell.ivMarker.image = UIImage(named:"other")
            }
        }
        else
        {
            cell.showAnimation()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }
    
}

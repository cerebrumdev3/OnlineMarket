//
//  ControllerExtendion.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 3/24/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation
import UIKit

extension AddNewAddressVC
{
    func HideDetailsView()
    {
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.bottomContraint_BlurView.constant = -1000
            self.view.layoutIfNeeded()
        }) { _ in
        }
    }
    
    func ShowDetailsView()
    {
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.bottomContraint_BlurView.constant = 0
            self.view.layoutIfNeeded()
        }) { _ in
        }
    }
    
    
    func AddNewAddress_onServer(sender:UIButton)
    {
        if self.tfAddress.text?.count == 0
        {
            self.showErrorToast(msg:"Please enter your address",img:KSignalY)
            sender.shake()
        }
        else if self.tfHouseNumber.text?.count == 0
        {
            self.showErrorToast(msg:"Please enter your house number",img:KSignalY)
            sender.shake()
        }
        else if self.tfCity.text?.count == 0
        {
            self.showErrorToast(msg:"Please enter your city name",img:KSignalY)
            sender.shake()
        }
        else
        {
            self.viewModel?.AddNewAddress_ToServer(Address: self.tfAddress.text!, city: self.tfCity.text!, type: self.addressType, house: self.tfHouseNumber.text!, lat: self.lat, long: self.long, defaultLoc: "0")
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return true
    }
    
}

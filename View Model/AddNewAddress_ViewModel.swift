//
//  AddNewAddress_ViewModel.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 3/24/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation
import Alamofire

class AddNewAddress_ViewModel
{
    
    var view : AddNewAddressVC
    
    init(view : AddNewAddressVC)
    {
        self.view = view
    }
    
    func AddNewAddress_ToServer(Address:String,city:String,type:String,house:String,lat:String,long:String,defaultLoc:String)
    {
        let obj : [String:Any] = ["addressName":Address,"latitude":lat,"longitude" :long,"city":city,"default":defaultLoc,"addressType":type,"houseNo":house]
        
        WebService.Shared.PostApi(url: APIAddress.ADD_ADDRESS, parameter: obj , Target: self.view, completionResponse: { response in
            Commands.println(object: response)
            
            if let responseData = response as? NSDictionary
            {
                let code = responseData.value(forKey: "code") as? Int ?? 0
                let msg = responseData.value(forKey: "message") as? String ?? "success"
                
                if (code == 200)
                {
                    self.view.AlertMessageWithOkAction(titleStr: kAppName, messageStr: msg, Target: self.view)
                    {
                        self.view.moveBACK(controller: self.view)
                    }
                }
                else
                {
                    self.view.showErrorToast(msg:msg,img:KSignalR)
                }
            }
            else
            {
                self.view.showErrorToast(msg:kResponseNotCorrect,img:KSignalR)
            }
        }, completionnilResponse: {(error) in
            self.view.showErrorToast(msg:error,img:KSignalR)
        })
        
    }
    
    
}

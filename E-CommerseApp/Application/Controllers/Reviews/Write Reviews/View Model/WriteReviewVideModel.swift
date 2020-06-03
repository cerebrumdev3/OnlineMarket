//
//  WriteReviewVideModel.swift
//  E-CommerseApp
//
//  Created by Mohit Sharma on 6/3/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation
import Alamofire

class AddReview_ViewModel
{
    
    var view : WriteReviewVC
    
    init(view : WriteReviewVC)
    {
        self.view = view
    }
    
    func AddReviews(Address:String,city:String,type:String,house:String,lat:String,long:String,defaultLoc:String)
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


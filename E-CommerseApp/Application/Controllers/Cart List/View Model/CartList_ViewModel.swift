//
//  CartList_ViewModel.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 4/1/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation
import Alamofire

protocol CartListVCDelegate
{
    func getData (subcats : [CartListResult],sum:Int,items:Int)
    func nothingFound()
}

class CartList_ViewModel
{
    var delegate : CartListVCDelegate
    var view : CartListVC
    
    init(Delegate : CartListVCDelegate, view : CartListVC)
    {
        delegate = Delegate
        self.view = view
    }
    
    func getCartList()
    {
        WebService.Shared.GetApi(url: APIAddress.GET_CART_LIST, Target: self.view, showLoader: true, completionResponse:
        { (response) in
            
            do
            {
                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let model = try JSONDecoder().decode(CartListModel.self, from: jsonData)
                self.delegate.getData(subcats: model.body.data, sum: model.body.sum,items: model.body.totalQunatity)
            }
            catch
            {
                self.delegate.nothingFound()
                self.view.showAlertMessage(titleStr: kAppName, messageStr: kResponseNotCorrect)
            }
            
        })
        { (err) in
            self.delegate.nothingFound()
           // self.view.showAlertMessage(titleStr: kAppName, messageStr: err)
        }
        
    }
    
    
   func deleteCartItem(cartID:String)
    {
        let obj : [String:Any] = ["cartId":cartID]
        
        WebService.Shared.deleteApi(url: APIAddress.DELETE_CART_ITEM, parameter: obj, Target: self.view, showLoader: true, completionResponse: { (response) in
            
            if let responseData = response as? NSDictionary
            {
                let code = responseData.value(forKey: "code") as? Int ?? 0
                let msg = responseData.value(forKey: "message") as? String ?? "success"
                
                if (code == 200)
                {
                    self.view.AlertMessageWithOkAction(titleStr: kAppName, messageStr: msg, Target: self.view)
                    {
                        self.getCartList()
                    }
                }
                else
                {
                    self.view.showAlertMessage(titleStr: kAppName, messageStr: msg)
                }
            }
            else
            {
                self.view.showAlertMessage(titleStr: kAppName, messageStr: kResponseNotCorrect)
            }
            
        })
        { (error) in
            
            self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
        }
        
    }
    
    
    func ClearCartList()
    {
        let obj : [String:Any] = [:]
        
        WebService.Shared.deleteApi(url: APIAddress.CLEAR_CART_ITEMS, parameter: obj, Target: self.view, showLoader: true, completionResponse: { (response) in
            
            if let responseData = response as? NSDictionary
            {
                let code = responseData.value(forKey: "code") as? Int ?? 0
                let msg = responseData.value(forKey: "message") as? String ?? "success"
                
                if (code == 200)
                {
                    self.view.AlertMessageWithOkAction(titleStr: kAppName, messageStr: msg, Target: self.view)
                    {
                        self.getCartList()
                    }
                }
                else
                {
                    self.view.showAlertMessage(titleStr: kAppName, messageStr: msg)
                }
            }
            else
            {
                self.view.showAlertMessage(titleStr: kAppName, messageStr: kResponseNotCorrect)
            }
        })
        { (error) in
            self.delegate.nothingFound()
            self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
        }
    }

    
}


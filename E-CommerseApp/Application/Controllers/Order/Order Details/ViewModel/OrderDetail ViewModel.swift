//
//  OrderDetail ViewModel.swift
//  E-CommerseApp
//
//  Created by Mohit Sharma on 6/4/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation
import Alamofire

protocol OrderDetailsVCDelegate
{
    func getData()
    func nothingFound()
}

class OrderDetails_ViewModel
{
    var delegate : OrderDetailsVCDelegate
    var view : OrderDetailsVC
    
    init(Delegate : OrderDetailsVCDelegate, view : OrderDetailsVC)
    {
        delegate = Delegate
        self.view = view
    }
    
    func getOrderDetails()
    {
        WebService.Shared.GetApi(url: APIAddress.GET_CART_LIST, Target: self.view, showLoader: true, completionResponse:
        { (response) in
            
            do
            {
                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let model = try JSONDecoder().decode(CartListModel.self, from: jsonData)
               // self.delegate.getData(subcats: model.body.data, sum: model.body.sum,items: model.body.totalQunatity)
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
    
    
   

    
}


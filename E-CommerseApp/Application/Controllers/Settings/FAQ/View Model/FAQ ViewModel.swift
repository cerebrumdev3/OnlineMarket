//
//  FAQ ViewModel.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 5/21/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation
import Alamofire

protocol FAQVCDelegate
{
    func getData (model : [FAQResult])
    func nothingFound()
}

class FAQViewModel
{
    var delegate : FAQVCDelegate
    var view : FAQVC
    
    init(Delegate : FAQVCDelegate, view : FAQVC)
    {
        delegate = Delegate
        self.view = view
    }
    
    func getFAQList()
    {
        WebService.Shared.GetApi(url: APIAddress.GET_FAQ + "limit=100&page=1"
            , Target: self.view, showLoader: true, completionResponse: { response in
                Commands.println(object: response)
                
                do
                {
                    let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                    let model = try JSONDecoder().decode(FAQResponseModel.self, from: jsonData)
                    let list = model.body
                    self.delegate.getData(model: list)
                }
                catch
                {
                    self.view.showAlertMessage(titleStr: kAppName, messageStr: kResponseNotCorrect)
                }
                
        }, completionnilResponse: {(error) in
            self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
        })
        
    }
    
}


//
//  DetailViewModel.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 29/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation


protocol DetailDelegate:class
{
    func Show(msg: String)
    func didError(error:String)
}

class DetailViewModel
{
    typealias successHandler = (DetailModel) -> Void
    var delegate : DetailDelegate
    var view : UIViewController
    
    init(Delegate : DetailDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }

    //MARK:- GetHomeServiceApi
    func getProductDetailApi(serviceId : String,completion: @escaping successHandler)
        {
            WebService.Shared.GetApi(url: APIAddress.getProductDetail + serviceId  , Target: self.view, showLoader: true, completionResponse: { (response) in
                  print(response)
                        do
                        {
                            let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                            let getAllListResponse = try JSONDecoder().decode(DetailModel.self, from: jsonData)
                            completion(getAllListResponse)
                        }
                        catch
                        {
                            print(error.localizedDescription)
                            self.view.showAlertMessage(titleStr: kAppName, messageStr: error.localizedDescription)
                        }
                        
                    }, completionnilResponse: {(error) in
                        self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
                    })
        }
    
  
}

//MARK:- HomeDelegate
extension DetailVC : DetailDelegate
{
    func Show(msg: String) {
    }
    
    func didError(error: String) {
    }
    
    
}

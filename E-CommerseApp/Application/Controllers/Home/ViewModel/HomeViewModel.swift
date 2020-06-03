//
//  HomeViewModel.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 26/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation

protocol HomeDelegate:class
{
    func Show(msg: String)
    func didError(error:String)
}

class HomeViewModel
{
    typealias successHandler = (HomeVCModel) -> Void
    var delegate : HomeDelegate
    var view : UIViewController
    
    init(Delegate : HomeDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }

    //MARK:- GetHomeServiceApi
        func getHomeServicesApi(completion: @escaping successHandler)
        {
            WebService.Shared.GetApi(url: APIAddress.GET_HOME_CATEGORIES , Target: self.view, showLoader: true, completionResponse: { (response) in
                  print(response)
                        do
                        {
                            let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                            let getAllListResponse = try JSONDecoder().decode(HomeVCModel.self, from: jsonData)
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
extension HomeVC : HomeDelegate
{
    func Show(msg: String) {
    }
    
    func didError(error: String) {
    }
    
    
}

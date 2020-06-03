//
//  FavoriteViewMOdel.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 28/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation

protocol FavoriteDelegate:class
{
    func Show(msg: String)
    func didError(error:String)
}

class FavoriteViewModel
{
    typealias successHandler = (FavoriteModel) -> Void
    var delegate : FavoriteDelegate
    var view : UIViewController
    var isSearching : Bool?
    
    init(Delegate : FavoriteDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }

    //MARK:- GetHomeServiceApi
        func getHomeServicesApi(completion: @escaping successHandler)
        {
            WebService.Shared.GetApi(url: APIAddress.BASE_URL + APIAddress.GET_HOME_CATEGORIES , Target: self.view, showLoader: true, completionResponse: { (response) in
                  print(response)
                        do
                        {
                            let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                            let getAllListResponse = try JSONDecoder().decode(FavoriteModel.self, from: jsonData)
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

//MARK:- FavoriteProductVCDelegate
extension FavoriteProductVC : FavoriteDelegate
{
    func Show(msg: String) {
    }
    
    func didError(error: String) {
    }
    
    
}

//
//  CategoryViewModel.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 26/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation


protocol CategoryDelegate:class
{
    func Show(msg: String)
    func didError(error:String)
}

class CategoryViewModel
{
    typealias successHandler = (CategoryModel) -> Void
    var delegate : CategoryDelegate
    var view : UIViewController
    var isSearching : Bool?
    
    init(Delegate : CategoryDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }

    //MARK:- GetHomeServiceApi
        func getCategoryListApi(completion: @escaping successHandler)
        {
            WebService.Shared.GetApi(url: APIAddress.getCategoryList , Target: self.view, showLoader: true, completionResponse: { (response) in
                  print(response)
                        do
                        {
                            let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                            let getAllListResponse = try JSONDecoder().decode(CategoryModel.self, from: jsonData)
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

//MARK:- CategoryVCDelegate
extension CategoryVC : CategoryDelegate
{
    func Show(msg: String) {
    }
    
    func didError(error: String) {
    }
    
    
}

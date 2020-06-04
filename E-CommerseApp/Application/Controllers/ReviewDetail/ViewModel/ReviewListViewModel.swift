//
//  ReviewListViewModel.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 28/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation


protocol ReviewListDelegate:class
{
    func Show(msg: String)
    func didError(error:String)
}

class ReviewlistViewModel
{
    typealias successHandler = (ReviewListModel) -> Void
    var delegate : ReviewListDelegate
    var view : UIViewController
    
    init(Delegate : ReviewListDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }

    //MARK:- GetHomeServiceApi
    func getProductAllReviewsApi(serviceId:String?,page:Int,filterRating:String?,limit:Int,completion: @escaping successHandler)
        {
            let url =   "&page=" + "\(page)" + "&limit=" + "\(limit)"
            let url1 = "&filterRating=" + (filterRating ?? "")
            WebService.Shared.GetApi(url:  APIAddress.getProductAllRating + (serviceId ?? "") + url1 + url, Target: self.view, showLoader: true, completionResponse: { (response) in
                  print(response)
                        do
                        {
                            let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                            let getAllListResponse = try JSONDecoder().decode(ReviewListModel.self, from: jsonData)
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

//MARK:- ReviewListDelegate
extension ReviewListVC : ReviewListDelegate
{
    func Show(msg: String) {
    }
    
    func didError(error: String) {
    }
    
    
}

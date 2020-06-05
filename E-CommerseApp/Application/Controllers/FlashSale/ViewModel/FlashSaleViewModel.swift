//
//  FlashSaleViewModel.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 27/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation

protocol FlashDelegate:class
{
    func Show(msg: String)
    func didError(error:String)
}

class FlashViewModel
{
    typealias successHandler = (FlashModel) -> Void
    var delegate : FlashDelegate
    var view : UIViewController
    var isSearching : Bool?
    var showloader : Bool?
    
    init(Delegate : FlashDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }

    //MARK:- GetServiceApi
    func getServices(category:String?,page:Int?,brandArray:[String]?,catArray:[String]?,priceRange:[String:Any]?,orderByInfo:[String:Any]?,search:String?,completion: @escaping successHandler)
        {
            let obj:[String:Any] = ["category":category ?? "","brandArray":brandArray ?? [String](),"catArray":catArray ?? [String](),"orderByInfo":orderByInfo ?? [String:Any](),"priceRange":priceRange ?? [String:Any](),"page":page ?? 0,"limit":10,"search":search ?? ""]
            if isSearching == true{
                showloader = false
            }
            else{
                showloader = true
            }
            
            WebService.Shared.PostApi(url: APIAddress.getProductList, parameter: obj, showLoader: showloader ?? true, Target: self.view, completionResponse: { (response) in
                  if let responseData  = response as? [String : Any]
                                            {
                                                self.FilterDataJSON(data: responseData, completionResponse: { (addedMember) in
                                                    completion(addedMember)
                                                }, completionError: { (error) in
                                                    
                                                })
                                            }
                                            else{
                                                
                                            }
                                      
                                  }, completionnilResponse: {(error) in
                                     // self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
                                    self.delegate.didError(error: error)
                                  })
           
        }
    
    //MARK:- Sale Service
    func getSaleServices(page:Int?,brandArray:[String]?,catArray:[String]?,priceRange:[String:Any]?,orderByInfo:[String:Any]?,search:String?,completion: @escaping successHandler)
         {
             let obj:[String:Any] = ["brandArray":brandArray ?? [String](),"catArray":catArray ?? [String](),"orderByInfo":orderByInfo ?? [String:Any](),"priceRange":priceRange ?? [String:Any](),"page":page ?? 0,"limit":10,"search":search ?? ""]
            
             if isSearching == true{
                 showloader = false
             }
             else{
                 showloader = true
             }
             
             WebService.Shared.PostApi(url: APIAddress.getSalesProduct, parameter: obj, showLoader: showloader ?? true, Target: self.view, completionResponse: { (response) in
                   if let responseData  = response as? [String : Any]
                                             {
                                                 self.FilterDataJSON(data: responseData, completionResponse: { (addedMember) in
                                                     completion(addedMember)
                                                 }, completionError: { (error) in
                                                     
                                                 })
                                             }
                                             else{
                                                 
                                             }
                                       
                                   }, completionnilResponse: {(error) in
                                      // self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
                                     self.delegate.didError(error: error)
                                   })
            
         }
    
    //MARK:- AddedMembers
       private func FilterDataJSON(data: [String : Any],completionResponse:  @escaping (FlashModel) -> Void,completionError: @escaping (String?) -> Void)
       {
           let addedMembersData = FlashModel(dict: data)
           completionResponse(addedMembersData)
           
       }
  
}

//MARK:- FlashVCDelegate
extension FlasSaleVC : FlashDelegate
{
    func Show(msg: String) {
    }
    
    func didError(error: String) {
        self.tbleView.isHidden = true
        self.lblNoRecord.isHidden = false
    }
    
    
}

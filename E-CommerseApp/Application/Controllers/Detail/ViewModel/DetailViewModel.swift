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
    typealias addFavoriteSuccess = (AddFavoriteModel) -> Void
    var delegate : DetailDelegate
    var view : UIViewController
    
    init(Delegate : DetailDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }
    
    //MARK:- GetHomeServiceApi
    func getProductDetailApi(serviceId : String,addressId:String?,completion: @escaping successHandler)
    {
        WebService.Shared.GetApi(url: APIAddress.getProductDetail + serviceId + "&addressId=\(addressId ?? "")" , Target: self.view, showLoader: true, completionResponse: { (response) in
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
    
    func Set_Favorite(serviceId:String?,companyId:String?,completion: @escaping addFavoriteSuccess)
    {
        let params = ["serviceId":serviceId ?? "","companyId":companyId ?? ""]
        WebService.Shared.PostApi(url: APIAddress.ADD_TO_FAVORITES, parameter: params, showLoader: true, Target: self.view, completionResponse:
            { (response) in
                print(response)
                do
                {
                    let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                    let getAllListResponse = try JSONDecoder().decode(AddFavoriteModel.self, from: jsonData)
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
    
    func Set_UNFavorite(favId:String,completion: @escaping addFavoriteSuccess)
    {
        let params = ["favId":favId]
        
        WebService.Shared.deleteApi(url: APIAddress.REMOVE_FROM_FAVORITES, parameter: params, Target: self.view, showLoader: true, completionResponse:
            { (response) in
                
                do
                {
                    let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                    let getAllListResponse = try JSONDecoder().decode(AddFavoriteModel.self, from: jsonData)
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
    
    //MARK:- AddToCart
    
    
    func addToCartApi(serviceId:String?,companyId:String?,addressId:String?,orderPrice:String?,quantity:String?,color:String?,size:String?,orderTotalPrice:String?,completion: @escaping addFavoriteSuccess)
    {
        let params = ["serviceId":serviceId ?? "","companyId":companyId ?? "","addressId":addressId ?? "","orderPrice":orderPrice ?? "","quantity":quantity ?? "","color":color ?? "","size":size ?? "","orderTotalPrice":orderTotalPrice ?? ""]
        
        WebService.Shared.PostApi(url: APIAddress.ADD_TO_CART, parameter: params, showLoader: true, Target: self.view, completionResponse:
            { (response) in
                print(response)
                do
                {
                    let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                    let getAllListResponse = try JSONDecoder().decode(AddFavoriteModel.self, from: jsonData)
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
   
    func deleteCartItem(cartID:String)
       {
           let obj = [String:Any]()// = ["cartId":cartID]
           
           WebService.Shared.deleteApi(url: APIAddress.DELETE_CART_ITEM + cartID, parameter: obj, Target: self.view, showLoader: true, completionResponse: { (response) in
               
               if let responseData = response as? NSDictionary
               {
                   let code = responseData.value(forKey: "code") as? Int ?? 0
                   let msg = responseData.value(forKey: "message") as? String ?? "success"
                   
                   if (code == 200)
                   {
                       self.view.AlertMessageWithOkAction(titleStr: kAppName, messageStr: msg, Target: self.view)
                       {
                        self.delegate.Show(msg: msg)
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
    
}

//MARK:- HomeDelegate
extension DetailVC : DetailDelegate
{
    func Show(msg: String)
    {
        getDetail()
    }
    
    func didError(error: String) {
    }
    
    
}

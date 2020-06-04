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
    func getData (subcats : [Body16])
    func nothingFound()
}

class FavoriteViewModel
{
    typealias successHandler = (FavoriteListModel) -> Void
    typealias addFavoriteSuccess = (AddFavoriteModel) -> Void
    var delegate : FavoriteDelegate
    var view : UIViewController
    var isSearching : Bool?
    
    init(Delegate : FavoriteDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }
    
    func getFavList()
    {
        let urls = APIAddress.GET_FAVORITES
        WebService.Shared.GetApi(url: urls, Target: self.view, showLoader: false, completionResponse:
            { (response) in
                
                do
                {
                    let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                    let model = try JSONDecoder().decode(FavoriteListModel.self, from: jsonData)
                    self.delegate.getData(subcats: model.body)
                }
                catch
                {
                 //   self.delegate.nothingFound()
                    self.view.showAlertMessage(titleStr: kAppName, messageStr: kResponseNotCorrect)
                }
        })
        { (err) in
            
            self.delegate.nothingFound()
            // self.view.showAlertMessage(titleStr: kAppName, messageStr: err)
        }
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
    
}

//MARK:- FavoriteProductVCDelegate
extension FavoriteProductVC : FavoriteDelegate
{
    func getData(subcats: [Body16]) {
        DispatchQueue.main.async
            {
                if (subcats.count > 0)
                {
                    self.apiData = subcats
                    
                    self.collectionView.setEmptyMessage("")
                    self.collectionView.reloadData()
                }
                else
                {
                    self.nothingFound()
                }
        }
    }
    
    func Show(msg: String) {
    }
    
    func nothingFound()
    {
        self.apiData.removeAll()
        self.collectionView.setEmptyMessage("Favorites not available!")
        self.collectionView.reloadData()
    }
    
    
}

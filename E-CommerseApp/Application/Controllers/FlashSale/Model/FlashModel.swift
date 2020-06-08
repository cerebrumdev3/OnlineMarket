//
//  FlashModel.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 27/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation

// MARK: - FlashModel
struct FlashModel
{
    let code: Int?
    let message: String?
    let body: Body1?
    
    init(dict: [String:Any])
    {
        self.code = dict["code"] as? Int
        self.message = dict["message"] as? String
        let bodatdata = dict["body"] as? [String:Any]
        self.body = Body1.init(dict: bodatdata!)
        
    }
}

// MARK: - Body
struct Body1{
    // let services, sales: [String]?
    var services = [Service1]()
    var sales = [Sale1]()
    let filters: Filters?

    let currency: String?
    
    init(dict: [String:Any])
    {
        let bodatdata = dict["filters"] as? [String:Any]
        self.filters = Filters.init(dict: bodatdata!)
        self.currency = dict["currency"] as? String
        if let arrCategories = dict["services"] as? [[String:Any]]{
            self.services.removeAll()
            _ = arrCategories.map({ (dict) in
                let model = Service1.init(dict: dict)
                self.services.append(model)
            })
        }
        
        if let arrCategories = dict["sales"] as? [[String:Any]]{
                   self.sales.removeAll()
                   _ = arrCategories.map({ (dict) in
                       let model = Sale1.init(dict: dict)
                       self.sales.append(model)
                   })
               }
        
    }
}

// MARK: - Filters
struct Filters{
    
    var categories = [FiltersCategory]()
    var brands =  [Brand]()
    init(dict: [String:Any])
    {
        if let arrCategories = dict["categories"] as? [[String:Any]]{
            self.categories.removeAll()
            _ = arrCategories.map({ (dict) in
                let model = FiltersCategory.init(dict: dict)
                self.categories.append(model)
            })
        }
        if let arrBrand = dict["brands"] as? [[String:Any]]{
            self.brands.removeAll()
            _ = arrBrand.map({ (dict) in
                let model = Brand.init(dict: dict)
                self.brands.append(model)
            })
        }
    }
    
}

struct Brand{
    let id, companyName: String?
    var categories = [BrandCategory]()
    
    init(dict: [String:Any])
    {
        self.companyName = dict["companyName"] as? String
        self.id = dict["id"] as? String
        
        if let arrGroupMember = dict["categories"] as? [[String:Any]]{
            self.categories.removeAll()
            _ = arrGroupMember.map({ (dict) in
                let model = BrandCategory.init(id: dict["id"] as? String, isSelected: dict["isSelected"] as? Bool)
                self.categories.append(model)
            })
        }
    }
}

struct BrandCategory{
    let id: String?
    var isSelected = false
    init(id:String?,isSelected:Bool?) {
        self.id  = id
        self.isSelected = isSelected ?? false
        
    }
}





// MARK: - FiltersCategory
struct FiltersCategory {
    let icon, thumbnail: String?
    let id, name: String?
    let description: String?
    var isSelected = false
    let maxPriceRange :Int?
    let minPriceRange :Int?
    
    init(dict: [String:Any])
    {
        self.icon = dict["icon"] as? String
        self.thumbnail = dict["thumbnail"] as? String
        self.id = dict["id"] as? String
        self.name = dict["name"] as? String
        self.description = dict["description"] as? String
        self.isSelected = dict["isSelected"] as? Bool ?? false
        self.maxPriceRange = dict["maxPriceRange"] as? Int
        self.minPriceRange = dict["minPriceRange"] as? Int
    }
}

// MARK: - Sale
struct Sale1{
    var icon, thumbnail: String?
    var id, name: String?
    let offer: Int?
    let validUpto: String?
    let category: FiltersCategory?
    //  let favourite: JSONNull?
    var productSpecifications = [ProductSpecification1]()
    
    init(dict: [String:Any])
    {
        self.icon = dict["icon"] as? String
        self.thumbnail = dict["thumbnail"] as? String
        self.id = dict["id"] as? String
        self.name = dict["name"] as? String
        self.offer = dict["offer"] as? Int
        self.validUpto = dict["validUpto"] as? String
        let bodatdata = dict["category"] as? [String:Any]
        self.category = FiltersCategory.init(dict: bodatdata!)
        
       
        
        if let productSpecifications = dict["productSpecifications"] as? [[String:Any]]{
            self.productSpecifications.removeAll()
            _ = productSpecifications.map({ (dict) in
                let model = ProductSpecification1.init(dict:dict)
                self.productSpecifications.append(model)
            })
        }
    }
    
}

// MARK: - ProductSpecification
struct ProductSpecification1 {
    var productImages = [String]()
    let id, productColor: String?
  //  let stockQunatity :String?
    
    init(dict: [String:Any])
    {
        self.productColor = dict["productColor"] as? String
       // self.stockQunatity = dict["stockQunatity"] as? String
        self.id = dict["id"] as? String
        if let arrGroupMember = dict["productImages"] as? [[String]]{
            self.productImages.removeAll()
            let model = arrGroupMember.map({ (dict) in
                // let model = ProductSpecification.init(dict:dict)
            //    self.productImages.append(model)
            })
        }
        
    }
}

// MARK: - Service
struct Service1 {
    let icon, thumbnail: String?
    let originalPrice, price, id, name: String?
    let description, type: String?
    let offer, createdAt: Int?
    let validUpto: String?
    let category: FiltersCategory?
    let favourite: String?
    var productSpecifications = [ProductSpecification1]()
    let cart: String?
    let rating: Int?
    
    init(dict: [String:Any])
    {
        self.icon = dict["icon"] as? String
        self.thumbnail = dict["thumbnail"] as? String
        self.id = dict["id"] as? String
        self.name = dict["name"] as? String
        self.originalPrice = dict["originalPrice"] as? String
        self.price = dict["price"] as? String
        self.offer = dict["offer"] as? Int
        self.createdAt = dict["createdAt"] as? Int
        self.validUpto = dict["validUpto"] as? String
        self.favourite = dict["favourite"] as? String
        self.cart = dict["cart"] as? String
        self.rating = dict["rating"] as? Int
        let bodatdata = dict["category"] as? [String:Any]
        self.category = FiltersCategory.init(dict: bodatdata!)
        self.description = dict["description"] as? String
        self.type = dict["type"] as? String
        
        if let arrGroupMember = dict["productSpecifications"] as? [[String:Any]]{
            self.productSpecifications.removeAll()
            _ = arrGroupMember.map({ (dict) in
                let model = ProductSpecification1.init(dict:dict)
                self.productSpecifications.append(model)
            })
        }
        
    }
}

struct RatingCategory{
    let name: String?
    var isSelected = false
    init(name:String?,isSelected:Bool?) {
        self.name  = name
        self.isSelected = isSelected ?? false
        
    }
}

struct SortByCategory{
    let name: String?
    let orderby : String?
    let orderType :String?
    var isSelected = false
    init(name:String?,isSelected:Bool?,orderby:String?,orderType:String?) {
        self.name  = name
        self.orderby = orderby
        self.orderType = orderType
        self.isSelected = isSelected ?? false
        
    }
}

struct SelectedSortByCategory{
    let orderby : String?
    let orderType :String?
   
    init(orderby:String?,orderType:String?) {
        self.orderby = orderby
        self.orderType = orderType
    }
}

struct SelectedBrand
{
  let id, companyName: String?
  var isSelected = false
    
    init(id:String?,companyName:String?,isSelected:Bool?) {
           self.id = id
           self.companyName = companyName
           self.isSelected = isSelected ?? false
       }
}

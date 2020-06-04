//
//  DetailModel.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 29/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation

// MARK: - DetailModel
struct DetailModel: Codable {
    let code: Int?
    let message: String?
    let body: Body12?
}

// MARK: - Body
struct Body12: Codable {
    let icon, thumbnail: String?
    let originalPrice, price, id, name: String?
    let bodyDescription, type: String?
    let offer: Int?
    let companyID, categoryID, favourite: String?
    let productSpecifications: [ProductSpecification12]?
    let company: Company?
    let category: BodyCategory?
    let rating: Int?
    let currency: String?
    let recommended: [Recommended1]?
    let estimatDelivery, shipment: String?
    let cart: Cart?
    let ratings: Ratings?
   
    
}
// MARK: - Cart
struct Cart: Codable {
    let id, serviceId, color, size: String?
    let quantity, addressId: String?
 
}
// MARK: - Ratings
struct Ratings: Codable {
    let reviewImages, rating, review: String?
    let createdAt: Int?
    let user: User?
}

// MARK: - User
struct User: Codable {
    let image: String?
    let id, firstName, lastName: String?
}
// MARK: - BodyCategory
struct BodyCategory: Codable {
    let icon, thumbnail: String?
    let id, name: String?
}

// MARK: - Company
struct Company: Codable {
    let logo1: String?
    let id, companyName, address1LatLong: String?
    let document: Document?
}

// MARK: - Document
struct Document: Codable {
    let aboutus: String?
}

// MARK: - ProductSpecification
struct ProductSpecification12: Codable {
    let productImages: [String]?
    let stockQunatity: [StockQunatity]?
    let id, productColor: String?
}

// MARK: - StockQunatity
struct StockQunatity: Codable {
    let id: Int?
    let size, stock: String?
}

// MARK: - Recommended
struct Recommended1: Codable {
    let icon, thumbnail: String?
    let originalPrice, price, id, name: String?
    let recommendedDescription, categoryID: String?
    let offer: Int?
    let category: RecommendedCategory1?
    let rating: Int?
    
}

// MARK: - RecommendedCategory
struct RecommendedCategory1: Codable {
    let name, id: String?
}


// MARK: - ProductSpecification
struct ProductSpecification11
{
    let id, productColor: String?
    var isColorSelected = false
    
    init(id:String?,productColor:String?,isColorSelected:Bool?){
        self.id = id
        self.productColor = productColor
        self.isColorSelected = isColorSelected ?? false
    }
}

// MARK: - StockQunatity
struct StockQunatity11: Codable {
    let id: Int?
    let size, stock: String?
    var isSizeSelected = false
    
    init(id:Int?,size:String?,stock:String?,isSizeSelected:Bool?){
        self.id = id
        self.size = size
        self.stock = stock
        self.isSizeSelected = isSizeSelected ?? false
    }
}

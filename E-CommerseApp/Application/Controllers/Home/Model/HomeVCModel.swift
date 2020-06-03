//
//  HomeVCModel.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 26/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation

// MARK: - HomeModel
struct HomeVCModel: Codable
{
    let code: Int?
    let message: String?
        let body: Body?
    
}

// MARK: - Body
struct Body: Codable {
    let recommended: [Recommended]?
    let sales: [Sale]?
    let categories: [CategoryElement]?
   
}

// MARK: - CategoryElement
struct CategoryElement: Codable {
    let icon, thumbnail: String?
    let id, name, categoryDescription: String?

}

// MARK: - Recommended
struct Recommended: Codable {
      let icon, thumbnail: String?
      let originalPrice, price, id, name: String?
      let recommendedDescription, categoryID: String?
      let offer: Int?
      let category: RecommendedCategory?
      let rating: Int?


}

// MARK: - RecommendedCategory
struct RecommendedCategory: Codable {
    let name, id: String?
}

// MARK: - Sale
struct Sale: Codable {
    let icon, thumbnail: String?
    let id, name, price, validUpto: String?
    let originalPrice: String?
    let offer: Int?
  //  let favourites: String?
    let productSpecifications: [ProductSpecification]?
    let cart, favourite: String?
    let rating: Int?
   
}

// MARK: - ProductSpecification
struct ProductSpecification: Codable {
 
    let productImages: [String]?
      let stockQunatity: [StockQunatity1]?
      let id, productColor: String?
}


// MARK: - StockQunatity
struct StockQunatity1: Codable {
    let id: Int?
    let size, stock: String?
}

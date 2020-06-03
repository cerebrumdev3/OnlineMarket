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
    let cart: [String]?
    let category: BodyCategory?
    let rating: Int?
    let currency: String?
    let recommended: [Recommended1]?
    let estimatDelivery, shipment: String?
    
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


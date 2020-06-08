//
//  FavoriteModel.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 28/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//


import Foundation

struct FavoriteListModel: Decodable
{
        let code: Int?
        let message: String?
        let body: [Body16]
    }

    // MARK: - Body
    struct Body16: Codable {
        let id, serviceId, companyId, userId: String?
        let createdAt, updatedAt: Int?
        let product: Product?
        let cartCategoryType, cartCategoryCompany: String?
        let rating: Int?
         }

    // MARK: - Product
    struct Product: Codable {
        let icon, thumbnail: String?
        let originalPrice, price, id, name: String?
        let productDescription, offerName: String?
        let offer, createdAt, status: Int?
        let category: Category?
        let productSpecifications: [ProductSpecification]?
    }

    // MARK: - Category
    struct Category: Codable {
        let id, name, companyId: String

    }
   

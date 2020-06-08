//
//  CartListModel.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 4/1/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation

struct CartListModel: Decodable
{
    let code: Int?
        let message: String?
        let body: Body21?
    }

    // MARK: - Body
    struct Body21: Codable {
        let sum, serviceCharges, totalQunatity: Int?
        let data: [Datum21]?
    }

    // MARK: - Datum
    struct Datum21: Codable {
        let id, serviceId, addressId, color: String?
        let size, orderPrice, quantity: String?
        let serviceCharges: Int?
        let orderTotalPrice, promoCode, companyId, userId: String?
        let createdAt, updatedAt: Int?
        let product: Product1?
    }

    // MARK: - Product
    struct Product1: Codable {
        let icon, thumbnail: String?
        let originalPrice, price, id, name: String?
        let productDescription: String?
        let offer: Int?
        let offerName: String?
        let createdAt, status: Int?
        let productSpecifications: [ProductSpecification]?
    }

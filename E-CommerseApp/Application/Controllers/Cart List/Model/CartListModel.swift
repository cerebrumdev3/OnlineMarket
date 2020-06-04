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
    var code: Int?
    var message : String?
    var body :  BodyDec
}

// MARK: - Body
struct BodyDec: Decodable
{
    let sum, totalQunatity: Int
    let data: [CartListResult]
}

struct CartListResult: Decodable
{
    let id, serviceID, orderPrice, quantity: String
    let orderTotalPrice, promoCode, companyID, userID: String
    let createdAt, updatedAt: Int
    let service: ServiceDEC

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "serviceId"
        case orderPrice, quantity, orderTotalPrice, promoCode
        case companyID = "companyId"
        case userID = "userId"
        case createdAt, updatedAt, service
    }
}


// MARK: - Service
struct ServiceDEC: Decodable
{
    let icon, thumbnail: String
    let id, name, serviceDescription, price: String
    let type, duration, turnaroundTime, includedServices: String
    let excludedServices: String
    let createdAt, status: Int

    enum CodingKeys: String, CodingKey {
        case icon, thumbnail, id, name
        case serviceDescription = "description"
        case price, type, duration, turnaroundTime, includedServices, excludedServices, createdAt, status
    }
}


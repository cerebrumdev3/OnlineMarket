//
//  CategoryModel.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 01/06/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation

// MARK: - CategoryModel
struct CategoryModel: Codable {
    let code: Int?
    let message: String?
    let body: Body13?
}

// MARK: - Body
struct Body13: Codable {
    let banners: [String]?
    let services: [Service]?
    let cartCategoryType, cartCategoryCompany, aboutUsLink, privacyLink: String?
    let termsLink, currency: String?
}

// MARK: - Service
struct Service: Codable {
    let icon, thumbnail: String?
    let id, name, colorCode: String?
}

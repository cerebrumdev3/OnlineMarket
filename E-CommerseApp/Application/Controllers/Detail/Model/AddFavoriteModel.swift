//
//  AddFavoriteModel.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 04/06/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation

struct AddFavoriteModel: Codable {
    let code: Int?
    let message: String?
    let body: Body11?
}

// MARK: - Body
struct Body11: Codable {
    let id, createdAt, updatedAt, serviceID: String?
    let userID, companyID: String?

}

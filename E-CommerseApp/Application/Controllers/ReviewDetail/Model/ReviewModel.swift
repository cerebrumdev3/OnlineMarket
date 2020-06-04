//
//  ReviewModel.swift
//  E-CommerseApp
//
//  Created by Navaldeep Kaur on 28/05/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import Foundation

// MARK: - ReviewModel
struct ReviewListModel: Codable
{
        let code: Int?
        let message: String?
        let body: Body14?
    }

    // MARK: - Body
    struct Body14: Codable {
        let avgRating: Int?
        let data: [Datum]?
    }

    // MARK: - Datum
    struct Datum: Codable {
        let reviewImages: [String]?
        let id, rating, review, createdAt: String?
        let user: User14?
    }

    // MARK: - User
    struct User14: Codable {
        let image: String?
        let id, firstName, lastName: String?
    }

//RatingFilter
struct RatingFilter{
    var rate :String?
    var isSelected = false
    
    init(rate:String?,isSelected:Bool?){
        self.rate = rate
        self.isSelected = isSelected ?? false
    }
}

//
//  FAQ Model.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 5/21/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation
struct FAQResponseModel: Decodable
{
    var code: Int?
    var message : String?
    var body :  [FAQResult]
}

struct FAQResult: Decodable
{
    let id, question, answer: String?
    let status: Int?
    let language: String?
}

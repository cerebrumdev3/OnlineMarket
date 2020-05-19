//
//  SignInVCModel.swift
//  Fleet Management
//
//  Created by Mohit Sharma on 2/20/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation
import ObjectMapper


struct SignIn_ResponseModel: Decodable
{
    var code: Int?
    var message : String?
    var body :  data1?
}

struct data1: Decodable
{
    var id : String?
    var companyID : String?
    var firstName :String?
    var lastName :String?
    var email :String?
    var phoneNumber :String?
    var countryCode :String?
    var password :String?
    var address :String?
    var image :String?
    var deviceToken : String?
    var userType : String?
    var sessionToken : String?
    var moduleType : String?
    var platform : String?
     var status : Int?
   // var createdAt : Int?
   // var updatedAt : Int?
   // var isAddressAdded : String?
}



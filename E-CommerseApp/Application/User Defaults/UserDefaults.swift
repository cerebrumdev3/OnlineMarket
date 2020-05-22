//
//  Extensions.swift
//  Hark
//
//  Created by MAC-4 on 05/03/19.
//  Copyright © 2019 KBS. All rights reserved.
//

import UIKit
import SystemConfiguration


class AppDefaults: NSObject
{
    static let shared = AppDefaults()
    
    
    //MARK: USERID
    var userID: String
    {
        get
        {
            let user_Id =  UserDefaults.standard.string(forKey: defaultKeys.userID) ?? "0"
            return user_Id
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: defaultKeys.userID)
            UserDefaults.standard.synchronize()
        }
    }
    
   
    
    //MARK: USERNAME
    var userName: String
    {
        get
        {
            if let user_Name =  UserDefaults.standard.string(forKey: defaultKeys.userName)
            {
                return user_Name
            }
            else
            {
                return ""
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: defaultKeys.userName)
            UserDefaults.standard.synchronize()
        }
    }
    
    //MARK: USERNAME
    var userFirstName: String
    {
        get
        {
            if let user_Name =  UserDefaults.standard.string(forKey: defaultKeys.userFirstName)
            {
                return user_Name
            }
            else
            {
                return ""
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: defaultKeys.userFirstName)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    
    //MARK: LASTNAME
    var userLastName: String
    {
        get
        {
            if let user_Name =  UserDefaults.standard.string(forKey: defaultKeys.userLastName)
            {
                return user_Name
            }
            else
            {
                return ""
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: defaultKeys.userLastName)
            UserDefaults.standard.synchronize()
        }
    }
    
    //MARK: USER IMAGE
    var userImage: String
    {
        get
        {
            if let userProfile_Image =  UserDefaults.standard.string(forKey: defaultKeys.userImage)
            {
                return userProfile_Image
            }
            else
            {
                return ""
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: defaultKeys.userImage)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    //MARK: USER Email
    var userEmail: String
    {
        get
        {
            if let userProfile_Image =  UserDefaults.standard.string(forKey: defaultKeys.userEmail)
            {
                return userProfile_Image
            }
            else
            {
                return ""
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: defaultKeys.userEmail)
            UserDefaults.standard.synchronize()
        }
    }
    
    //MARK: USER DEVICE TOKEN
    var userDeviceToken: String
    {
        get
        {
            if let userProfile_Image =  UserDefaults.standard.string(forKey: defaultKeys.userDeviceToken)
            {
                return userProfile_Image
            }
            else
            {
                return ""
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: defaultKeys.userDeviceToken)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    //MARK: USER AUTH TOKEN
    var userJWT_Token: String
    {
        get
        {
            if let userProfile_Image =  UserDefaults.standard.string(forKey: defaultKeys.userJWT_Token)
            {
                return userProfile_Image
            }
            else
            {
                return ""
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: defaultKeys.userJWT_Token)
            UserDefaults.standard.synchronize()
        }
    }
    
    //MARK: Firebase VerifcationID
    var firebaseVID: String
    {
        get
        {
            if let firebaseVID =  UserDefaults.standard.string(forKey: defaultKeys.firebaseVID)
            {
                return firebaseVID
            }
            else
            {
                return ""
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: defaultKeys.firebaseVID)
            UserDefaults.standard.synchronize()
        }
    }
    
    //MARK: Firebase VerifcationID
    var firebaseToken: String
    {
        get
        {
            if let firebaseToken =  UserDefaults.standard.string(forKey: defaultKeys.firebaseToken)
            {
                return firebaseToken
            }
            else
            {
                return ""
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: defaultKeys.firebaseToken)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    //MARK: USER Phone Number
    var userPhoneNumber: String
    {
        get
        {
            if let nbr =  UserDefaults.standard.string(forKey: defaultKeys.userPhoneNumber)
            {
                return nbr
            }
            else
            {
                return ""
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: defaultKeys.userPhoneNumber)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    //MARK: USER COUNTRY CODE
    var userCountryCode: String
    {
        get
        {
            if let userDOB =  UserDefaults.standard.string(forKey: defaultKeys.userCountryCode)
            {
                return userDOB
            }
            else
            {
                return ""
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: defaultKeys.userCountryCode)
            UserDefaults.standard.synchronize()
        }
    }
    
    //MARK: USER HOME ADDRESS
    var userHomeAddress: String
    {
        get
        {
            if let userHomeAddress =  UserDefaults.standard.string(forKey: defaultKeys.userHomeAddress)
            {
                return userHomeAddress
            }
            else
            {
                return ""
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: defaultKeys.userHomeAddress)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    
    var app_LATITUDE: String
    {
        get
        {
            if let my_drop_LAT =  UserDefaults.standard.string(forKey: "app_LATITUDE")
            {
                return my_drop_LAT
            }
            else
            {
                return "0.0"
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: "app_LATITUDE")
            UserDefaults.standard.synchronize()
        }
    }
    
    var app_LONGITUDE: String
    {
        get
        {
            if let my_drop_LONG =  UserDefaults.standard.string(forKey: "app_LONGITUDE")
            {
                return my_drop_LONG
            }
            else
            {
                return "0.0"
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: "app_LONGITUDE")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    var categoryTheme: UIColor
    {
        get
        {
            if let categoryTheme =  UserDefaults.standard.colorForKey(key: "categoryTheme")
            {
                return categoryTheme
            }
            else
            {
                return UIColor.init(red: 255.0/255.0, green: 164.0/255.0, blue: 42.0/255.0, alpha: 1.0)
            }
        }
        set
        {
            UserDefaults.standard.setColor(color: newValue, forKey: "categoryTheme")
            UserDefaults.standard.synchronize()
        }
    }
    
    var currency: String
    {
        get
        {
            if let currency =  UserDefaults.standard.string(forKey: "currency")
            {
                return currency
            }
            else
            {
                return "Rs."
            }
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: "currency")
            UserDefaults.standard.synchronize()
        }
    }
    
    
}


extension UserDefaults
{
    func colorForKey(key: String) -> UIColor?
    {
        var color: UIColor?
        if let colorData = data(forKey: key)
        {
            color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
        }
        return color
    }
    
    func setColor(color: UIColor?, forKey key: String)
    {
        var colorData: NSData?
        if let color = color
        {
            colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
        }
        set(colorData, forKey: key)
    }
    
}



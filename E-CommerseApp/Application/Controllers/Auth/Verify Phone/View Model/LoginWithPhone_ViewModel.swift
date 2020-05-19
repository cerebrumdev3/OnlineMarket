//
//  LoginWithPhone_ViewModel.swift
//  Fleet Management
//
//  Created by Mohit Sharma on 2/20/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseAuth
import Firebase



class LoginWithPhone_ViewModel
{
    var view : UIViewController
    var phnNumber = ""
    var cntryCode = ""
    
    init(view : UIViewController)
    {
        self.view = view
    }
    
    func SignIn(phoneNumber:String,countryCode:String)
    {
        //25cbf58b-46ba-4ba2-b25d-8f8f653e9f11
        self.phnNumber = phoneNumber
        self.cntryCode = countryCode
        let obj : [String:Any] = ["phoneNumber":phoneNumber,"countryCode":countryCode,"deviceToken" :AppDefaults.shared.firebaseToken,"platform" :"ios","companyId":"25cbf58b-46ba-4ba2-b25d-8f8f653e9f11"]
        
        
        
        
        WebService.Shared.PostApi(url: APIAddress.LOGIN, parameter: obj , Target: self.view, completionResponse: { response in
            Commands.println(object: response)
            
            do
            {
                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let model = try JSONDecoder().decode(SignIn_ResponseModel.self, from: jsonData)
                
                print(model.body?.firstName as Any)
                if (model.code == 200)
                {
                   // self.get_otp_from_firebase(phoneNumber:countryCode+phoneNumber, userData: model)
                    self.setRoot(userData:model)
                }
                else
                {
                    self.view.showAlertMessage(titleStr: kAppName, messageStr: kUserNotRegistered)
                }
                
            }
            catch
            {
                self.view.showAlertMessage(titleStr: kAppName, messageStr: kResponseNotCorrect)
            }
            
        }, completionnilResponse: {(error) in
            
            if (error == "Phone Number does not exist")
            {
                // self.get_otp_from_firebase(phoneNumber:countryCode+phoneNumber, userData: nil)
                self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
            }
            else
            {
                self.view.showAlertMessage(titleStr: kAppName, messageStr: error)
            }
            
        })
        
    }
    
    
    func get_otp_from_firebase(phoneNumber:String,userData:SignIn_ResponseModel?)
    {
        FirbaseOTPAuth.get_otp_from_firebase(controller: self.view, phoneNumber: phoneNumber) { (result) in
            if (result.count > 0)
            {
                AppDefaults.shared.firebaseVID = result
                //go to otp screen
                let controller = Navigation.GetInstance(of: .CheckOTPVC) as! CheckOTPVC
                controller.phoneNumber = self.phnNumber
                controller.countryCode = self.cntryCode
                controller.push_approach = kPush_Approach_from_SignUp
                controller.userData = userData!
                self.view.push_To_Controller(from_controller: self.view, to_Controller: controller)
            }
            
        }
    }
    
    func setRoot(userData:SignIn_ResponseModel!)
    {
        Commands.println(object: userData as Any)
        AppDefaults.shared.userName = (userData?.body?.firstName ?? "") + (userData?.body?.lastName ?? "")
        AppDefaults.shared.userFirstName = userData?.body?.firstName ?? ""
        AppDefaults.shared.userLastName = userData?.body?.lastName ?? ""
        AppDefaults.shared.userJWT_Token = userData?.body?.sessionToken ?? ""
        AppDefaults.shared.userEmail = userData?.body?.email ?? ""
        AppDefaults.shared.userPhoneNumber = userData?.body?.phoneNumber ?? ""
        AppDefaults.shared.userCountryCode = userData?.body?.countryCode ?? ""
        AppDefaults.shared.userID = userData?.body?.id ?? "0"
        AppDefaults.shared.userImage = userData?.body?.image ?? ""
       // AppDefaults.shared.userAddressAdded = userData?.body?.isAddressAdded ?? ""
        
        configs.kAppdelegate.setRootViewController()
    }
    
}


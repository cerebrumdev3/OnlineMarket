//
//  Enums.swift
//  UnionGoods
//
//  Created by Rakesh Kumar on 11/22/19.
//  Copyright © 2019 Seasia infotech. All rights reserved.
//

import Foundation
import UIKit

class Navigation
{
    enum type
    {
        case root
        case push
        case present
        case pop
    }
    
    enum Controller
    {
        //AUTH
        case CheckOTPVC
        case LoginWithPhoneVC
        case SignUPVC
        case SignInVC
        case ResetPasswordVC
        case ChangePasswdVC
        
        //HOME
        case HomeDashboardVC
        case HomeVC
        case EditProfileVC
        case AddressListVC
        case AddNewAddressVC
        case SideMenuVC
        case SearchVC
        case CategoryVC
        case FlasSaleVC
        case DetailVC
        case ReviewListVC
        case FavoriteProductVC
        case ChooseAddressVC
        
        //Reviews Storyboard
        case WriteReviewVC
        case OrderDetailsVC
        case CartListVC
        case OrderListVC
        
        
        var obj: UIViewController?
        {
            switch self
            {
                
            //AUTH
            case .CheckOTPVC:
                return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "CheckOTPVC")
                
            case .LoginWithPhoneVC:
                return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "LoginWithPhoneVC")
                
            case .SignUPVC:
                return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "SignUPVC")
                
            case .SignInVC:
                return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "SignInVC")
                
            case .ResetPasswordVC:
                return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "ResetPasswordVC")
                
            case .ChangePasswdVC:
                return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "ChangePasswdVC")
                
            case .EditProfileVC:
                return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "EditProfileVC")
                
                
            //HOME
            case .HomeDashboardVC:
                return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "HomeDashboardVC")
            case .HomeVC:
                return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "HomeVC")
            case .AddressListVC:
                return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "AddressListVC")
            case .AddNewAddressVC:
                return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "AddNewAddressVC")
            case .SideMenuVC:
                return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "SideMenuVC")
                
                
            case .SearchVC:
                  return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "SearchVC")
                              
            case .CategoryVC:
                  return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "CategoryVC")
            case .FlasSaleVC:
                 return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "FlasSaleVC")
            case .DetailVC:
                  return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "DetailVC")
            case .ReviewListVC:
                return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "ReviewListVC")
            case .FavoriteProductVC:
                  return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "FavoriteProductVC")
            case .ChooseAddressVC:
                 return StoryBoards.Home.obj?.instantiateViewController(withIdentifier: "ChooseAddressVC")
                
            //Reviews Storyboard
            case .WriteReviewVC:
                return StoryBoards.Reviews.obj?.instantiateViewController(withIdentifier: "WriteReviewVC")
            case .OrderDetailsVC:
                return StoryBoards.Reviews.obj?.instantiateViewController(withIdentifier: "OrderDetailsVC")
            case .CartListVC:
                return StoryBoards.Reviews.obj?.instantiateViewController(withIdentifier: "CartListVC")
            case .OrderListVC:
                return StoryBoards.Reviews.obj?.instantiateViewController(withIdentifier: "OrderListVC")
                
            }
        }
    }
    enum StoryBoards
    {
        case Main
        case Home
        case Reviews
        
        var obj: UIStoryboard?
        {
            switch self
            {
            case .Main:
                return UIStoryboard(name: "Main", bundle: nil)
            case .Home:
                return UIStoryboard(name: "Home", bundle: nil)
            case .Reviews:
                return UIStoryboard(name: "Reviews", bundle: nil)
                
            }
        }
        
    }
    
    static func GetInstance(of controller : Controller) -> UIViewController
    {
        return controller.obj!
    }
    
}


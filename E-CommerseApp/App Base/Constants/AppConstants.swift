//
//  AppConstants.swift
//  Cabbies
//
//  Created by Techwin Labs on 03/04/19.
//  Copyright © 2019 Techwin Labs. All rights reserved.
//
//
import Foundation
import UIKit

let KDone                                           =         "Done"
let KChooseImage                                    =         "Choose Image"
let KChooseVideo                                    =         "Choose Video"
let KCamera                                         =         "Camera"
let KGallery                                        =         "Gallery"
let KYoudonthavecamera                              =         "You don't have camera"
let KSettings                                       =         "Settings"


//MARK: RAZORPAY KEYS

let RAZORPAY_KEY_ID = "rzp_test_oCGcDMHUvhIopO"
let RAZORPAY_KEY_SECRET = "h66PjdxgCVhxhbeNxWahYUmf"



@available(iOS 13.0, *)
let KappDelegate                                    =        UIApplication.shared.delegate as! AppDelegate
let KOpenSettingForPhotos                           =         "App does not have access to your photos. To enable access, tap Settings and turn on Photos."
let KOpenSettingForCamera                           =         "App does not have access to your camera. To enable access, tap Settings and turn on Camera."
let KOK                                             =         "OK"
let KCancel                                         =       "Cancel"
let KYes                                              =       "Yes"
let KNo                                         =       "No"

let KOngoing                                         =       "Ongoing"
let KCompleted                                         =       "Completed"

let GoogleAPIKey = "AIzaSyC9XlPw-l_lY4ga__R5daHFQ8Aj4c8gqOU"


//MARK:- iDevice detection code
struct Device_type
{
    static let IS_IPAD             = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE           = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_RETINA           = UIScreen.main.scale >= 2.0
    
    static let SCREEN_WIDTH        = Int(UIScreen.main.bounds.size.width)
    static let SCREEN_HEIGHT       = Int(UIScreen.main.bounds.size.height)
    static let SCREEN_MAX_LENGTH   = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
    static let SCREEN_MIN_LENGTH   = Int( min(SCREEN_WIDTH, SCREEN_HEIGHT) )
    
    static let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH  < 568
    static let IS_IPHONE_5         = IS_IPHONE && SCREEN_MAX_LENGTH == 568
    static let IS_IPHONE_6         = IS_IPHONE && SCREEN_MAX_LENGTH == 667
    static let IS_IPHONE_6P        = IS_IPHONE && SCREEN_MAX_LENGTH == 736
    static let IS_IPHONE_X         = IS_IPHONE && SCREEN_MAX_LENGTH >= 812
}

//MARK : STATIC TEXT
let kAppName = ""
let kLoading = ""
let kVerifying = ""
let kLoading_Getting_OTP = ""
let kDone = "Done"
let kSaved = "Saved"
let kError = "Error"
let kDataNotFound = "Data not found!"
let kDataNothingTOSHOW = "Sorry nothing to show!"
let kStoryBoard_Main = "Main"
let kResponseNotCorrect = "Data isn't in correct form!"
let kUserNotRegistered = "User is not registered yet!"
let kSomthingWrong = "Something went wrong, please try again!"
let kDataSavedInDatabase = "Data saved successfully in database"
let kDatabaseSuccess = "Database Success"
let kDatabaseFailure = "Database Failure"
let kDrift_ClientID = "LKPHJGMiuHYoUA9rs0qOWLiZf2MLXINw"
let kDrift_ClientSecret = "TWGqKCbMSHvqhoo62SokyIBN3mZC2Irc"
let kDrift_ClientToken = "dvaacsihrwad"
let KHexColor = "#FF7A00"

//Alert Images for Toast
let KSignalY = "signal"
let KSignalR = "signalRed"



//MARK: DEFAULT IMAGES
let kplaceholderProfile = "dummy_user"
let kplaceholderImage = "defaultImage"
 let KDefaultIcon = "backGroundIcon"
 let kNoImage = "noImageIcon"

let kPush_Approach_from_ForgotPassword = "coming_from_forgotPassword"
let kPush_Approach_from_SignUp = "coming_from_signup"

//MARK : KEYS FOR STORE DATA

struct defaultKeys
{
    static let serviceType = "serviceType"
    static let userID = "userID"
    static let userName = "userName"
    static let userFirstName = "userFirstName"
    static let userImage = "userImage"
    static let userEmail = "userEmail"
    static let userDeviceToken = "userDeviceToken"
    static let userJWT_Token = "userJWT_Token"
    static let userPhoneNumber = "userPhoneNumber"
    
    static let userHomeAddress = "userHomeAddress"
    static let userAddressType = "userAddressType"
    static let userAddressID = "userAddressID"
    static let userAddressAdded = "userAddressAdded"
    
    
    
    static let firebaseVID = "firebaseVID"
    static let userTYPE = "userTYPE"
    static let userCountryCode = "userCountryCode"
    static let firebaseToken = "firebaseToken"
    static let userLastName = "userLastName"
}

struct database
{
    
    struct entityJobDetails
    {
        
    }
    
    struct entityJobSavedLocations
    {
        
    }
    
}



struct APIAddress
{
    
   // static let BASE_URL = "http://camonher.infinitywebtechnologies.com:9066/"
    static let BASE_URL = "http://51.79.40.224:9074/"//"http://51.79.40.224:9062/"
   // static let BASE_URL = "http://51.79.40.224:9067/"
   // static let BASE_URL = "http://infinitywebtechnologies.com:9062/"
    
    static let LOGIN = BASE_URL + "api/mobile/auth/login"
    static let UPDATE_PROFILE = BASE_URL + "api/mobile/profile/updateprofile"
    
    static let REGISTER = BASE_URL + "driver/auth/register"
    static let RESET_PASSWORD = BASE_URL + "driver/auth/resetpassword"
    static let CHANGE_PASSWORD = BASE_URL + "driver/auth/changepassword"
    
    
    static let ADD_ADDRESS = BASE_URL + "api/mobile/address/add"
    static let GET_ADDRESS = BASE_URL + "api/mobile/address/list"
    static let UPDATE_ADDRESS = BASE_URL + "api/mobile/address/update"
    static let DELETE_ADDRESS = BASE_URL + "api/mobile/address/delete"
    
    static let GET_HOME_CATEGORIES = BASE_URL + "api/mobile/services/getHome"
    static let getProductAllRating = BASE_URL + "api/mobile/rating/serviceRatings?serviceId="
    static let getProductList = BASE_URL + "api/mobile/services/getServices?category="
    static let getSalesProduct = BASE_URL + "api/mobile/services/getSales"
    static let getProductDetail = BASE_URL + "api/mobile/services/detail?serviceId="
    static let getCategoryList = BASE_URL + "api/mobile/services/getParentCategories"
   // static let GET_HOME_CATEGORIES = BASE_URL + "api/mobile/services/getCategories"
    static let GET_COMPANIES = BASE_URL + "api/mobile/services/getCompanies"
    static let GET_COMPANIES_CATEGORIES = BASE_URL + "api/mobile/services/getSubcat"
    static let GET_HOME_SUBCATEGORIES = BASE_URL + "api/mobile/services/getSubcat"
    static let GET_HOME_SUBCAT_SERVICE = BASE_URL + "api/mobile/services/getServices"
    static let GET_SERVICE_DETAILS = BASE_URL + "api/mobile/services/detail?"
    
    static let ADD_TO_CART = BASE_URL + "api/mobile/cart/add"
    static let GET_CART_LIST = BASE_URL + "api/mobile/cart/list"
    static let DELETE_CART_ITEM = BASE_URL + "api/mobile/cart/remove"
    static let CLEAR_CART_ITEMS = BASE_URL + "api/mobile/cart/clear"
    
    static let GET_PROMOCODES = BASE_URL + "api/mobile/coupan/getPromoList"
    static let ADD_PROMOCODE = BASE_URL + "api/mobile/coupan/applyCoupan"
    static let REMOVE_PROMOCODE = BASE_URL + "api/mobile/coupan/removeCoupan"
    
    static let CREATE_ORDER = BASE_URL + "api/mobile/orders/create"
    static let UPATE_PAYEMENT_STATUS = BASE_URL + "api/mobile/orders/paymentStatus"
    static let GET_ORDER_LIST = BASE_URL + "api/mobile/orders/list?"
    static let CANCEL_ORDER = BASE_URL + "api/mobile/orders/cancel"
    static let GET_ORDER_SERVICES = BASE_URL + "api/mobile/orders/detail"
    static let ORDER_COMPLETE = BASE_URL + "api/mobile/orders/status"
    
    static let GET_NOTIFICATIONS = BASE_URL + "api/mobile/"
    static let CLEAR_NOTIFICATIONS = BASE_URL + "api/mobile/"
    
    
        
    static let GET_FAVORITES = BASE_URL + "api/mobile/favourite/list"
    static let ADD_TO_FAVORITES = BASE_URL + "api/mobile/favourite/add"
    static let REMOVE_FROM_FAVORITES = BASE_URL + "api/mobile/favourite/remove"
    
    static let GET_SLOTS = BASE_URL + "api/mobile/schedule/getSchedule?"
    static let GET_SLOTS_DATES = BASE_URL + "api/mobile/schedule/getSchedule?"
    
    static let GET_RATINGS = BASE_URL + "api/mobile/rating/serviceRatings"
    static let ADD_NEW_RATINGS = BASE_URL + "api/mobile/rating/addRating"
    
    
    static let GetProfile = BASE_URL + "api/mobile/profile/getprofile"
    static let LOGOUT = BASE_URL + "api/mobile/auth/logout"
   
}

let kHeader_app_json = ["Accept" : "application/json"]


enum Parameter_Keys_All : String
{
    
    case deviceToken = "deviceToken"
    case deviceType = "deviceType"
    case voipDeviceToken = "voipDeviceToken"
    case appVersion = "appVersion"
    
    //User LoginProcess Keys signUp keys
    case language = "language"
    case countryCode = "countryCode"
    case phoneNumber = "phoneNumber"
    case otp = "otp"
    case email = "email"
    case signupBy = "signupBy"
    case firstName = "firstName"
    case lastName = "lastName"
    case socialId = "socialId"
    case loginBy = "loginBy"
    
    case password = "password"
    case address = "address"
    case city = "city"
    case country = "country"
    case latitude = "latitude"
    case longitude = "longitude"
    case socialPic = "socialPic"
    case profilePic = "profilePic"
    case emailPhone = "emailPhone"
    case DOB = "DOB"
    case gender = "gender"
    
}

enum Validate : String
{
    
    case none
    case success = "200"
    case failure = "400"
    case invalidAccessToken = "401"
    case fbLogin = "3"
    case fbLoginError = "405"
    
    func map(response message : String?) -> String?
    {
        
        switch self
        {
        case .success : return message
        case .failure :return message
        case .invalidAccessToken :return message
        case .fbLoginError : return Validate.fbLoginError.rawValue
        default :return nil
        }
    }
}



enum configs
{
    static let mainscreen = UIScreen.main.bounds
    static let kAppdelegate = UIApplication.shared.delegate as! AppDelegate
}


struct AlertTitles
{
    static let Ok:String = "OK"
    static let Cancel:String = "CANCEL"
    static let Yes:String = "Yes"
    static let No:String = "No"
    static let Alert:String = "Alert"
    
    static let Internet_not_available = "Please check your internet connection"
    static let Success = "Success"
    static let Error = "Error"
    static let InternalError = "Internal Error"
    static let Enter_UserName = "Please enter username"
    static let Enter_Password = "Please enter password"
    static let Phone_digits_exceeded = "Phone number digists are exceeded, make sure you are entering correct phone number"
    static let Enter_phone_number = "Please enter phone number"
    static let EnterValid_phone_number = "Please enter a valid phone number"
    static let PasswordEmpty = "Password is empty"
    static let EnterNewPassword = "Please enter new password"
    static let PasswordEmpty_OLD = "Old Password is empty"
    static let PasswordLength8 = "Password length should be of 8-20 characters"
    static let Password_ShudHave_SpclCharacter = "Your password should contain one numeric,one special character,one upper and lower case character"
    static let PasswordCnfrmEmpty = "Confirm password is empty"
    static let Passwordmismatch = "New password and confirm password does not match"
    
    
    
    
}


enum DateFormat
{
    
    case dd_MMMM_yyyy
    case dd_MM_yyyy
    case dd_MM_yyyy2
    case yyyy_MM_dd
    case hh_mm_a
    case yyyy_MM_dd_hh_mm_a
    case yyyy_MM_dd_hh_mm_a2
    case dateWithTimeZone
    case dd_MMM_yyyy
    
    func get() -> String
    {
        
        switch self
        {
            
        case .dd_MMMM_yyyy : return "dd MMMM, yyyy"
        case .dd_MM_yyyy : return "dd-MM-yyyy"
        case .dd_MM_yyyy2 : return "dd/MM/yyyy"
        case .yyyy_MM_dd : return "yyyy-MM-dd"
        case .hh_mm_a : return "hh:mm a"
        case .yyyy_MM_dd_hh_mm_a : return  "yyyy-MM-dd hh:mm a"
        case .yyyy_MM_dd_hh_mm_a2 : return  "dd MMM yyyy, hh:mm a"
        case .dateWithTimeZone : return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        case .dd_MMM_yyyy : return "dd MMM yyyy"
            
        }
    }
}

extension String
{
    func capitalizingFirstLetter() -> String
    {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter()
    {
        self = self.capitalizingFirstLetter()
    }
}


struct HomeIdentifiers
{
    static let HomeVC = "HomeDashboardVC"
    static let BannerTableCell = "BannerTableCell"
    static let CategoryTableCell = "CategoryTableCell"
    static let FlashSaleTableCell = "FlashSaleTableCell"
    static let MiddleBannerTableCell = "MiddleBannerTableCell"
    static let BannerCollectionCell = "BannerCollectionCell"
    static let CategoryCollectionCell = "CategoryCollectionCell"
    static let FlashSaleCollectionCell = "FlashSaleCollectionCell"
    static let SubCategoriesListCell = "SubCategoriesListCell"
    static let MiddleBannerCollectionCell = "MiddleBannerCollectionCell"
    static let ProductListTableCell = "ProductListTableCell"
    static let ProductListCollectionCell = "ProductListCollectionCell"
    static let SearchTableCell = "SearchTableCell"
    static let CategoryListCell = "CategoryListCell"
    static let SelectColorTableCell = "SelectColorTableCell"
    static let SpecificationTableCell = "SpecificationTableCell"
    static let ReviewProductTableCell = "ReviewProductTableCell"
    static let SelectSizeCollectionCell = "SelectSizeCollectionCell"
    static let SelectColorCollectionCell = "SelectColorCollectionCell"
    static let ProductImagesCollectionCell = "ProductImagesCollectionCell"
    static let FavoriteCollectionCell = "FavoriteCollectionCell"
    static let FilterAllReviewCell = "FilterAllReviewCell"
    static let FilterRateCollectionCell = "FilterRateCollectionCell"
    static let FilterCollectionCell = "FilterCollectionCell"
    static let FilterTableCell = "FilterTableCell"
    
    //Detail
    static let SelectSizeTableCell = "SelectSizeTableCell" 
    
}



//
//  dynamicText.swift
//  UrbanClap Replica
//
//  Created by Mohit Sharma on 5/12/20.
//  Copyright © 2020 Seasia Infotech. All rights reserved.
//

import UIKit

class DynamicTextHandler: UIViewController
{
    //screen titles
    static var HOMESCREEN_TITLE = "HOME"
    static var COMPNYLIST_TITLE = "SERVICE PROVIDERS"
    static var SERVICELIST_TITLE = "SERVICES"
    static var SERVICDETAIL_TITLE = "SERVICE DETAILS"
    static var ORDERS_TITLE = "ORDERS"
    static var ORDERS_HISTORY_TITLE = "BOOKING HISTORY"
    
    //button add or but for service list
    static var BUYorADD_BUTTON = "ADD"
    static var BUY_AGAIN = "Book again"
    
    //checkout view
    static var CHOOSE_AVAIL_DATE = "Choose service date"
    static var CHOOSE_AVAIL_TIME = "Choose service time"
    
    //service detail screen
    static var ITEM_DURATION_TEXT = "Duration"
    static var INCLUDE_EXCLUDE_ITEMS = "Services"
    static var TURNAROUND_TIME = "Turnaround Time"
    
    //Main category home
    static var HOME_TRENDING_SERVICE = "Trending Services"
    static var HOME_BOOKED_SERVICE = "Most booked sevices in this week"
    
    //order screen
    static var BOOKED_ON = "Booked On"
    static var SERVICE_DATE = "Service Date"
    static var ORDER_TYPE = "Services"
    static var RATE_ITEM = "Service"
    
    
    
    class func restoreData()
    {
        HOMESCREEN_TITLE = "HOME"
        COMPNYLIST_TITLE = "VENDOR LIST"
        SERVICELIST_TITLE = "SERVICES"
        SERVICDETAIL_TITLE = "SERVICE DETAILS"
        ORDERS_TITLE = "ORDERS"
        ORDERS_HISTORY_TITLE = "BOOKING HISTORY"
        
        BUYorADD_BUTTON = "Buy"
        
        CHOOSE_AVAIL_DATE = "Choose delivery date"
        CHOOSE_AVAIL_TIME = "Choose delivery time"
        
        ITEM_DURATION_TEXT = "Duration"
        INCLUDE_EXCLUDE_ITEMS = "Items"
        TURNAROUND_TIME = "Turnaround Time"
        
        HOME_TRENDING_SERVICE = "Trending Services"
        HOME_BOOKED_SERVICE = "Most booked sevices in this week"
        
        BOOKED_ON = "Booked On"
        SERVICE_DATE = "Service Date"
        ORDER_TYPE = "Services"
    }
    
}

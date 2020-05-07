//
//  Constants .swift
//  WholesaleStore
//
//  Created by Abdullah Alsalamah on 05/05/2020.
//  Copyright © 2020 Abdullah Alsalamah. All rights reserved.
//

import Foundation

struct K {
    static let loginSegue = "LoginPage"
    static let orderSegue = "OrderSegue"
    
    static let dpCellIdentifier = "ReusableCell1"
    static let itemCellIdentifier = "ReusableCell2"
    static let dpCellNipName = "deliveryPersonCell"
    static let itemCellNipName = "itemCell"
    
    
    
    struct KDatabase{
        static let newAccumlatedOrders = "new_accumulated_orders"
        static let wssid = "WSSID"
        static let testUser = "test_users"
        static let dateField = "date"
        
        static let deliverPersonidForAccumlatedOrders = "DPID"
        static let deliveryPersonidForTestUser = "id"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let phoneNumber = "mobileNumber"
        
    }
}

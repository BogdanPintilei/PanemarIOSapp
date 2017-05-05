//
//  OrderHistory.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 5/2/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit

class OrderHistory: NSObject {
    static var orderHistory = [Order]()
    static var orderHistoryLengthAtFirstLoad = 0
    
    static var filePath:String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        return url!.appendingPathComponent("Data").path
    }
    
    class func loadData() {
        if let downloadedOrderHistory = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath) as? [Order] {
            OrderHistory.orderHistory = downloadedOrderHistory
        }
    }
}

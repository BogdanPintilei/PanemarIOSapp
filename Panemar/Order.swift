//
//  Order.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 4/14/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit
import Foundation

class Order: NSObject,NSCoding {
    
    struct keys {
        static let id = "id"
        static let date = "date"
        static let total = "total"
        static let status = "status"
    }
    
    private var _id = ""
    private var _date = NSDate()
    private var _total = ""
    private var _status = ""
    
    override init(){}
    
    init(id: String,date: Date,total:String,status:String) {
        _id = id
        _date = date as NSDate
        _total = total
        _status = status
    }
    
    required init?(coder decoder: NSCoder) {
        if let idObject = decoder.decodeObject(forKey: keys.id) as? String {
            _id = idObject
        }
        if let dateObject = decoder.decodeObject(forKey: keys.date) as? Date {
            _date = dateObject as NSDate
        }
        if let totalObject = decoder.decodeObject(forKey: keys.total) as? String {
            _total = totalObject
        }
        if let statusObject = decoder.decodeObject(forKey: keys.status) as? String {
            _status = statusObject
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(_id, forKey: keys.id)
        coder.encode(_date,forKey: keys.date)
        coder.encode(_total,forKey: keys.total)
        coder.encode(_status, forKey: keys.status)
    }
    
    var Id: String {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    
    var Date: Date {
        get {
            return _date as Date
        }
        set {
            _date = newValue as NSDate
        }
    }
    
    var Total: String {
        get {
            return _total
        }
        set {
            _total = newValue
        }
    }
    
    var Status: String {
        get {
            return _status
        }
        set {
            _status = newValue
        }
    }
}

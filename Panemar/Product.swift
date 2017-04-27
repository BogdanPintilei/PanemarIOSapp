//
//  Product.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 4/14/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit

class Product: NSObject {
    
    var productId: Int?
    var productName: String?
    var productInfo: String?
    var productIngredients: String?
    var productPrice: Double?
    var productImageURL: String?
    var cachedImage: UIImage?
    var quantity: Int?
    
    init(id: Int,name: String,info: String,ingredients:String,price:Double,imageURL: String,quantity: Int) {
        self.productId = id
        self.productName = name
        self.productInfo = info
        self.productIngredients = ingredients
        self.productPrice = price
        self.productImageURL = imageURL
        self.quantity = quantity
    }
}

//
//  Cart.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 4/14/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit

class Cart: NSObject {
    static var productsInCart = [Product]()
    
    class func addToCart(product: Product, quantityOfProduct: Int) -> Void {
        var ok = false
        
        /*
         chek if the product for wich new want to add quantity already exists in the cart if not we add it later
        */
        for p in productsInCart {
            if product.productId == p.productId {
                let position = productsInCart.index(of: p)
                productsInCart[position!].quantity = productsInCart[position!].quantity! + quantityOfProduct
                ok = true
            }
        }
        
        /*
         if the product wasn't added before the quantity will be added to the recently appended product
         */
        if ok == false {
            productsInCart.append(product)
            let position = productsInCart.index(of: product)
            productsInCart[position!].quantity! = quantityOfProduct
        }
    }
}

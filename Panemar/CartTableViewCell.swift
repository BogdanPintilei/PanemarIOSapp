//
//  CartTableViewCell.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 4/26/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!

    
    var cartProduct: Product? {didSet { configureWithProduct() } }
    
    private func configureWithProduct() {
        self.productImageView.image = cartProduct?.cachedImage
        productNameLabel?.text = cartProduct?.productName
        //convert the value of the cartProduct.ProductPrice to string
        productPriceLabel?.text = String("\(String(format: "%.1f",(cartProduct?.productPrice)! + 1)) ron")
        //convert the value of the cartProduct.Quantity to string
        productQuantityLabel?.text = String("x\(String(describing: (cartProduct?.quantity)!))")
    }
}

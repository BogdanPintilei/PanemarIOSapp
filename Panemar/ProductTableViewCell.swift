//
//  ProductTableViewCell.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 4/19/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    var product: Product? { didSet { configureWithProduct() } }

    private func configureWithProduct() {
        self.productImageView.image = nil
        productNameLabel?.text = product?.productName
        //convert the value of product.productPrice to string
        productPriceLabel?.text = String("\(String(format: "%.1f",(product?.productPrice)!)) ron")
        //load the image for wach product
        loadProductImage()
    }
    
    private func loadProductImage() {
        //check if image is not save in memory
        if (product?.cachedImage) != nil {
            self.productImageView?.image = self.product?.cachedImage
        } else if let productImageURL = NSURL(string: (product?.productImageURL)!) {
            DispatchQueue.global().async {
                let imageData:Data? = try? Data(contentsOf: productImageURL as URL)
                DispatchQueue.main.async {
                    var image: UIImage?
                    if imageData == nil {
                        image = nil
                    } else {
                        image = UIImage(data: imageData!)
                    }
                    self.productImageView?.image = image
                    self.product?.cachedImage = image
                }
            }
        }
    }
}
    

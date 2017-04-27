//
//  ProductDetailViewController.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 4/21/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var productDetailImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    var product:Product?
    var quantityOfOrder:String?
    var quantityTextField: UITextField?
    
    override func viewDidLoad() {
        productDetailImageView.image = product?.cachedImage
        self.title = product?.productName
        self.descriptionLabel.text = product?.productInfo
        self.ingredientsLabel.text = product?.productIngredients
        self.addButton.layer.cornerRadius = 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToCart(_ sender: Any) {
        /*
         When i press ok the ptoduct and the quantity entered are added to the list
         */
        let okAction = UIAlertAction (title: "OK", style: UIAlertActionStyle.default) {
          (action) -> Void in
            self.quantityOfOrder = self.quantityTextField?.text
            let ok = Int((self.quantityOfOrder)!)
            if ok != nil {
                let quantity_integer: Int? = Int((self.quantityOfOrder)!)!
                if quantity_integer != 0 {
                Cart.addToCart(product: self.product!, quantityOfProduct: quantity_integer!)
                }
            }
        }
        
        let cancelAction = UIAlertAction (title: "Cancel",style: UIAlertActionStyle.default,handler: nil)
        
        let alertController = UIAlertController(title: product?.productName, message: "Introduceți cantitatea pe care dorită :", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField {
            (quantityInputTextField)-> Void in
            self.quantityTextField = quantityInputTextField
            self.quantityTextField?.placeholder = "Cantitate"
            self.quantityTextField?.keyboardType = .numberPad
            self.quantityTextField?.delegate = self
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK : - Text Field Methods 
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 2
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}


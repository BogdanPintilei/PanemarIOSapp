//
//  CartDetailViewController.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 4/27/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit

class CartDetailViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var placeOrderButton: UIButton!

    
    private func addPaddingToTextFields() {
        nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        surnameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        adressTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        phoneTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "Date Livrare"
        placeOrderButton.layer.cornerRadius = 17
        self.addPaddingToTextFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

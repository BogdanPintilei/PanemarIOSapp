//
//  CartDetailViewController.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 4/27/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit
import Foundation
import MessageUI

class CartDetailViewController: UIViewController ,UITextFieldDelegate,MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var placeOrderButton: UIButton!
    
    @IBOutlet weak var detailScrollView: UIScrollView!
    
    var wasPlaceOrderButtonTapped = false
    var keyboardHeight = 200
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        OrderHistory.loadData()
        self.title =  "Date Livrare"
        self.addPaddingToTextFields()
        self.setKeyboardsDetails()
        self.setTextfieldsDelegates()
        self.disableAutcorrect()
        self.roundCorners()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapOut(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
        if wasPlaceOrderButtonTapped == true {
            showOrderAlertAndCleaCart()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let kH = keyboardSize.height
            keyboardHeight = Int(kH)
        }
    }
    
    private func saveData() {
        NSKeyedArchiver.archiveRootObject(OrderHistory.orderHistory, toFile: OrderHistory.filePath)
    }
    
    private func showOrderAlertAndCleaCart() {
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (action) -> Void in
            //after the order has been  placed the cart must be empty
            Cart.productsInCart.removeAll()
            _ = self.navigationController?.popViewController(animated: true)
        }
        let alertController = UIAlertController(title: nil, message: "Comanda dumneavoastră a fost plasată !", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func areTextFieldsOk() -> Bool {
        var ok = 1
        if (nameTextField.text?.isEmpty)! {
            nameTextField.placeholder = "*"
            ok = 0
        }
        if (surnameTextField.text?.isEmpty)!{
            surnameTextField.placeholder = "*"
            ok = 0
        }
        if (adressTextField.text?.isEmpty)!{
            adressTextField.placeholder = "*"
            ok = 0
        }
        if (phoneTextField.text?.isEmpty)!{
            phoneTextField.placeholder = "*"
            ok = 0
        }
        if (ok == 1) {
            return true
        } else {
            return false
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        var productsInCart = String()
        let total = String(totalPrice())
        var clientDetail = String()
        for p in Cart.productsInCart {
            productsInCart.append("\(String(describing: p.productName!))   .........  x\(String(describing: p.quantity!))\n")
        }
        clientDetail.append("  Nume : \(String(describing: self.nameTextField.text!)) \(String(describing: self.surnameTextField.text!))\n")
        clientDetail.append("   Adresă : \(String(describing: self.adressTextField.text!))\n")
        clientDetail.append("   Contact: \(String(describing: self.phoneTextField.text!))")
        let orderText = "Comanda dumneavoastră : \n\n  \(productsInCart)\n in valoare de : \(total) ron \n\nVa fi livrată către \n\n \(clientDetail))"
        mailComposerVC.setToRecipients(["bpintilei@gmail.com"])
        mailComposerVC.setSubject("Comandă Panemar #\(self.generateId())")
        mailComposerVC.setMessageBody(orderText, isHTML: false)
        
        return mailComposerVC
    }
    
    private func showSendMailErrorAlert() {
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil)
        let alertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(dismissAction)
        self.present(alertController,animated: true,completion:  nil)
    }
    
    private func sendOrderEmail() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    // MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case MFMailComposeResult.cancelled:
            NSLog("Mail cancelled")
        case MFMailComposeResult.saved:
            NSLog("Mail saved")
        case MFMailComposeResult.sent:
            NSLog("Mail sent")
            addOrderToOrderHistory()
            wasPlaceOrderButtonTapped = true
        case MFMailComposeResult.failed:
            NSLog("Mail sent failure: \(String(describing: error?.localizedDescription))")
        }
      
        self.dismiss(animated: true, completion: nil)
    }
    
    private func totalPrice() -> Double {
        var total:Double = 0
        for p in Cart.productsInCart {
            total = total + ((p.productPrice!) * Double(p.quantity!))
        }
        return total
    }
    
    private func generateId() -> Int {
        let orderIdByPosition = OrderHistory.orderHistory.count
        var id = Int()
        if orderIdByPosition == 0 {
            OrderHistory.loadData()
            let position =  OrderHistory.orderHistory.count
            if position != 0{
                id = Int(OrderHistory.orderHistory[position - 1 ].Id)! + 1
            } else {
                id = 1
            }
        } else {
            id = Int(OrderHistory.orderHistory[orderIdByPosition - 1].Id)! + 1
        }
        return id
    }
    
    private func addOrderToOrderHistory() {
        let id = generateId()
        let date = Date()
        let total = String(totalPrice())
        let status = "În așteptare"
        let order = Order(id: String(id), date: date, total: total, status: status)
        print (order.Id)
        print(order.Date)
        print(order.Total)
        print(order.Status)
        OrderHistory.orderHistory.append(order)
        self.saveData()
    }
    
    @IBAction func placeOrder(_ sender: Any) {
        if self.areTextFieldsOk() == true {
            sendOrderEmail()
        } else {
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            let alertController = UIAlertController(title: nil, message: "Toate câmpurile sunt obligatori!!!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(okAction)
            self.present(alertController,animated: true,completion:  nil)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == phoneTextField ) || (textField == adressTextField) {
            detailScrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == phoneTextField) || (textField == adressTextField) {
            detailScrollView.setContentOffset(CGPoint(x: 0 ,y: 0), animated: true)
        }
    }
    
    /*
     if you tap outside the textfield is ike you pressed done
    */
    func tapOut(gesture: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
        adressTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
    }
    
    private func roundCorners() {
        placeOrderButton.layer.cornerRadius = 17
        nameTextField.layer.cornerRadius = 7
        surnameTextField.layer.cornerRadius = 7
        adressTextField.layer.cornerRadius = 7
        phoneTextField.layer.cornerRadius = 7
        nameLabel.layer.masksToBounds = true
        nameLabel.layer.cornerRadius = 12
        surnameLabel.layer.masksToBounds = true
        surnameLabel.layer.cornerRadius = 0
        adressLabel.layer.masksToBounds = true
        adressLabel.layer.cornerRadius = 12
        phoneLabel.layer.masksToBounds = true
        phoneLabel.layer.cornerRadius = 12
    }
    
    private func addPaddingToTextFields() {
        nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        surnameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        adressTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        phoneTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
    }
    
    private func setKeyboardsDetails() {
        self.nameTextField.returnKeyType =  .done
        self.surnameTextField.returnKeyType = .done
        self.adressTextField.returnKeyType = .done
        self.phoneTextField.keyboardType = .numbersAndPunctuation
        self.phoneTextField.returnKeyType = .done
    }
    
    private func disableAutcorrect() {
        self.nameTextField.autocorrectionType = .no
        self.surnameTextField.autocorrectionType = .no
        self.adressTextField.autocorrectionType = .no
        self.phoneTextField.autocorrectionType = .no
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setTextfieldsDelegates() {
        nameTextField.delegate = self
        surnameTextField.delegate = self
        adressTextField.delegate = self
        phoneTextField.delegate = self
    }
}

//
//  CartViewController.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 4/14/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var cartTotalLabel: UILabel!
    @IBOutlet weak var cartTableViewMask: UIView!
    @IBOutlet weak var continueButton: UIButton!

    private func designChanges() {
        self.continueButton.layer.cornerRadius = 18
        cartTableView.backgroundColor = .clear
        cartTableView.separatorColor = .white
        self.cartTableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func maskEmptyTableView() {
        if Cart.productsInCart.count == 0 {
            self.cartTableView.isHidden = true
            self.cartTotalLabel.isHidden = true
            self.continueButton.isHidden = true
            self.cartTableViewMask.isHidden = false
        } else {
            self.cartTableView.isHidden = false
            self.cartTotalLabel.isHidden = false
            self.continueButton.isHidden = false
            self.cartTableViewMask.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartTotalLabel.text = String("Total : \(String(self.totalPrice())) ron")
        designChanges()
        maskEmptyTableView()
        cartTableView.reloadData()
    }
    
    private func totalPrice() -> Double {
        var total:Double = 0
        for p in Cart.productsInCart {
            total = total + ((p.productPrice!) * Double(p.quantity!))
        }
        return total
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - table view methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.productsInCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartProductCell", for: indexPath)
        //Configure the cell
        let prod:Product = Cart.productsInCart[indexPath.row]
        if let productCell = cell as? CartTableViewCell {
            productCell.cartProduct = prod
        }
        return cell
    }
}

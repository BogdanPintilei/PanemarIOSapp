//
//  ProductViewController.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 4/14/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var productsTableView: UITableView!
    
    /*
    the list of products
    */
    public var products = [Product]()

    /*
    the cell we selected
    */
    var selectedProduct:Product?
    
    /*
     fuction for loading data from the plist file into an array list
     */
    private func loadData() {
        //get the contents of the plist file
        let path = Bundle.main.path(forResource: "ProductsList", ofType: "plist")
        let productsDictionaries = NSArray(contentsOfFile: path!)
        
        //get each of the product and append it to the list
        for product in productsDictionaries! {
            
            let prod:NSDictionary = product as! NSDictionary
            let id:Int = prod["id"]! as! Int
            let name:String = prod["name"]! as! String
            let info:String = prod["info"]! as! String
            let ingredients:String = prod["ingredients"]! as! String
            let price:Double = prod["price"]! as! Double
            let imageURL:String = prod["product_URL"]! as! String
            
            let p = Product(id: id, name: name, info: info, ingredients: ingredients, price: price, imageURL: imageURL,quantity: 0)
            
            products.append(p)
        }
        productsTableView.reloadData()
    }
    
    override func viewDidLoad() {
         // Do any additional setup after loading the view
        super.viewDidLoad()
        productsTableView.backgroundColor = .clear
        productsTableView.separatorColor = .white
        //loads the Data from the plist file into an arrayList
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - table view methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell",for: indexPath)
        //Configure the cell
        let prod:Product = products[indexPath.row]
        if let productCell = cell as? ProductTableViewCell {
            productCell.product = prod
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = products[indexPath.row]
        performSegue(withIdentifier: "ShowDetails", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "ShowDetails" {
            let productDetailVC = segue.destination as! ProductDetailViewController
            productDetailVC.product = selectedProduct
        }
    }
}

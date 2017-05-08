//
//  OrderHistoryViewController.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 4/14/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit

class OrderHistoryViewController: UIViewController ,UITableViewDataSource {

    @IBOutlet weak var orderHistoryMask: UIView!
    @IBOutlet weak var orderHistoryTableView: UITableView!
    
    /*
    function for loading data from the plist file into array list
     */
    private func loadData() {
        OrderHistory.loadData()
        orderHistoryTableView.reloadData()
    }
    
    private func maskEmptyTableView() {
        if OrderHistory.orderHistory.count == 0 {
            self.orderHistoryTableView.isHidden = true
            self.orderHistoryMask.isHidden = false
        } else {
            self.orderHistoryMask.isHidden = true
            self.orderHistoryTableView.isHidden = false
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        //check if the load data hasn't been done already
        if( OrderHistory.orderHistory.count == 0) {
            loadData()
        }
        print(OrderHistory.orderHistory.count)
        orderHistoryTableView.separatorColor = .white
        self.orderHistoryTableView.tableFooterView = UIView(frame: .zero)
        orderHistoryTableView.reloadData()
        maskEmptyTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - table view methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderHistory.orderHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
        //Configure the cell
        let ord: Order = OrderHistory.orderHistory[indexPath.row]
        if let orderCell =  cell as? OrderTableViewCell {
            orderCell.order = ord
        }
        return cell 
    }
}

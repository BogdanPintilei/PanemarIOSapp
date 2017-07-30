//
//  OrderTableViewCell.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 5/2/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderTotalPriceLabel: UILabel!
    @IBOutlet weak var deliveryStatusLabel: UILabel!
    
    var order: Order? { didSet { configureWithOrder() } }
    
    private func statusColourChanger() {
        if order?.Status == "În așteptare" {
            let string = "Status : În așteptare"
            let status = "În așteptare"
            
            let statusRange = (string as NSString).range(of: status)
            let attributeString = NSMutableAttributedString(string: string,attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15)])
            attributeString.setAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15),NSForegroundColorAttributeName: UIColor.red],range: statusRange)
            self.deliveryStatusLabel.attributedText = attributeString
        } else {
            self.deliveryStatusLabel?.text = String("Status : " + (self.order?.Status)!)
        }
    }
    
    private func configureWithOrder() {
        self.orderNumberLabel?.text = String("Order #\(String(describing: (order?.Id)!))")
        let date = DateFormatter.localizedString(from: (order?.Date)!, dateStyle: .short, timeStyle: .short)
        self.orderDateLabel?.text = String("Plasat pe : " + date)
        self.orderTotalPriceLabel?.text = String("Total : \(String(describing: (order!.Total))) ron")
        self.statusColourChanger()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

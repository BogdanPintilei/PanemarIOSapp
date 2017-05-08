//
//  TabBarVC.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 5/7/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    let bcolour  = UIColor("#472918").cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.unselectedItemTintColor = UIColor(cgColor: bcolour)
        for vc in self.viewControllers! {
        vc.tabBarItem.title = nil
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

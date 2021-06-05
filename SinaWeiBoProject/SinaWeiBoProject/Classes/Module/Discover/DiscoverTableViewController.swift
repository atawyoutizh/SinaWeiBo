//
//  DiscoverTableViewController.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/5.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

class DiscoverTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
          visitorView?.setupInfo("visitordiscover_image_message", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
    }

}

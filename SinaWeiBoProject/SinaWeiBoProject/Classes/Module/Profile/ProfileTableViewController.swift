//
//  ProfileTableViewController.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/5.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

class ProfileTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
          visitorView?.setupInfo("visitordiscover_image_profile", message: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
        
    }


}

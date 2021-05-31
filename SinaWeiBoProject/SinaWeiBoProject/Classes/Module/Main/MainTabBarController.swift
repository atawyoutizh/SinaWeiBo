//
//  MainTabBarController.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/5.
//  Copyright © 2015年 房兰峰. All rights reserved.
//


// 在swift中，默认所有的代码文件是共享的
// swift支持命名空间，默认情况下在同一个命名空间，所有的文件可以共享，命名空间默认就是项目名称

import UIKit

class MainTabBarController: UITabBarController {

    @IBOutlet weak var mainTabbar: MainTabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewControllers()
        mainTabbar.composeButton.addTarget(self, action: "composeDidClick", forControlEvents: UIControlEvents.TouchDragInside)
        
    }
    
    func composeDidClick(){
    
    }

    private func addChildViewControllers(){
    
        self.tabBar.tintColor = UIColor.orangeColor()
        addChildViewController("Home","首页","tabbar_home")
        addChildViewController("Message","消息","tabbar_message_center")
        addChildViewController("Discover","发现","tabbar_discover")
        addChildViewController("Profile","我","tabbar_profile")

    }
    
    private func  addChildViewController(sbName:String,_ title:String,_ imageName:String){
    
        let sb = UIStoryboard(name: sbName, bundle: nil)

        // as ? 指定为一个 可选类型的，导航视图的控制器
        // as ! 强制指定为一个有值的对象
        let nav = sb.instantiateInitialViewController() as! UINavigationController
        
        nav.topViewController?.title = title
        
        nav.tabBarItem.image = UIImage(named: imageName)
        addChildViewController(nav)

    }
    
    

}











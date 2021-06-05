
//  AppDelegate.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/5.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setAppenrance()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window?.backgroundColor = UIColor.whiteColor()
        
        window?.rootViewController = MainTabBarController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    /**
    设置全局外观
    修改导航栏外观 - 修改要尽量早，一经设置，全局有效
    */
    private func setAppenrance(){
        // 设置navgationBar 的颜色
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        
        //设置下面的tabBar 的颜色
//         tabBar.tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()

    }

}


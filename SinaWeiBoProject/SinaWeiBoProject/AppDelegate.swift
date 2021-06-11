
//  AppDelegate.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/5.
//  Copyright © 2015年 房兰峰. All rights reserved.

import UIKit
import CoreData

import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 打印用户账户信息
        printLog(UserAccountViewModel.sharedUserAccount.userLogin)
        
        // 注册通知 object -监听由哪一个对象发出的通知，如果设置成nil,锦亭所有对象发出的 “name” 通知 
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchRootViewController:", name: HMSwitchRootViewControllerNotification, object: nil)
        
        
        //设置网络
        setupNetwork()
        
        setAppenrance()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window?.backgroundColor = UIColor.whiteColor()
        
        window?.rootViewController = defaultRootViewController()
        
        window?.makeKeyAndVisible()
        
        //检查版本
//        isNewVerson()
        
//        printLog(isNewVerson())
        
        return true
    }
    
    
    deinit{
        //注销指定名称的通知，在程序被销毁的时候，才会被销毁，可以省略
        NSNotificationCenter.defaultCenter().removeObserver(self, name: HMSwitchRootViewControllerNotification, object: nil)
    }
    
    //切换控制器的监听方法
    func switchRootViewController(notification:NSNotification){
    
        printLog(notification)
        // 在发布通知的时候
        // 如果只是传递消息 post name
        //如果传递消息的同时，希望传递一个数值，可以通过  “objc” 来传递 
        // 如果传递消息的同时，希望传递更多的内容，可以通过 userInfo 来传递
        window?.rootViewController = (notification.object == nil) ? MainTabBarController() : WelcomeViewController()
    }
    
    //启动的默认根控制器
    private func defaultRootViewController() -> UIViewController{
    
        //1.判断用户是否登录
        if UserAccountViewModel.sharedUserAccount.userLogin{
            //2.如果登录，判断是否有新版本
        
            return isNewVerson() ? NewFeatureViewController() : WelcomeViewController()
        }
        
        //3. 如果没有登录，返回 Main
        return MainTabBarController()
    
    }

    // 检查是否是最新版本
    private func isNewVerson() ->Bool{
    
        //1.当前应用程序的版本号
//        printLog(NSBundle.mainBundle().infoDictionary)  //可以打印出当前info(NSBundle)中所有信息，然后从中找出需要的当前版本号信息
//        CFBundleShortVersionString
        let bundleVeison = Double(NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String)!
        printLog("当前版本\(bundleVeison)")
        
        //2.之前保存的程序版本号 
        let versionKey = "com.fanglanfeng.version"
        
        //如果没有，返回 0
        let saxBoxVersion = NSUserDefaults.standardUserDefaults().doubleForKey(versionKey)
        printLog("之前的版本\(saxBoxVersion)")
        
        
        //3. 保存当前版本 
        NSUserDefaults.standardUserDefaults().setDouble(bundleVeison, forKey: versionKey)
        
        //2. 比较两个版本,返回结果
        return bundleVeison > saxBoxVersion
    }
    
    
    
    private func setupNetwork(){
        //设置网络指示器，一旦设置，发其网络请求，会在状态栏显示菊花，指示器只负责 AFN的网络请求，其他网络框架不负责
        AFNetworkActivityIndicatorManager.sharedManager().enabled = true
        
        //设置缓存大小 NSURLCache
        //缓存的路径 ： /Library/Caches/(application bundle id)
        let cache = NSURLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
        NSURLCache.setSharedURLCache(cache)
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


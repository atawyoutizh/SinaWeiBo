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
    
    
    // 专门为"代码创建视图"层次结构设计的函数，可以和XIB /storyboary 等价
    override func loadView() {
        super.loadView()
    }
        
    /**
    视图加载完成会调用
    通常在视图控制器加载完成后，做准备工作，例如:加载数据，或者一次性的初始化/准备工作
    如果视图没有被销毁，只会被调用一次
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        view.backgroundColor = UIColor.redColor()
        
        addChildViewControllers()
        
//        print(tabBar.subviews)
//        setupComposeButton()
    }
    
    // 视图将要出现，肯呢过会被调用多次，例如：push Yige vc,在 pop回来，次方法会被再次调用
    // 不适合做多vezhiixng的代码
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
                
        setupComposeButton()
    }
    
    /**
    天极爱撰写按钮，并且设置按钮位置
    */
    private func setupComposeButton(){
    
        // 拿到控制器的总数
        let count = childViewControllers.count
        
        //计算每个按钮的宽度
        let w = tabBar.bounds.width / CGFloat(count)
        let rect = CGRect(x: 0, y: 0, width: w, height: tabBar.bounds.height)
        
        //设置按钮的位置
        //CGRectOffset  偏移的大小
        ComposeButton.frame = CGRectOffset(rect, 2*w, 0)
    }
    
    /**
    按钮监听方法，由运行循环调用，因此不能直接使用 private
    swift中，所有的函数如果不使用 private 修饰，是全局共享的
    
    @objc 关键字能够保证运行循环弄呢狗狗调用，走的 OC的消息机制，调用之前不再判断方法是否存在
    和private连用，就能够做到对方法的保护
    */

    @objc  private func clickComposeButton(){
//        print(__FUNCTION__)
        
    }
    
    // 加载子控制器
    private func addChildViewControllers(){
    
//        tabBar.tintColor = UIColor.orangeColor()
        
        /*
        // 设置字体的属性
        let attr = [NSForegroundColorAttributeName:UIColor.orangeColor(),
            NSFontAttributeName:UIFont.systemFontOfSize(14)]
*/
        
        addChildViewControllerHMs(HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewControllerHMs(MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(UIViewController())
        addChildViewControllerHMs(DiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewControllerHMs(ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
    }
    
    
    // 每一个控制需要调用的封装了的方法
    private func addChildViewControllerHMs(vc:UIViewController,title:String,imageName:String){
    
        // 设置标题 navigationItem + tabBarItem
        vc.title = title
        vc.tabBarItem.image = UIImage(named:imageName)
        let nav = UINavigationController(rootViewController: vc)
        
        // 添加控制器
        addChildViewController(nav)
        
    }
    
    //MARK: - 懒加载button控件
    private lazy var ComposeButton:UIButton = {
    
        //创建一个自定义button
        let btn = UIButton()
        //设置图像
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        self.tabBar.addSubview(btn)
        //添加监听方法
        btn.addTarget(self, action: "clickComposeButton", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    

}











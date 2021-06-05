//
//  BaseTableViewController.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/6.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    
    //用户登录标记
    var userLogin = false
    
    //用户登陆视图 - 每个控制器各自拥有自己的 visitorView
    // 提示：如果使用懒加载，会在用户登陆成功之后，视图仍然被创建，虽然不会影响程序执行，但是会消耗内存
    var visitorView:VisitorLoginView?
    
//    lazy var visitorView:VisitorLoginView = VisitorLoginView()
    
    /**
    如果view不存在，系统会再次调用loadView
    */
    override func loadView() {
        
//        super.loadView()
        userLogin ? super.loadView() : setupVistorView()
    }
    
    
    /**
    设置访客视图
    */
    private func setupVistorView(){
    
        visitorView = VisitorLoginView()
        
        //替换视图
        view = visitorView
        
//        view.backgroundColor = UIColor.orangeColor()
        
        //设置导航栏
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "VisitorLoginViewWillRigester")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self , action: "VisitorLoginViewWillLogin")

        visitorView?.registerButton.addTarget(self, action: "VisitorLoginViewWillRigester", forControlEvents: UIControlEvents.TouchUpInside)
         visitorView?.loginButton.addTarget(self, action: "VisitorLoginViewWillLogin", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    //MARK: - VisitorLoginViewDelegate
    
    func VisitorLoginViewWillRigester() {
        print("注册")
    }
    func VisitorLoginViewWillLogin() {
       
        let nav = UINavigationController(rootViewController: OAuthViewController())
        presentViewController(nav, animated:true, completion: nil)
        
    }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
//    var vistorLoginView:VistorLoginView?
    
    
    //是专门为手写代码准备的，一旦实现此方法，所有的xib/sb 都会失效
    //当试图控制器被初始化后，它会自动检测View是否为空，如果为空，会自动盗用此方法
    // 在view没有被初始化之前，不要跟踪view
    
    /*
    override func loadView() {
        
        
        vistorLoginView = NSBundle.mainBundle().loadNibNamed("VistorLoginView", owner: nil, options: nil).last as? VistorLoginView
        
//        myView.backgroundColor = UIColor.redColor()
        
//        vistorLoginView.vis
        view = vistorLoginView
        
        //添加导航栏的barButtonItem
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "")
        
          self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: UIBarButtonItemStyle.Plain, target: self, action: "")
        
        // appearance.tintColor 相当于将颜色作为全局文件存储，
        // 修改它，一定要趁早设置，否则完了
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        
        
    }
*/
    
    
}

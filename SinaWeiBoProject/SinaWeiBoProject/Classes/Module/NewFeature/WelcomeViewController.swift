//
//  WelcomeViewController.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/11.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {

    //头像底部约束
    private var iconBottomCons: NSLayoutConstraint?
    
    override func viewDidLoad() {
        
        setupUI()
        
        if UserAccountViewModel.sharedUserAccount.userLogin {
        
            //设置用户头像
            iconImage.sd_setImageWithURL(UserAccountViewModel.sharedUserAccount.avatarURL)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //开始动画 
        //1.计算目标的约束数值
        let h = -(UIScreen.mainScreen().bounds.height + (iconBottomCons!.constant))
//        let h:CGFloat = 200
        
        //2.修改约束数值
        //使用自动布局，苹果提供了一个自动布局系统，在后台维护界面元素的位置和大小
        //一点使用了自动布局，就不要在直接设置 frame
        //自动布局系统，会 “ 收集 ” 界面上所有需要重新调正位置/大小的空间的约束，然后一次性修改
        //如果开发中需要强行更新约束，可以直接调用 layoutIfNeeded 方法，会将当前所有的约束变化应用到控件上
        iconBottomCons?.constant = h
        
        //3.开始动画
        lable.alpha = 0
        UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: [], animations: { () -> Void in
            
            //如果需要更新布局
            self.view.layoutIfNeeded()
            }) { (_) -> Void in
                
                UIView.animateWithDuration(0.8, animations: { () -> Void in
                    self.lable.alpha = 1
                    }, completion: { (_) -> Void in
                        
                        //TODO: - 
                        //封信根控制器 
                        //UIApplication.sharedApplication().keyWindow?.rootViewController = MainTabBarController()
                        
                        //利用通知，通知AppDelegate 要更改控制器
                        NSNotificationCenter.defaultCenter().postNotificationName(HMSwitchRootViewControllerNotification, object: nil)
                })
        }
    }
    
    func setupUI(){
        //1.添加控件
        
        view.addSubview(backImage)
        view.addSubview(iconImage)
        view.addSubview(lable)
        
        //2. 自动布局
        
        backImage.ff_Fill(view)
        
        let cons = iconImage.ff_AlignInner(type: ff_AlignType.BottomCenter, referView: view, size: CGSize(width: 90, height: 90), offset: CGPoint(x: 0, y: -200))
        
        self.iconBottomCons = iconImage.ff_Constraint(cons, attribute: NSLayoutAttribute.Bottom)
        
        lable.ff_AlignVertical(type: ff_AlignType.BottomCenter, referView: iconImage, size: nil, offset: CGPoint(x: 0, y: 16))
        
    }
    
    //MARK: - 懒加载控件
    private lazy var backImage:UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    
    private lazy var iconImage:UIImageView = {
    
        let iv = UIImageView(image: UIImage(named: "avatar_default_big"))
        
        //设置圆角 
        iv.layer.cornerRadius = 45
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    private lazy var lable:UILabel = UILabel(title: "欢迎回来", color: UIColor.grayColor(), fonSize: 18)

}







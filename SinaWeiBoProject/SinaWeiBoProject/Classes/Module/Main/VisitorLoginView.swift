
//
//  VisitorLoginView.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/9.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

// 访客视图的协议
//protocol VisitorLoginViewDelegate : NSObjectProtocol{
//
//    func VisitorLoginViewWillRigester();
//     func VisitorLoginViewWillLogin();
//}


class VisitorLoginView: UIView {

    //MARK: - 定义代理 -代理一定要加 waek
//    weak var delegate:VisitorLoginViewDelegate?
//    @objc private func clickRegister(){
//        delegate?.VisitorLoginViewWillRigester()
//    }
//    @objc private func clickLogin(){
//        delegate?.VisitorLoginViewWillLogin()
//    }

    
    
    
    /**
    设置界面信息
    - parameter imageName: 图像名称
    - parameter message:   消息文字
    */
    func setupInfo(imageName:String?,message:String){
        messageLabel.text = message
        
        //判断是否传进脱氨，有图片就不是首页
        if let imName = imageName{
            iconView.image = UIImage(named: imName)
            //隐藏小房子图标
            homeIconView.hidden = true
            
            // 把一个控件放在最下面
            // 将遮罩视图移动到最底部
            sendSubviewToBack(makyIocnView)
            
            //把一个控件放在最前面
//            bringSubviewToFront(homeIconView)
        }else{
            startAnimation()
        }
    }
    
    private func startAnimation(){
    
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.duration = 5
        anim.repeatCount = MAXFLOAT
        
        // 设置动画不被删除，当 iconView 被销毁的时候，动画会自动释放
        anim.removedOnCompletion = false
        iconView.layer.addAnimation(anim, forKey: nil)
    }
    
    //MARK:- 设置界面
    
    //纯代码开发的时候会被调用
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    // SB开发的时候会被调用
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
        setupUI()

    }

    //设置界面 --- 》负责添加和设置界面位置
    private func setupUI(){
    
        //1.添加控件
        addSubview(iconView)
        
        addSubview(makyIocnView)
        
        addSubview(homeIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        
        
        //2.设置布局,将布局要添加到视图上
        // 默认情况下，使用纯代码，是不支持自动布局的，如果要支持自动布局，
//        需要将控件的 translatesAutoresizingMaskIntoConstraints  设置为 false /NO
//         "view1.attr1 = view2.attr2 * multiplier + constant"   --->计算原则
        iconView.translatesAutoresizingMaskIntoConstraints = false
//        addConstraint(NSLayoutConstraint(item: <#T##AnyObject#>, attribute: <#T##NSLayoutAttribute#>, relatedBy: <#T##NSLayoutRelation#>, toItem: <#T##AnyObject?#>, attribute: <#T##NSLayoutAttribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>))
        
        // 1.图标
        addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: -40))

        // 2.小房子--》自动布局的时候，最好有一个固定的参照物
        homeIconView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
//
//        // 3.文字
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        // 提示如果要设置一个固定的数组，需要设置为 NSLayoutAttribute.NotAnAttribute ，参照对象为 nil
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute:  NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 224))

        // 4.注册按钮
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 15))
        // 提示如果要设置一个固定的数组，需要设置为 NSLayoutAttribute.NotAnAttribute ，参照对象为 nil
        addConstraint(NSLayoutConstraint(item: registerButton, attribute:  NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
         addConstraint(NSLayoutConstraint(item: registerButton, attribute:  NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 35))

        //5. 登陆按钮
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 15))
        // 提示如果要设置一个固定的数组，需要设置为 NSLayoutAttribute.NotAnAttribute ，参照对象为 nil
        addConstraint(NSLayoutConstraint(item: loginButton, attribute:  NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute:  NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 35))
        
        // 6. 遮罩视图 - VFL 可视化布局语言
    
        /**
        
        H:水平方向
        V：垂直方向
        |  边界
        []  控件
        
        metrics: 极少用
        views : [key,VFN 中 [] 括起的名称，value:控件 ] --> 控件和 VFL的映射
        
        */
        makyIocnView.translatesAutoresizingMaskIntoConstraints = false
        let cons = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[v]-0-|", options: [], metrics: nil, views: ["v":makyIocnView])
        // 调试 VFL 的技巧
//        print(cons)
        addConstraints(cons)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[v]-(-35)-[regButton]", options: [], metrics: nil, views: ["v":makyIocnView,"regButton":registerButton]))
        // 设置背景颜色 - 灰度 r = g = b
        // 提高程序效率的一个细节 ，如果能用颜色表示，就不要用图片
        backgroundColor = UIColor(white: 237.0/255.0, alpha: 1)
        
    }
    
    
    //MARK: - 懒加载控件  -->负责创建控件
    // 图标
    private lazy var iconView:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    // 遮罩视图
    private lazy var makyIocnView :UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    //小房子
    private lazy var homeIconView:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    
    //消息文件
    private lazy var messageLabel:UILabel = {
    
        let label = UILabel()
        label.text = "关注一些人，回这里看看有什么惊喜,关注一些人，回这里看看有什么惊喜"
        label.textColor = UIColor.darkGrayColor()
    
        label.numberOfLines = 0
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    
    //注册按钮
    lazy var registerButton:UIButton = {
    
        let button = UIButton()
        button.setTitle("注册", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
//        button.addTarget(self, action: "clickRegister", forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }()
    // 登陆按钮
    lazy var loginButton:UIButton = {
        
        let button = UIButton()
        button.setTitle("登陆", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
//        button.addTarget(self, action: "clickLogin", forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }()

    
    
}

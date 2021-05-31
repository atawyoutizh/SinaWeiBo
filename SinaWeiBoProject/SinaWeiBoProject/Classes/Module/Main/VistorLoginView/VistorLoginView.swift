//
//  VistorLoginView.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/6.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

/**
1.起草一份协议，声明代理

*/
import UIKit

protocol    VistorLoginViewDelegate:NSObjectProtocol{

    // 注册
    func vistorWillResister()
    //登陆
    func vistorWillLogin()
}

class VistorLoginView: UIView {

//    weak var vistorViewDelegate:VistorLoginViewDelegate;
    
    @IBOutlet weak var smallIcon: UIImageView!
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    
//    ,isHissend = 
    func setupInfo(imageName name :String, tipText:String ,isHome:Bool ){
    
//        imageName =imageName
        iconView.image = UIImage(named: name)
        
        tipLabel.text = tipText
     
        
        if !isHome{
        
            iconView.hidden = true
        }
        
    }
    
    
    //MARK: 转动动画
    private func startAnimation(){
    
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.repeatCount = MAXFLOAT
        anim.repeatDuration = 5
        
        anim.toValue = 2 * M_PI
        //当动画页面处于非活跃状态下，默认会移除图层
        anim.removedOnCompletion = false
        
        smallIcon.layer.addAnimation(anim, forKey: nil)
        
        
    }
    
    @IBAction func registerAction(sender: AnyObject) {
        
        
    }
    
    
    @IBAction func loginAction(sender: AnyObject) {
    }
    
    /*
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

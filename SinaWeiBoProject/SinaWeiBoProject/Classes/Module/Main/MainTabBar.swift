//
//  MainTabBar.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/5.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

class MainTabBar: UITabBar {

    
    
    //改变tabbarItem的位置 大小
    //布局字视图方法
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        var index:CGFloat = 0
        let w = UIScreen.mainScreen().bounds.size.width/5
        let h = self.bounds.height
        let frame = CGRectMake(0, 0, w, h)
        for view in subviews{
        
            if view is UIControl && !(view is UIButton){
            
                view.frame = CGRectOffset(frame, index*w, 0)
                
                //递增
//                if index == 1 {
//                
//                    index++
//                }
//                index++
                index += (index == 1 ? 2 : 1)
                
                
            }
        }
        //设置撰写按钮的位置
        composeButton.frame = CGRectOffset(frame, 2*w, 0)
        
    }
    
    lazy var composeButton:UIButton = {
    
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
    
        self.addSubview(btn)
        
        return btn
    
    }()
    
}

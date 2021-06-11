//
//  UIButton+Extension.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/13.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

extension  UIButton {

    ///  遍历构造函数
    ///
    ///  - parameter title:     titile
    ///  - parameter imageName: imagename
    ///  - parameter color:     coclo
    ///  - parameter fontSize:  fontSize
    ///
    ///  - returns: UIButton
    
    convenience init(title:String,imageName:String,color:UIColor,fontSize:CGFloat){
        
        // 注意  遍历构造函数一定要在前面写上 suoer.init
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setTitleColor(color, forState: UIControlState.Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
}

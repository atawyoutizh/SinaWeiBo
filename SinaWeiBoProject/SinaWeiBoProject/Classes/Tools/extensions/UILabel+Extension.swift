//
//  UILabel+Extension.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/12.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

extension UILabel{

    //便利构造函数
    convenience init(title:String?,color:UIColor,fonSize:CGFloat,layoutWith:CGFloat = 0){
        //实例化当前对象
        self.init()
        
        //设置对象属性
        text = title
        textColor = color
        font = UIFont.systemFontOfSize(fonSize)
        
        if layoutWith > 0{
            preferredMaxLayoutWidth = layoutWith
            numberOfLines = 0
        }
    }
}


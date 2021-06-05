//
//  Common.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/9.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import Foundation



/*
搜索  swift

-D DEBUG

buildSetting Other Swift flags 添加 -D DEBUG
*/

//print(__FILE__)
//print(__LINE__)
//print(__FUNCTION__)

func printfLog(message:AnyObject,fileName:String,line:Int,methodName:String){

//    let s = (fileName as NSString).lastPathComponent
    
    
    #if DEBUG
    
    print("\((fileName as NSString).lastPathComponent)[\(line)],\(methodName): \(message)")
    
    #endif
    
    
}
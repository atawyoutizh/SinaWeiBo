//
//  Common.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/9.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import Foundation




/// 常用工具
import Foundation


//MARK: - 通知常量定义
let HMSwitchRootViewControllerNotification = "HMSwitchRootViewControllerNotification"



//MARK: - 输出日志

/// 输出日志
///
/// - parameter message:  日志消息
/// - parameter logError: 错误标记，默认是 false，如果是 true，发布时仍然会输出
/// - parameter file:     文件名
/// - parameter method:   方法名
/// - parameter line:     代码行数
func printLog<T>(message: T,
    logError: Bool = false,
    file: String = __FILE__,
    method: String = __FUNCTION__,
    line: Int = __LINE__)
{
    if logError {
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    } else {
        #if DEBUG
            print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        #endif
    }
}







/*
搜索  swift

-D DEBUG

buildSetting Other Swift flags 添加 -D DEBUG
*/

//print(__FILE__)
//print(__LINE__)
//print(__FUNCTION__)
//
//func printfLog(message:AnyObject,fileName:String,line:Int,methodName:String){
//
////    let s = (fileName as NSString).lastPathComponent
//    #if DEBUG
//    print("\((fileName as NSString).lastPathComponent)[\(line)],\(methodName): \(message)")
//    #endif
//}
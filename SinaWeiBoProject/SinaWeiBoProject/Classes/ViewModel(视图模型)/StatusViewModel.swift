//
//  StatusViewModel.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/12.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {
    
    /// 微博对象
    var status:Status
    
    ///用户头像URL
    var userIconUrl:NSURL?{
        return NSURL(string: status.user?.profile_image_url ?? "")
    }
    
    // 认证类型 -1 没有认证  0 认证用户  2，3，5 企业认证  220 大人
    // imageWithNamed 方法能够缓存图像，所以两个计算型属性的效率不会受到影响 
    var userVipImage:UIImage?{
        switch(status.user?.verified ?? -1){
        case 0: return UIImage(named: "avatar_vip")
        case 2,3,5: return UIImage(named: "avatar_enterprise_vip")
        case 220: return UIImage(named: "avatar_grassroot")
        default:return nil
        }
    }
    var userMemberImage:UIImage? {
        if status.user?.mbrank > 0 && status.user?.mbrank < 7 {
            return UIImage(named: "common_icon_membership_level\(status.user!.mbrank)")
        }
        return nil
    }
    
    /// 配图 梭路如图 URL 数组
    var thumbnailURLs:[NSURL]?
    
    //MARK: - 构造函数
    init(status:Status) {
        self.status = status
        
        // 给缩略图 数组设置数组
        // 判断是否有图像
        if status.pic_urls != nil{
        
            thumbnailURLs = [NSURL]()
            
            // 遍历数组，插入 URL 
            for dict in status.pic_urls!{
            
                // 第一个 ! 确保字典中的 thumbnail_pic “key” 一定存在
                // 第二个 ! 确保 后台返回的 URL 字符串 一定能创建出 URL  ，通常由后台返回的 URL 是添加过 百分号 转义的 ！
                thumbnailURLs?.append(NSURL(string: dict["thumbnail_pic"]!)!)
            }
        }
        
        super.init()
    }
    
    
    // 在 StatusViewModel 中重写 description 方法，可以打印出里面的内容
    override var description:String{
        return status.description //+ "缩略图 URL 数组\(thumbnailURLs)"
    }
    
}

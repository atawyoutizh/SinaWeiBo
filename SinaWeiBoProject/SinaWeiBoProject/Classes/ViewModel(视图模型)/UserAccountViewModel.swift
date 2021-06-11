//
//  UserAccountViewModel.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/11.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit
import ReactiveCocoa

class UserAccountViewModel: NSObject {

    //单例
    static let sharedUserAccount = UserAccountViewModel()
    
    override init() {
        userAccount = UserAccount.loadUserAccount()
    }
    
    //用户账号
    private var userAccount:UserAccount?
    //accessToken
    var accessToken :String?{
        return userAccount?.access_token
    }
    
    ///  用户登陆标记
    var userLogin:Bool{
        return accessToken != nil
    }
    
    var avatarURL:NSURL?{

        return NSURL(string: userAccount?.avatar_large ?? "")
//        return NSURL(string:"")
    }
    
    
    //MARK: - 加载网络数据
    func loadUserAccount(code:String) ->RACSignal{
        
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            
            // doNet 是可以给信号增加附加操作的，第一个信号完成之后，将第一个信号的 result 直接传递给第二个信号
            // doNet 后面一定要加一个subscriberXXX ,否则deNet 不会被执行
            NetworkTools.sharedTools.loadAccessToken(code).doNext({ (result) -> Void in

                //创建用户账户模型  as! 将一个对象视为什么类型  ！？ 取决于参数的需要
                let account = UserAccount(dict: result as! [String:AnyObject])
//                printLog(account)
                
                self.userAccount = account
                NetworkTools.sharedTools.loadUserInfo(account.uid!).subscribeNext({ (result) -> Void in
                    
                    let dict = result as! [String:AnyObject]
                    
                    //设置账号的属性
                    account.name = dict["name"] as? String
                    account.avatar_large = dict["avatar_large"] as? String
                    
//                    printLog(account)
                    account.saveUserAccount()
                    
                    }, error: { (error) -> Void in
                        printLog(error)
                    })
                // 完成
                 subscriber.sendCompleted()
                
            }).subscribeError({ (error) -> Void in
                subscriber.sendError(error)
                printLog(error)
            })
            return nil
        })
    }
}

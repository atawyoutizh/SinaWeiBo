//
//  UserAccount.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/10.
//  Copyright © 2015年 房兰峰. All rights reserved.
//

import UIKit

/// 用户账户
class UserAccount: NSObject ,NSCoding{
    
//    用于调用access_token，接口获取授权后的access token。
    var access_token:String?
//    access_token的生命周期，单位是秒数
    var expires_in:NSTimeInterval = 0{
    
        didSet{
//        计算过期日期
            expires_data = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    
    var expires_data:NSDate?
    
//    当前授权用户的UID。
    var uid:String?
    //友好显示名称
    
    var name:String?
    //用户头像地址（大图），180×180像素
    var avatar_large:String?
    
    
    init(dict:[String:AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
    //对象的描述信息，需要生写，关于对象的描述信息，苹果变换了很多版本，目前没有智能提示
    // 在打印模型的时候，不只是地址，而是里面的元素
    // 在swift /OC 中，任何对象都有一个 description  的属性 ，用处就是用来打印对象信息
    //  默认 字典/ 数组/ 字符串都有自己的格式 ，而自定义对象，默认 的格式 <类名:地址>，不利于调试 
    // 为了便于调试，自定义对象可以重写 dexcription
    override var description:String{
        let keys = ["access_token","expires_in","uid","expires_data","name","avatar_large"]

        // KVC 的模型转字段 "\(变量名)" 调用 description  进行转换 
        //return dictionaryWithValuesForKeys(keys).description
        return "\(dictionaryWithValuesForKeys(keys))"
    }

    static let accountPath = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("account.plist")
    
    
    //将当前对象归档保存
    func saveUserAccount(){
        // “键值” 归档
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.accountPath)
        printLog("保存路径" + UserAccount.accountPath)
    }
    
    ///  加载用户账户
    ///
    ///  - returns: 账户信息，如果用户还没有登陆，返回 nil
    class func loadUserAccount() ->UserAccount? {
        
        // 解档加载用户账户的时候，需要判断 token  的有效期
        let account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
        
        if let date = account?.expires_data{
        
            //比较日期 date  > NSDate()  结果 是降序 
            if date.compare(NSDate()) == NSComparisonResult.OrderedDescending{
                return account
            }
        }
        return nil
}

    
    
    
    
    //MARK: - NSCoding
    //归档，将当前对象保存到磁盘之前，转换成二进制数据，跟序列化很像
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_data, forKey: "expires_data")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        access_token =  aDecoder.decodeObjectForKey("access_token") as? String
        expires_data = aDecoder.decodeObjectForKey("expires_data") as? NSDate
        uid = aDecoder.decodeObjectForKey("uid") as? String
        name = aDecoder.decodeObjectForKey("name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
    }
    
    
    

}

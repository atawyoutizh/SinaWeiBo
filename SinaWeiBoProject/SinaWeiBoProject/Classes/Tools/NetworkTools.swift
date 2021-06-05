//
//  NetworkTools.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/9.
//  Copyright © 2015年 房兰峰. All rights reserved.
//


/*
App Key：1770208665
App Secret：ee95093ff52e9f3659018e6bb84d4d77

redirect_uri :http://www.baidu.com

https://api.weibo.com/oauth2/authorize

https://api.weibo.com/oauth2/authorize?client_id=1770208665&redirect_uri=http://www.baidu.com




App Key：100322432
App Secret：bcbf340e112a0218e202bbd3fd800eb7
http://www.baidu.com

https://api.weibo.com/oauth2/authorize?client_id=100322432&redirect_uri=http://www.baidu.com

*/

import UIKit

class NetworkTools: NSObject {

    //测试网站
//    "https://api.weibo.com/oauth2/authorize?client_id=1770208665&redirect_uri=http://www.baidu.com"

    let appKey = "1770208665"
    let appSecret = "ee95093ff52e9f3659018e6bb84d4d77"
    let redirectUri = "http://www.baidu.com"
    
    static let sharedTools = NetworkTools()
    
    /// -see:[https://api.weibo.com/oauth2/authorize](https://api.weibo.com/oauth2/authorize)
    var oauthUrl:NSURL{
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUri)"
//        print(urlString)
        return NSURL(string: urlString)!
    }
    
}

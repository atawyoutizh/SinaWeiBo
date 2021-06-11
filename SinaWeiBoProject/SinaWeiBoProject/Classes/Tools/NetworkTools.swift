



/*
App Key：1770208665
App Secret：ee95093ff52e9f3659018e6bb84d4d77

redirect_uri :http://www.baidu.com

https://api.weibo.com/oauth2/authorize

https://api.weibo.com/oauth2/authorize?client_id=1770208665&redirect_uri=http://www.baidu.com


App Key：100322432
App Secret：bcbf340e112a0218e202bbd3fd800eb7
http://www.baidu.com

拼接的整个路径 获取 token 值
https://api.weibo.com/oauth2/authorize?client_id=100322432&redirect_uri=http://www.baidu.com

//测试网站
//    "https://api.weibo.com/oauth2/authorize?client_id=1770208665&redirect_uri=http://www.baidu.com"

//        请求方式：get
//        请求URL：https://api.weibo.com/2/users/show.json
//        请求参数：uid=2127758760&access_token=2.00gPrz_C0k8wmGa1c7576f76pN7TWD

*/

import UIKit

import AFNetworking
import ReactiveCocoa

// swift中枚举的变化非常大，可以有构造函数，可以有静态函数，可以有函数，可以遵守协议
enum ResquestMethod:String{
    case GET = "GET"
    case POST = "POST"
}
class NetworkTools: AFHTTPSessionManager {

    //单例
    static let sharedTools:NetworkTools = {
        //指定 baseURL
        var instance = NetworkTools(baseURL: nil)
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return instance
        }()
    
    let clientId = "1770208665"
    let clientSecret = "ee95093ff52e9f3659018e6bb84d4d77"
    let redirectUri = "http://www.baidu.com"
    
    /// -see:[https://api.weibo.com/oauth2/authorize](https://api.weibo.com/oauth2/authorize)
    var oauthUrl:NSURL{
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(clientId)&redirect_uri=\(redirectUri)"
        return NSURL(string: urlString)!
    }
    
    
    //MARK: - 微博数据
    
    ///  加载微博数据
    ///
    ///  - returns: RAC Sianal 
    /// - see: [http://open.weibo.com/wiki/2/statuses/home_timeline](http://open.weibo.com/wiki/2/statuses/home_timeline)
    func loadStatus() ->RACSignal{
    
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        return request(.GET, URLString: urlString, parameters: nil)
    }
    
    
    
    ///获取AcceccToken
    ///- parameter code:       请求码/授权码
    ///- parameter completion: <#completion description#>
    ///- parameter error:      <#error description#>
    /// - see:[http://open.weibo.com/wiki/OAuth2/access_token](http://open.weibo.com/wiki/OAuth2/access_token)
    func loadAccessToken(code:String) ->RACSignal{
        
        //需要什么信息，怎么样获取信息
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id":clientId,"client_secret":clientSecret,"grant_type":"authorization_code","code":code,"redirect_uri":redirectUri]
    
        return request(.POST, URLString: urlString, parameters: params ,withToken:false)

    }
    
    ///  加载用户信息
    ///  - parameter uid:          uid
    ///  - parameter access_token: access_token
    ///
    ///  - returns: RAC Sianal
    /// - see:[https://api.weibo.com/2/users/show](https://api.weibo.com/2/users/show)
    func loadUserInfo(uid:String) ->RACSignal{
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        let params = ["uid":uid]
        
        return request(.GET, URLString: urlString, parameters: params)
        
    }

    
    ///  网络请求方法 （对方法的 GET & POST 进行了封装 ）
    ///
    ///  - parameter method:     method
    ///  - parameter URLString:  URLString
    ///  - parameter parameters: 参数字典
    ///
    ///  - returns: RAC Signal
    ///封装AFN网络请求，网络请求的核心框架都封装在这个方法里
    func request(method:ResquestMethod ,URLString:String,var parameters:[String:AnyObject]?,withToken:Bool = true) ->RACSignal{
        
        return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
            
            // 0. 判断是否需要 token
            if withToken{
            
                //需要增加 “参数字典” 只能怪的token  参数
                // 判断token  是否存在，guard 刚好和 if  let 相反
                guard let token = UserAccountViewModel.sharedUserAccount.accessToken else{
                    // token == nil
                    // 发送一个 token 为空的错误 
                    subscriber.sendError(NSError(domain: "com.fanglanfeng", code: -10001, userInfo: ["errorMessage":"Token 为空"]))
                
                    return nil
                }
                
                //判断是否传递了 参数字典
                
                if parameters == nil{
                    parameters = [String:AnyObject]()
                }
                //后续的 token  都是有效的 
                parameters!["access_token"] = token
                
            }
            
            
            
            //1.成功的回调闭包
            let successCallBack = {(task:NSURLSessionDataTask, result:AnyObject) -> Void in
                //将结果发送给订阅者
                subscriber.sendNext(result)
                //完成
                subscriber.sendCompleted()
            }
            //2.失败的回到信息
            let failureCallBack = { (task:NSURLSessionDataTask, error:NSError) -> Void in
                print(error)
                subscriber.sendError(error)
            }
            
            //3. 根据方法，选择不同的网络方法
            if method == ResquestMethod.GET{
                self.GET(URLString, parameters: parameters, success: successCallBack, failure: failureCallBack)
            }else{
                
                self.POST(URLString, parameters: parameters, success: successCallBack, failure: failureCallBack)
            }
            return nil
        })
    }
    
    

    
    

    

    
    /*
    // 请求用户信息
    ///  - see:[http://open.weibo.com/wiki/2/users/show](http://open.weibo.com/wiki/2/users/show)
    func loadUserInfo(accessToken:String,uid:String,completion:(dict:[String:AnyObject]!,error:NSError?)->()){
    
    
    let urlString = "https://api.weibo.com/2/users/show.json"
    
    //        https://api.weibo.com/2/users/show.json?access_token=2.00gPrz_CfIcnvB867da925400XBUKE&uid=2127758760
    
    let parameters = ["uid":uid,"access_token":accessToken]
    
    GET(urlString, parameters: parameters, success: { (_, result) -> Void in
    
    //            let account = UserAccount(dict: result as! [String:AnyObject])
    //
    //            account.name = result["name"] as! String
    //            account.avatar_large = result["avatar_large"] as! String
    //
    //            printLog(account)
    
    }) { (_, error) -> Void in
    print(error)
    }
    }
    */
    
    
    
    
}




















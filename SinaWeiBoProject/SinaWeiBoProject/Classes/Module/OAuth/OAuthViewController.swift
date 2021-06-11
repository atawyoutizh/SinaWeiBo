//
//  OAuthViewController.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/9.
//  Copyright © 2015年 房兰峰. All rights reserved.

import UIKit

//import <SVProgressHUD/SVProgressHUD.h>

import SVProgressHUD
import ReactiveCocoa


/// OAuth 授权控制器
class OAuthViewController: UIViewController ,UIWebViewDelegate{

    private lazy var webView = UIWebView()
    
    override func loadView() {
        super.loadView()
        
        // 跟视图就是 webView
        view = webView
        
        webView.delegate = self
        title = "登陆新浪微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: UIBarButtonItemStyle.Plain, target: self, action: "autoFill")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(NSURLRequest(URL: NetworkTools.sharedTools.oauthUrl))
    }
    @objc private func close(){
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func autoFill(){
        let js = "document.getElementById('userId').value = 'fanglanfeng@163.com';"+"document.getElementById('passwd').value = '8655146';"
        webView.stringByEvaluatingJavaScriptFromString(js)
    }

    //MARK: - UIWebViewDelegate
    // 通常在 IOS开发中，如果代理方法有bool类型的返回值，返回 true 通常是一切正常
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlString = request.URL!.absoluteString
        //1.判断 request.url 的前半部分是否是回调地址， 如果不是回调地址，继续加载
        
        if !urlString.hasPrefix(NetworkTools.sharedTools.redirectUri) {
            return true
        }
//        printLog(urlString)
        //2.如果是回调地址，检查query ，查询字符串，判断是否包含 "code="
        
        if let query = request.URL!.query  where query.hasPrefix("code="){
            
            let code = query.substringFromIndex("code=".endIndex)
            
//            printLog("code = \(code)")

            //4.调用网络方法，获取token  
//            NetworkTools.sharedTools.loadAccessToken(code).subscribeNext({ (result) -> Void in
//                
//                //创建永华模型  as! 将一个对象视为什么类型  ！？ 取决于参数的需要 
//                let account = UserAccount(dict: result as! [String:AnyObject])
//                
//                self.loadUserInfo(account)
////                printLog(account)
//                }, error: { (error) -> Void in
//                    printLog(error)
//            })
            
            
            UserAccountViewModel.sharedUserAccount.loadUserAccount(code).subscribeError({ (error) -> Void in
                print(error)
                }, completed: { () -> Void in
                    printLog("登陆完成")
                    
                    
                    //关闭控制器
                    SVProgressHUD.dismiss()
                    self.dismissViewControllerAnimated(false, completion: { () -> Void in
                        
                        //利用通知，通知AppDelegate 要更改控制器
                        NSNotificationCenter.defaultCenter().postNotificationName(HMSwitchRootViewControllerNotification, object: "Main")
                        
                    })
                    

            })
            
            UserAccountViewModel.sharedUserAccount.loadUserAccount(code).subscribeNext({ (result) -> Void in
                
                }, error: { (error) -> Void in
                    
                }, completed: { () -> Void in
                    
            })
            
        }else{
            printLog("取消")
        }
        //3.如果有，获取code
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    
}

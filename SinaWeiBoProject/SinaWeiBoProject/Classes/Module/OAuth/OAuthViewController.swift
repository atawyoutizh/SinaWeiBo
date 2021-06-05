//
//  OAuthViewController.swift
//  SinaWeiBoProject
//
//  Created by 房城鸿 on 15/10/9.
//  Copyright © 2015年 房兰峰. All rights reserved.

import UIKit

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
        webView.loadRequest(NSURLRequest(URL: NetworkTools.sharedTools.oauthUrl))
    }
    @objc private func close(){
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
        print(urlString)
        //2.如果是回调地址，检查query ，查询字符串，判断是否包含 "code="
        
        if let query = request.URL!.query  where query.hasPrefix("code="){
            print("query")
        }else{
            print("取消")
        }
        //3.如果有，获取code
        
        return true
    }
    
}

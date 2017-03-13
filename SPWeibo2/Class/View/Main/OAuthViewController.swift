//
//  OAuthView.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/2.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit
import WebKit

class OAuthViewController: UIViewController {
    
    
    
    // oAuthView
    fileprivate lazy var oAuthView = WKWebView(frame: UIScreen.main.bounds)
    // appKey
    fileprivate lazy var appKey = "2738184032"
    // appSecret
    fileprivate lazy var appSecret = "15095726e1dac37ec5fa4eb9889362e4"
    // redirectUri
    fileprivate lazy var redirectUri = "https://www.baidu.com"
    // 用户信息对象
    fileprivate var account:UserAccount?
    // tokenURLString
    fileprivate lazy var tokenURLString = "https://api.weibo.com/oauth2/access_token"
    // detailInfoURLString
    fileprivate lazy var detailInfoURLString = "https://api.weibo.com/2/users/show.json"
    
    
    
    
    // 加载WKWebview
    override func loadView() {
        self.view = oAuthView
    }
    
    
    
    override func viewDidLoad() {
        
        // 添加顶部导航按钮
        // 自动填充按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .plain, target: self, action: #selector(autofillInfo))
        // 取消登录按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelLogin))
        
        
        oAuthView.navigationDelegate = self
        
        // 登录网络请求
        let urlString = "https://open.weibo.cn/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUri)&display=mobile"
        var loginRequest = URLRequest(url: URL(string:urlString)!)
        loginRequest.httpMethod = "GET"
        // 加载登录网络请求
        oAuthView.load(loginRequest)
        
        
    }
    
    // 自动填充按钮点击响应方法
    @objc private func autofillInfo(){
        let jsString = "document.getElementById('userId').value='stephenhou2@163.com';" +
        "document.getElementById('passwd').value='199123';"
        oAuthView.evaluateJavaScript(jsString, completionHandler: nil)
        
    }
    
    // 取消按钮点击响应方法
    @objc private func cancelLogin(){
        dismiss(animated: true, completion: nil)
    }

    
    deinit {
        print("第三方登录页面析构")
        removeFromParentViewController()
    }

}

// MARK: -网络情请求方法和响应方法
extension OAuthViewController:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        // 授权成功
        if url?.host == "www.baidu.com"{
            accessSuccess(url: url!)
            // 如果跳转到百度则取消跳转
            decisionHandler(.cancel)
        }
        if url?.host == "www.sina.com"{
                decisionHandler(.cancel)
                self.dismiss(animated: true, completion: nil)
            
        }
        
        // 设置默认跳转策略
        decisionHandler(.allow)
        
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    
    private func accessSuccess(url:URL){
        // 获取登录码
        let code = url.query?.substring(from: "code=".endIndex)
        
        let parameters = ["client_id":appKey,
                          "client_secret":appSecret,
                          "grant_type":"authorization_code",
                          "code":code,
                          "redirect_uri":redirectUri]

        
        // 发送网络请求获取登录令牌
        NetworkTool.sharedManager.request(method: .POST, URLString: tokenURLString, parameters: parameters, completion: { (response, error) in
            // 判断是否又error
            guard error == nil else{
                print(error!)
                return
            }
            
            // 获取登录令牌
            guard let response = response as? [String:AnyObject] else{return}
            
            // 获取用户信息单例对象
            self.account = UserAccount.sharedAccount ?? UserAccount()
            self.account?.setValuesForKeys(response)
            
            // 登录成功之后的代码
            let parameters = ["access_token":self.account?.access_token,
                              "uid":self.account?.uid]
            
            
            NetworkTool.sharedManager.request(method: .GET, URLString: self.detailInfoURLString, parameters: parameters, completion: { (response, error) in
                
            guard error == nil else{
                    print(error!)
                    return
                }
                
            // 获取用户详细信息
            guard let response = response as? [String:AnyObject] else{return}
            self.account?.setValuesForKeys(response)
                
            // 保存用户数据
            self.account?.saveUserInfo()
            NotificationCenter.default.post(name: WBSwitchRootViewControllerNotification, object: nil, userInfo: ["sender":WBSwitchRootVCNotificationSender.OAuth])
            self.dismiss(animated: false, completion: nil)
            })
        })
    }
}

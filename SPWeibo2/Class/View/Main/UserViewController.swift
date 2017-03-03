//
//  VisitorViewController.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/1.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit
import SnapKit
import WebKit


class UserViewController: UITableViewController,VisitorViewDelegate {

    // visitorView对象
    var visitor:VisitorView?
   
    override func loadView() {
        super.loadView()
        // 获取单例的用户信息对象（本地加载）
      let account = UserAccount.sharedAccount ?? UserAccount.loadUserInfo()
        
        // 判断进入游客模式还是已注册用户模式
        guard account != nil else{
            visitor = VisitorView()
            visitor?.delegate = self
            self.view = visitor
            return
        }
        self.view = UITableView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    deinit {
        print("用户界面析构")
    }
      
}

// MARK: - 代理方法
extension UserViewController{
    
    // 登录按钮点击响应方法
    internal func visitorViewLoginButtonClicked() {
        let nav = UINavigationController(rootViewController: OAuthViewController())
        show(nav, sender: self)
    }
    
    // 注册按钮点击响应方法
    internal func visitorViewRegisterButtonClicked() {
        print("register")
    }
    
}

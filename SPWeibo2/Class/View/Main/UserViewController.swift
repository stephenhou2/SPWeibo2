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

    var visitor:VisitorView?
    // 获取单例的用户信息对象（本地加载）
    private lazy var account = UserAccount.sharedAccount ?? UserAccount.loadUserInfo()
    // 认证控制器
    fileprivate lazy var oAuthVC:OAuthViewController = OAuthViewController()
    
    private lazy var destinationView:UIView = {
        // 判断进入游客模式还是已注册用户模式
        guard self.account != nil else{
            self.visitor = VisitorView()
            self.visitor!.delegate = self
            return self.visitor!
        }
        return UITableView(frame:screenRect,style:UITableViewStyle.grouped)
    }()
    
    override func loadView() {
        super.loadView()
        view = destinationView
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if account == nil{
            
        }
    }
      
}







// MARK: - 代理方法
extension UserViewController{
    
    // 登录按钮点击响应方法
    internal func visitorViewLoginButtonClicked() {
        let nav = UINavigationController(rootViewController: oAuthVC)
        show(nav, sender: self)
    }
    
    // 注册按钮点击响应方法
    internal func visitorViewRegisterButtonClicked() {
      //--------zhcue
    }
    
}

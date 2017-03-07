//
//  WelcomeViewController.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/2.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {

    // 背景图片view
    fileprivate lazy var backgroundImageView = UIImageView(image: UIImage(named:"ad_background"))
    
    // 头像view
    fileprivate lazy var iconView = UIImageView(image: UIImage(named:"avatar_default_big"))
    
    // 昵称label
    fileprivate lazy var welcomeLabel:UILabel = UILabel(text: "欢迎回来")
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加子控件
        view.addSubview(backgroundImageView)
        view.addSubview(iconView)
        view.addSubview(welcomeLabel)
        // 初始化UI
        setupUI()
        
        UserDefaults.standard.set(true, forKey: "hasLogged")
    }
    
    // 注意要在viewDidAppear中添加动画，viewWillAppear中会将子控件摆放到原约束规定的位置，如果动画代码放到viewWillAppear这个方法里可能会使子控件的初始位置和预期不一样（可以将本方法改为willappear试试看效果，头像将从（0，0）点移动到指定位置）
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 获取本地用户信息
        guard let account = UserAccount.sharedAccount else{
            startAnimation()
            return
        }
        
        // 初始化子控件内容
        iconView.sd_setImage(with:URL(string:account.avatar_large!), placeholderImage: UIImage(named: "avatar_default_big"))
        welcomeLabel.text = account.screen_name
        
        // 开始动画
        startAnimation()

    }
    
    
    deinit {
        print("欢迎界面析构")
        removeFromParentViewController()
    }
    
}

// MARK: -自定义的一些方法
extension WelcomeViewController{
    
    /// 动画方法
    fileprivate func startAnimation(){
        
               UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: {
             // 约束放在闭包的里面喝外面目前看来没有什么区别
                self.iconView.snp.updateConstraints { (make) in
                    make.bottom.equalTo(self.view.snp.bottom).offset(-0.7 * self.view.bounds.size.height)
                }
            // 如果使通过约束改变形成的动画，必须要有下面的代码，否则没有动画效果
            self.view.layoutIfNeeded()
        }) { (finished) in
            
            UIView.animate(withDuration: 0.5, animations: { 
                self.welcomeLabel.alpha = 1.0
            }, completion: { (_) in
                NotificationCenter.default.post(name: WBSwitchRootViewControllerNotification, object: nil, userInfo: ["sender":WBSwitchRootVCNotificationSender.Welcome])
            })
        }
    }
    
    
    
    
    fileprivate func setupUI(){
        // 背景图片
        backgroundImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
            make.size.equalTo(self.view.bounds.size)
        }
        // 头像
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(self.view.snp.bottom).offset(-0.5 * self.view.bounds.size.height)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        iconView.layer.cornerRadius = 45
        iconView.clipsToBounds = true
        
        // 文本框
        self.welcomeLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.iconView.snp.bottom).offset(16)
            make.centerX.equalTo(self.iconView.snp.centerX)
        })
        
        self.welcomeLabel.alpha = 0.0
        
    }
}

//
//  AppDelegate.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/2/25.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var userHasLogged:Bool? = UserDefaults.standard.value(forKey: "hasLogged") as? Bool
    private var rootViewController:UIViewController? {
  
        let account = UserAccount.sharedAccount
        guard account != nil else { print("读取失败")
            if userHasLogged != nil {
                return WelcomeViewController()
            }
            return NewFeatureViewController()
        }
        return WelcomeViewController()

    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       /// 程序入口
        window = UIWindow(frame: UIScreen.main.bounds)
        
     
        
        
        // 设置程序入口控制器
        window?.rootViewController = rootViewController
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        // 设置全局外观和风格
        setAppearance()
        // 设置网络状态实时显示
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        // 注册改变根控制器的通知
        NotificationCenter.default.addObserver(forName: WBSwitchRootViewControllerNotification, object: nil, queue: nil) { (notification) in
           let sender = notification.userInfo?["sender"] as! WBSwitchRootVCNotificationSender
            switch sender{
            case .NewFeature:
                self.window?.rootViewController = WelcomeViewController()
            case .Welcome:
                self.window?.rootViewController = MainViewController()
            case .OAuth:
                self.window?.rootViewController = MainViewController()
                
            }
        }
        return true
    }
    
    deinit {
        // 移除通知
        NotificationCenter.default.removeObserver(self, name: WBSwitchRootViewControllerNotification, object: nil)
    }
    
    
}


extension AppDelegate{
    
    /// 设置全局样式和风格
    fileprivate func setAppearance(){
        // 设置全局tabbar上item的颜色
        UITabBar.appearance().tintColor = UIColor.orange
        
        // 设置全局navigationbar上的item的颜色
        UINavigationBar.appearance().tintColor = UIColor.orange
//        UINavigationBar.appearance().titleTextAttributes
    }
    
    
}

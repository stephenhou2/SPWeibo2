//
//  MainViewController.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/1.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class MainViewController:UITabBarController {
    
    
    
    fileprivate lazy var composeButton:UIButton = UIButton(title: nil, imageName: "tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViewControllers()
        setupUI()
        tabBar.addSubview(composeButton)
    }
    
    private func setupChildViewControllers(){
        // 添加子控制器
        addViewController(vc: HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        addViewController(vc:DiscoverTableViewController(),title:"发现",imageName:"tabbar_discover")
        addChildViewController(UIViewController())
        addViewController(vc:MessageTableViewController(),title:"消息",imageName:"tabbar_message_center")
        addViewController(vc:ProfileTableViewController(),title:"我的",imageName:"tabbar_profile")
    }
    
    
    /// 添加子控制器，初始化底部tabbar
    private func addViewController(vc:UIViewController,title:String,imageName:String){
        vc.navigationController?.navigationBar.barTintColor = UIColor.white
        vc.navigationController?.navigationBar.isOpaque = true

        
        let nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
    }
    
    override func viewWillLayoutSubviews() {
        tabBar.bringSubview(toFront: composeButton)
    }
    
    
    deinit {
        print("主界面析构")
    }
    
}

// 自定义的一些方法
extension MainViewController{
    // composeButton点击响应
    @objc fileprivate func composeButtonClicked(){
        print("clicked")
    }
}



// MARK: -设置UI布局和样式
extension MainViewController{
    fileprivate func setupUI(){
        
        // 设置底部tabbar不透明
        tabBar.barTintColor = UIColor.white
        tabBar.isOpaque = true
        
        
        // 设置tabbar中间发布按钮的布局和样式
        let  itemWidth = tabBar.bounds.width / 5
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * itemWidth - 1, dy: 0)
        
        composeButton.addTarget(self, action: #selector(composeButtonClicked), for: .touchUpInside)

    }
    
    
    
}

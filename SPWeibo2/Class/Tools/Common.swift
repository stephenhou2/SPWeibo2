//
//  Common.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/2.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import Foundation
import UIKit

// 用户document文件夹根路径
let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last

// 屏幕大小
let screenRect = UIScreen.main.bounds
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height


enum WBSwitchRootVCNotificationSender{
    case NewFeature
    case Welcome
    case OAuth
}




// 切换根控制器的通知名
let WBSwitchRootViewControllerNotification = Notification.Name("WBSwitchRootViewController")

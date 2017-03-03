//
//  UIButton+Extension.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/1.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

extension UIButton{
    
    /// 便利构造函数
    convenience init(title:String?,imageName:String?,backgroundImageName:String?,titleColor:UIColor = UIColor.darkGray){
        self.init()
        if title != nil{
            setTitle(title, for: .normal)
        }
        if imageName != nil {
            setImage(UIImage(named:imageName!), for: .normal)
        }
        if backgroundImageName != nil{
            setBackgroundImage(UIImage(named:backgroundImageName!), for: .normal)
        }
        
        setTitleColor(titleColor, for: .normal)
        
        sizeToFit()
    }
}

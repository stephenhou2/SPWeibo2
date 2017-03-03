//
//  UILabel+Extension.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/1.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

extension UILabel{
    
    
    convenience init(text:String,fontSize:Int = 14,textColor:UIColor = UIColor.darkGray){
        self.init()
        self.text = text
        self.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        self.textColor = textColor
        self.textAlignment = NSTextAlignment.center
        self.numberOfLines = 0
        
    }
}

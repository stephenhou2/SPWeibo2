//
//  UILabel+Extension.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/1.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

extension UILabel{
    
    
    convenience init(text:String,fontSize:Int = 17,textColor:UIColor = UIColor.darkGray){
        self.init()
        self.text = text
        self.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        self.textColor = textColor
        self.textAlignment = NSTextAlignment.center
        self.numberOfLines = 0
        self.layer.isOpaque = true
        sizeToFit()
    }
    
    convenience init(text:String,fontSize:Int,textColor:UIColor, margin:CGFloat){
        self.init(text:text,fontSize:fontSize,textColor:textColor)
        self.preferredMaxLayoutWidth = screenWidth - 2 * margin
        self.textAlignment = NSTextAlignment.left
        sizeToFit()
    }

    
}

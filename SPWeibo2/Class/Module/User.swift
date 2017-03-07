//
//  File.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/4.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import Foundation

class User:NSObject{
    
 
    // 用户昵称
    var screen_name:String?
    // 用户头像地址（中图），50×50像素
    var profile_image_url:String?
    // 认证类型
    var verified_type:Int = -1
    
    
    init(dic:[String:AnyObject]){
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
    override var description: String{
        return dictionaryWithValues(forKeys: ["screen_name","profile_image_url","verified_type"]).description
    }
    
    
}

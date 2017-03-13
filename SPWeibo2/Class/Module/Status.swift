//
//  Status.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/4.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import Foundation

class Status:NSObject{
    
    
    /// 微博创建时间
    var created_at:String?
    // 微博信息内容
    var text:String?
    /// 缩略图片地址，没有时不返回此字段
    var thumbnail_pic:String?
    /// 被转发的原微博信息字段，当该微博为转发微博时返回
    var retweeted_status:Status?
    /// 微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
    var pic_urls:[[String:String]]?
    /// 微博作者的用户信息字段
    var user:User?
    /// 微博ID
    var id:Int = 0

    // 配图数组
    lazy var picArray:[String] = {
        var picArray = [String]()
        guard let pic_urls = (self.pic_urls?.count != 0 ? self.pic_urls : self.retweeted_status?.pic_urls) else {
            return []
        }
        for pidDict in pic_urls {
            let picUrl = pidDict["thumbnail_pic"]
            picArray.append(picUrl!)
            
        }
        return picArray
    }()
    
    // 字典转模型
    init(dic:[String:AnyObject]){
        super.init()
        setValuesForKeys(dic)
    }
    // 未定义的key不要抛出异常
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    // 键是user时进行字典转模型
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "user"{
            user = User(dic: value as! [String:AnyObject])
            return
        }
        else if key == "retweeted_status" {
            retweeted_status = Status(dic: value as! [String:AnyObject])
            return
        }
        super.setValue(value, forKey: key)
    }
    
    
    override var description: String{
        return dictionaryWithValues(forKeys: ["created_at","text","thumbnail_pic","user","picArray","retweeted_status","id"]).description
    }
    
    
    
   
}

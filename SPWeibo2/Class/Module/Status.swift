//
//  Status.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/4.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import Foundation

class Status:NSObject{
    
    
    // 微博创建时间
    var created_at:String?
    // 微博信息内容
    var text:String?
    // 缩略图片地址，没有时不返回此字段
    var thumbnail_pic:String?
    // TODO: - 被转发的原微博信息字段，当该微博为转发微博时返回
//    var retweeted_status:String?
    // 微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
    var pic_urls:[[String:String]]?
    // 	微博作者的用户信息字段
    var user:User?
    // 配图数组
    lazy var picArray:[String] = {
        var picArray = [String]()
        guard let pic_urls = self.pic_urls else {
            return []
        }
        for pidDict in pic_urls {
            let picUrl = pidDict["thumbnail_pic"]
            picArray.append(picUrl!)
            
        }
        return picArray
    }()
    
    
    init(dic:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String{
        return dictionaryWithValues(forKeys: ["created_at","text","thumbnail_pic","pic_urls","user"]).description
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        // 如果键是“user”，则使用User类进行字典转模型
        if key == "user"{
            if let userDic = value as? [String:AnyObject]{
            user = User(dic: userDic)
            return
            }
        }
        // 其它键值使用父类方法进行字典转模型
        super.setValue(value, forKey: key)
    }

}

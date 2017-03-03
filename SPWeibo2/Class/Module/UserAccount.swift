//
//  UserAccount.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/2.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import Foundation

class UserAccount:NSObject,NSCoding{
    
    // 用户信息单例对象
    static let sharedAccount:UserAccount? = UserAccount.loadUserInfo()
    // 用户信息属性
    // token
    var access_token:String?
    // 过期剩余时间（秒）
    var expires_in:NSNumber?
    // 计算属性，过期日期
    var expires_date:Date{
        return Date(timeIntervalSinceNow: (expires_in?.doubleValue)!)
    }
    // uid
    var uid:String?
    // 用户昵称
    var screen_name:String?
    // 用户头像
    var profile_image_url:String?
    // 用户头像（大图）
    var avatar_large:String?
    // 用户账号是否过期
    var isExpired:Bool{
        return expires_date.compare(Date()) == ComparisonResult.orderedAscending
    }
    
    
    override init() {
        super.init()
    }
    
    // 用户信息文件路径
    private let userInfoFilePath = (docPath! as NSString).appendingPathComponent("account.plist")
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_in, forKey: "expires_in")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(profile_image_url, forKey: "profile_image_url")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        expires_in =  aDecoder.decodeObject(forKey: "expires_in") as? NSNumber
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        profile_image_url = aDecoder.decodeObject(forKey: "profile_image_url") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
    
    // 保存用户信息到本地
    func saveUserInfo(){
        NSKeyedArchiver.archiveRootObject(self, toFile: userInfoFilePath)
    }
    // 读取本地用户信息
    class func loadUserInfo()->UserAccount?{
        let userInfoFilePath = (docPath! as NSString).appendingPathComponent("account.plist")
        return NSKeyedUnarchiver.unarchiveObject(withFile: userInfoFilePath) as? UserAccount
    }
    
    
    
}

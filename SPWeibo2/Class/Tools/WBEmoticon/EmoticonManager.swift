//
//  Emoticons.swift
//  WBEmoticon
//
//  Created by 侯亮宏 on 17/3/14.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class EmoticonManager: NSObject {
    
    static let sharedManager = EmoticonManager()
    
    var emFileIds:[String] = [String]()
    var emoticonGroups:[EmoticonGroup] = [EmoticonGroup]()
    
    override init() {
        
        super.init()
        
        loadEmoticonsData()
        
    }
    
}

extension EmoticonManager{
    
    // 从plist中加载emoticon数据
    fileprivate func loadEmoticonsData(){
        
        // emoticons.plist的地址
        let infoPath = Bundle.main.path(forResource: "emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle")
        // 从plist中加载emoticons数组
        let infoArray = NSDictionary(contentsOfFile: infoPath!)?["packages"] as! NSArray
        let emFileIds = infoArray.value(forKey: "id") as! [String]
        
        self.emFileIds = emFileIds

//        emoticonGroups.append(EmoticonGroup(dic:["group_name_cn":"常用" as AnyObject]))
        
        for id in emFileIds{
            let emoticonGroupFilePath = Bundle.main.path(forResource: "info.plist", ofType: nil, inDirectory: "Emoticons.bundle" + "/\(id)")!
            let emoticonGroupDic = NSDictionary(contentsOfFile: emoticonGroupFilePath) as! [String:AnyObject]
            let emoticonGroup = EmoticonGroup(dic: emoticonGroupDic)
            
            emoticonGroups.append(emoticonGroup)
        }
        
    }
}

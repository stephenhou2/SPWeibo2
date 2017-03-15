//
//  Emoticon.swift
//  WBEmoticon
//
//  Created by 侯亮宏 on 17/3/14.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class Emoticon: NSObject {
    
    var chs:String?
    private var png:String?
    private var code:String?
    
    var emoticonImagePath:String?
    var emoji:String?
  
    var isEmpty:Bool = false
    var isRemove:Bool = false
    
    
    // 构造函数
    init(dic:[String:AnyObject],id:String){
        super.init()
        chs = dic["chs"] as! String?
        png = dic["png"] as! String?
        code = dic["code"] as! String?
        if let pngPath = png{
            emoticonImagePath = Bundle.main.bundlePath + "/Emoticons.bundle" + "/\(id)/" + pngPath
     
        }
        emoji = code?.emoji
        
    }
    
    // 创建空表情
    init(isEmpty:Bool) {
        self.isEmpty = isEmpty
        super.init()
        emoticonImagePath = ""
            }
    // 创建删除图片表情
    init(isRemove:Bool) {
        self.isRemove = isRemove
        super.init()
        emoticonImagePath = Bundle.main.bundlePath + "/Emoticons.bundle/deleteImage/compose_emotion_delete@2x.png"
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
    override var description: String{
        return dictionaryWithValues(forKeys: ["chs","png"]).description
    }
    
}

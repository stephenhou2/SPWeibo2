//
//  EmoticonGroup.swift
//  WBEmoticon
//
//  Created by 侯亮宏 on 17/3/14.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class EmoticonGroup: NSObject {

    var group_name_cn:String = ""
    var emoticons:[Emoticon] = [Emoticon]()
    var id:String = ""
    
    
    init(dic:[String:AnyObject]) {
        super.init()
        group_name_cn = dic["group_name_cn"] as! String
        id = dic["id"] as? String ?? ""
        let emoticonsArray = dic["emoticons"] as? [[String:AnyObject]] ?? []
        
        let emptyCount = emoticonsArray.count % 20 != 0 ? 21 - emoticonsArray.count % 20 : 0
        
        var index = 0
        
        for em in emoticonsArray {
            index += 1
            if index == 21{
                emoticons.append(Emoticon(isRemove: true))
                index = 1
            }
            let emoticon = Emoticon(dic: em,id:id)
            emoticons.append(emoticon)
            
        }
        
        for _ in 0..<emptyCount{
            emoticons.append(Emoticon(isEmpty: true))
        }
    }
    
    override var description: String{
        return dictionaryWithValues(forKeys: ["group_name_cn","id"]).description
    }
    
}

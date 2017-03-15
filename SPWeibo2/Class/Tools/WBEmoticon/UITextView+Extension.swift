//
//  UITextView+Extension.swift
//  WBEmoticon
//
//  Created by 侯亮宏 on 17/3/14.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

extension UITextView{
    
    var attributeString:String{
        
        var textString = String()
        let range = NSRange.init(location: 0, length: attributedText.length)
        attributedText.enumerateAttributes(in: range, options: [], using: { (dic, range, _) in
            // 判断是否有图片表情
            if let attachment = dic["NSAttachment"] as? EmoticonAttachment{
                textString += attachment.chs ?? ""
            }else {
                let str = (attributedText.string as NSString).substring(with: range)
                textString += str
            }
        })
        
        return textString
    }
    
    
    
    func inserEmoticon(em:Emoticon){
        
        if em.isRemove == true{
            deleteBackward()
            return
        }
        else if em.isEmpty == true{
            return
        }
       
        else if em.emoji != nil{
            insertText(em.emoji!)
            return
            
        }
        
        insertPicEmoticon(em:em)
        
        
    }
    
    private func insertPicEmoticon(em:Emoticon){
        // 获取图片表情附件
        let attachment = EmoticonAttachment(emoticon: em, font: font!)
        // 将标清附件转换为富文本
        let attributeStr = NSAttributedString(attachment: attachment)
        // 将富文本转换为可变富文本
        let attributeString = NSMutableAttributedString(attributedString: attributeStr)
        // 添加富文本属性
        attributeString.addAttribute(NSFontAttributeName, value: font!, range: NSRange(location: 0, length: 1))
        // textView文本转换为可变富文本
        let attrText = NSMutableAttributedString(attributedString:attributedText)
        // 记录当前光标位置
        let range = selectedRange
        // 替换选中位置的富文本为表情文本
        attrText.replaceCharacters(in: selectedRange, with: attributeString)
        // 文本框内富文本替换
        attributedText = attrText
        // 重新指定光标位置
        selectedRange = NSRange.init(location: range.location + 1, length: 0)
    }
    
    
    
}

/// 获取图片表情的富文本类
class EmoticonAttachment:NSTextAttachment{
    
    var chs:String?
    
    // 构造函数
    init(emoticon:Emoticon,font:UIFont){
        super.init(data: nil, ofType: nil)
        if emoticon.emoticonImagePath != nil{
            image = UIImage(contentsOfFile: emoticon.emoticonImagePath!)
            chs = emoticon.chs
            let fontHeight = font.lineHeight
            bounds = CGRect(x: 0, y: -4, width: fontHeight, height: fontHeight)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
}

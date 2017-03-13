//
//  RetweetedStatusCell.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/8.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class RetweetedStatusCell: StatusCell {
    
    // 背景按钮
    private lazy var backgroundButton:UIButton = {
       let btn = UIButton()
        btn.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        return btn
    }()
    
    // 转发文字
    private lazy var retweetedTextView:UILabel = {
       let retweetedTextView = UILabel(text: "", fontSize: 12, textColor: UIColor.darkGray, margin: statusMargin)
        return retweetedTextView
    }()
    
    override var status: Status? {
        didSet{
            if status?.retweeted_status != nil {
                let nickName = status?.retweeted_status?.user?.screen_name != nil ? "@" + (status?.retweeted_status?.user?.screen_name)! : ""
                retweetedTextView.text = nickName + (status?.retweeted_status?.text ?? "")
            }else{
                retweetedTextView.text = ""
            }
            let retweetedPicMargin:CGFloat = (status?.retweeted_status?.pic_urls?.count != 0) ? statusMargin : 0
            picturesView.snp.updateConstraints { (make) in
                make.top.equalTo(retweetedTextView.snp.bottom).offset(retweetedPicMargin)
            }
            
        }
    }
    
    
    override func setupUI() {
        super.setupUI()
        
 
         //添加子控价
        contentView.insertSubview(backgroundButton, belowSubview: picturesView)
        contentView.addSubview(retweetedTextView)
        
        
        
        // 设置约束
        backgroundButton.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(statusMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        retweetedTextView.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundButton.snp.top)
            make.left.equalTo(contentView.snp.left).offset(statusMargin)

        }
        
        picturesView.snp.makeConstraints { (make) in
            make.top.equalTo(retweetedTextView.snp.bottom).offset(statusMargin)
            make.left.equalTo(retweetedTextView.snp.left)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
    
    

}

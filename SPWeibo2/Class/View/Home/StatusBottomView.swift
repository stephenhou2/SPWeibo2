//
//  StatusTestView.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/5.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class StatusBottomView: UIView {
    
    
    fileprivate lazy var repostButton:UIButton = UIButton(title: " 转发", imageName: "timeline_icon_retweet", backgroundImageName: "timeline_card_bottom_background")
    
    fileprivate lazy var commentButton:UIButton = UIButton(title: " 评论", imageName: "timeline_icon_comment", backgroundImageName: "timeline_card_bottom_background")
    
    fileprivate lazy var likeButton:UIButton = UIButton(title: " 赞", imageName: "timeline_icon_unlike", backgroundImageName: "timeline_card_bottom_background")
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 初始化控件和布局
        setupUI()
    
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:-初始化控件和布局
extension StatusBottomView{
    
    
    fileprivate func setupUI(){
        
        // 加载ui控件
        addSubview(repostButton)
        addSubview(commentButton)
        addSubview(likeButton)
        
        // 设置约束
        repostButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        commentButton.snp.makeConstraints { (make) in
            make.top.equalTo(repostButton.snp.top)
            make.left.equalTo(repostButton.snp.right)
            make.bottom.equalTo(repostButton.snp.bottom)
            make.width.equalTo(repostButton.snp.width)
        }
        
        likeButton.snp.makeConstraints { (make) in
            make.top.equalTo(commentButton.snp.top)
            make.left.equalTo(commentButton.snp.right)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(commentButton.snp.bottom)
            make.width.equalTo(commentButton.snp.width)
        }
        
        // 添加按钮之间的分隔线
        let seperatorLine1 = seperatorLine
        let seperatorLine2 = seperatorLine
        addSubview(seperatorLine1)
        addSubview(seperatorLine2)
        
        let seperatorLineWidth = 1
        let seperatorLineScale = 0.4
        
        // 设置分割线的约束
        seperatorLine1.snp.makeConstraints { (make) in
            make.left.equalTo(repostButton.snp.right)
            make.centerY.equalTo(repostButton.snp.centerY)
            make.width.equalTo(seperatorLineWidth)
            make.height.equalTo(repostButton.snp.height).multipliedBy(seperatorLineScale)
        }
        seperatorLine2.snp.makeConstraints { (make) in
            make.left.equalTo(commentButton.snp.right)
            make.centerY.equalTo(commentButton.snp.centerY)
            make.width.equalTo(seperatorLineWidth)
            make.height.equalTo(commentButton.snp.height).multipliedBy(seperatorLineScale)
        }

    }
    
    fileprivate var seperatorLine:UIView{
        let sep = UIView()
        sep.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        return sep
    }
    
}

//
//  StatusCell.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/4.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

let statusMargin:CGFloat = 12
let iconViewWidthHeight:CGFloat = 44

class StatusCell: UITableViewCell {

    // cell顶部视图
    fileprivate lazy var topView:StatusTopView = StatusTopView()
    // cell中间文本视图
    lazy var textView:UILabel = UILabel(text: "正文", fontSize: 12, textColor: UIColor.darkGray, margin: statusMargin)
    // cell图片视图
    fileprivate lazy var picturesView:StatusPicturesView = StatusPicturesView()
    // cell底部视图
    fileprivate lazy var bottomView:StatusBottomView = StatusBottomView()
    // status模型
    var status:Status?{
        didSet{
            topView.userIconView.sd_setImage(with: URL(string:(status?.user?.profile_image_url)!), placeholderImage: nil)
            topView.userNameLabel.text = (status?.user?.screen_name)!

            textView.text = status?.text
            
            picturesView.pictureURLs = status?.picArray
            
            picturesView.snp.updateConstraints { (make) in
                make.height.equalTo(picturesView.picturesViewHeight)
            }

        }
    }
    // 行高
    lazy var rowHeight:CGFloat = {
        self.contentView.layoutIfNeeded()
        return self.bottomView.frame.maxY
    }()
    
    override func layoutSubviews() {
        contentView.layoutIfNeeded()
    }
//    func rowHeight(vm: Status) -> CGFloat {
//        // 1. 记录视图模型 -> 会调用上面的 didSet 设置内容以及更新`约束`
//        status = vm
//        
//        // 2. 强制更新所有约束 -> 所有控件的frame都会被计算正确
//        contentView.layoutIfNeeded()
//        
//        // 3. 返回底部视图的最大高度
//        return bottomView.frame.maxY
//    }

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
     
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: -设置界面
extension StatusCell{
    
    
    fileprivate func setupUI(){
        
        // 添加子控件
        contentView.addSubview(topView)
        contentView.addSubview(textView)
        contentView.addSubview(picturesView)
        contentView.addSubview(bottomView)
        
        
        
        // 设置子控件约束
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(statusMargin)
            make.left.equalTo(contentView.snp.left).offset(statusMargin)
            make.right.equalTo(contentView.snp.right).offset(-statusMargin)
            make.height.equalTo(iconViewWidthHeight)
        }
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(statusMargin)
            make.left.equalTo(topView.snp.left)
        }
        picturesView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(statusMargin)
            make.left.equalTo(contentView.snp.left).offset(statusMargin)
            make.right.equalTo(contentView.snp.right).offset(-statusMargin)
            make.height.equalTo(200)
        }
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(picturesView.snp.bottom).offset(statusMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(44)
        }

    }
}

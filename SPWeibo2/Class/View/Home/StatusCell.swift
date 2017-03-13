
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
    lazy var topView:StatusTopView = StatusTopView()
    // cell中间文本视图
    lazy var textView:UILabel = UILabel(text: "正文", fontSize: 12, textColor: UIColor.darkGray, margin: statusMargin)

    // cell图片视图
    lazy var picturesView:StatusPicturesCollectionView = StatusPicturesCollectionView()
    // cell底部视图
    lazy var bottomView:StatusBottomView = StatusBottomView()
    // status模型
    var status:Status?{
        didSet{

                topView.userIconView.sd_setImage(with: URL(string:self.status?.user?.profile_image_url ?? ""), placeholderImage: UIImage(named: ""))
                self.topView.userNameLabel.text = self.status?.user?.screen_name
                self.textView.text  = self.status?.text
                picturesView.picArray = status?.picArray
                picturesView.snp.updateConstraints { (make) in
                    make.size.equalTo(picturesView.bounds.size)

            }
        }
    }
    
    // 行高计算
    var rowHeight:CGFloat{

        contentView.layoutIfNeeded()
        return bottomView.frame.maxY
 
    }
    
    
    /// 构造函数
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
    
    
    func setupUI(){
        
        selectionStyle = UITableViewCellSelectionStyle.none
        
        
        // 添加子控件
        contentView.addSubview(topView)
        contentView.addSubview(textView)
        contentView.addSubview(picturesView)
        contentView.addSubview(bottomView)

        
        // 设置约束
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(statusMargin)
            make.left.equalTo(contentView.snp.left).offset(statusMargin)
            make.right.equalTo(contentView.snp.right).offset(-statusMargin)
            make.height.equalTo(44)
        }
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(statusMargin)
            make.left.equalTo(contentView.snp.left).offset(statusMargin)

        }
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(picturesView.snp.bottom).offset(statusMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(44)
        }
        
        contentView.layer.isOpaque = true
    }
}

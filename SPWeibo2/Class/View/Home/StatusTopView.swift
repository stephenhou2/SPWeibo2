//
//  StatusTopView.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/5.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class StatusTopView: UIView {
    
    // 用户头像view
    lazy var userIconView:UIImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    // 用户昵称view
    lazy var userNameLabel:UILabel = UILabel(text: "用户昵称")
    // 用户vip view
    lazy var vipView:UIImageView = UIImageView(image: UIImage(named:
        "common_icon_membership_expired"))
    // 用户认证view
    lazy var verifiedView:UIImageView = UIImageView(image: UIImage(named:"avatar_vip"))
    // 用户微博发送时间
    lazy var creatTimeLabel:UILabel = UILabel(text: "刚刚")
    

    
    
    
/// 绘制头像圆形遮罩
    override func draw(_ rect: CGRect) {

        let maskCenter = CGPoint(x:  iconViewWidthHeight / 2, y:  iconViewWidthHeight / 2)
        let path = UIBezierPath(arcCenter: maskCenter, radius: iconViewWidthHeight / 2, startAngle: 0, endAngle: CGFloat(2.0 * M_PI), clockwise: true)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        userIconView.layer.mask = maskLayer
        
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setupUI()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}




// MARK: -设置statusCell顶部view的布局和风格
extension StatusTopView{
    fileprivate func setupUI(){
        
        backgroundColor = UIColor.white
        
        // 添加子控件
        addSubview(userIconView)
        addSubview(userNameLabel)
        addSubview(vipView)
        addSubview(verifiedView)
        
        
        // 添加约束
        // 用户头像
        userIconView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.size.equalTo(CGSize(width: iconViewWidthHeight, height: iconViewWidthHeight))
        }
        // 用户昵称label
        userNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userIconView.snp.top).offset(statusMargin)
            make.left.equalTo(userIconView.snp.right).offset(statusMargin)
            
        }
        // 用户vip view
        vipView.snp.makeConstraints { (make) in
            make.centerY.equalTo(userNameLabel.snp.centerY)
            make.left.equalTo(userNameLabel.snp.right).offset(statusMargin)
        }
        verifiedView.snp.makeConstraints { (make) in
            make.right.equalTo(userIconView.snp.right)
            make.bottom.equalTo(userIconView.snp.bottom)
        }
        
//        userIconView.layer.cornerRadius = 20
//        userIconView.clipsToBounds = true
    }
}

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
    
    fileprivate let iconWidthHeight:CGFloat = 44
    
    
    
/// 绘制头像圆形遮罩
    override func draw(_ rect: CGRect) {
        
        // 遮罩路径
        let radius = iconWidthHeight / 2
        let center = CGPoint(x: radius, y: radius)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true).cgPath
        
        // 创建遮罩层
        let shapeLayer = CAShapeLayer()
        // 遮罩路径
        shapeLayer.path = path
        
        // t头像图层的遮罩层绑定
        userIconView.layer.mask = shapeLayer
        
        layer.isOpaque = true
        
        
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
        userIconView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.size.equalTo(CGSize(width: iconWidthHeight, height: iconWidthHeight))
        }
        userNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userIconView.snp.top).offset(statusMargin)
            make.left.equalTo(userIconView.snp.right).offset(statusMargin)
        }
        vipView.snp.makeConstraints { (make) in
            make.centerY.equalTo(userNameLabel.snp.centerY)
            make.left.equalTo(userNameLabel.snp.right)
        }
        verifiedView.snp.makeConstraints { (make) in
            make.right.equalTo(userIconView.snp.right)
            make.bottom.equalTo(userIconView.snp.bottom)
        }
    }
}

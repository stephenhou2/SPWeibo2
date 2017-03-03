//
//  VisitorView.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/2.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit


protocol VisitorViewDelegate {
    func visitorViewLoginButtonClicked()
    func visitorViewRegisterButtonClicked()
}



class VisitorView: UIView {
    
    // 背景图片
    fileprivate var backgroudImageView:UIImageView?
    // 用户头像
    fileprivate var iconView:UIImageView?
    // 用户昵称
    fileprivate var textLabel:UILabel?
    // 遮罩图片
    fileprivate lazy var maskImageView:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    // 登录按钮
    fileprivate lazy var loginButton:UIButton = UIButton(title: "登录", imageName: nil, backgroundImageName: "common_button_white_disable", titleColor: UIColor.orange)
    // 注册按钮
    fileprivate var registerButton:UIButton = UIButton(title: "注册", imageName: nil, backgroundImageName: "common_button_white_disable", titleColor: UIColor.orange)
    
    fileprivate lazy var animation:CABasicAnimation = CABasicAnimation()
    
    // 代理，负责按钮的监听和响应
    var delegate:VisitorViewDelegate?

    convenience init() {
        self.init(frame: screenRect)
        backgroundColor = UIColor(white: 234/255.0, alpha: 1.0)
    }
    override init(frame:CGRect){
        super.init(frame: screenRect)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   

}
// MARK: -自定义的一些方法
extension VisitorView{
    
    // 登录按钮响应方法
    @objc fileprivate func loginButtonClicked(){
        delegate?.visitorViewLoginButtonClicked()
    }
    
    
    
    // 注册按钮响应方法
    @objc fileprivate func registerButtonClicked(){
        delegate?.visitorViewRegisterButtonClicked()
    }
    
    /// 设置背景图片动画
    fileprivate func backgroundImageStartAnimate(){
        
        animation.toValue = M_PI * 2
        animation.repeatCount = MAXFLOAT
        animation.duration = 20
        animation.isRemovedOnCompletion = false
        
        backgroudImageView?.layer.add(animation, forKey: "transform.rotation")
    }

    
    
}


// MARK:- 设置控件布局和风格
extension VisitorView{
    func setupUI(backgroudImageName:String,iconName:String?,text:String){
        
        // 加载内容
        backgroudImageView = UIImageView(image: UIImage(named: backgroudImageName))
        guard let iconName = iconName else { return }
        iconView = UIImageView(image:UIImage(named:iconName))
        textLabel = UILabel(text: text)
        
        // 添加子控件
        addSubview(backgroudImageView!)
        addSubview(maskImageView)
        addSubview(iconView!)
        addSubview(textLabel!)
        addSubview(loginButton)
        addSubview(registerButton)
        
        // 登录和注册按钮添加响应方法
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        
        // 子控件布局
        setLayout()
        
        // 背景图片开始动画
        if(iconView != nil){
            backgroundImageStartAnimate()
        }
    }
    
    
    
    
    
    /// 设置子控件的layout和风格
    private func setLayout(){
        
        // 中间背景图片的layout
        backgroudImageView?.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-100)
            
        }
        maskImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(loginButton.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
        
        // 中间图标的layout
        iconView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((backgroudImageView?.snp.centerX)!)
            make.centerY.equalTo((backgroudImageView?.snp.centerY)!)
        })
        
        // 文本label
        textLabel?.snp.makeConstraints{ (make) in
            make.top.equalTo((backgroudImageView?.snp.bottom)!).offset(16)
            make.centerX.equalTo((backgroudImageView?.snp.centerX)!)
            make.size.equalTo(CGSize(width: 240, height: 36))
        }
        
        // 登录按钮
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo((textLabel?.snp.bottom)!).offset(16)
            make.left.equalTo((textLabel?.snp.left)!)
            make.size.equalTo(CGSize(width: 100, height: 36))
        }
        
        // 注册按钮
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo((textLabel?.snp.bottom)!).offset(16)
            make.right.equalTo((textLabel?.snp.right)!)
            make.size.equalTo(CGSize(width: 100, height: 36))
        }
        
    }

}

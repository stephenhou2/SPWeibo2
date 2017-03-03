//
//  NewFeatureCell.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/2.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class NewFeatureCell: UICollectionViewCell {
    
    fileprivate lazy var backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
    var backgroudImage:UIImage?{
        didSet{
             backgroundImageView.image = backgroudImage
        }
    }
    
    lazy var confirmButton:UIButton = {
       UIButton(title: "开始玩耍", imageName: nil, backgroundImageName: "new_feature_finish_button")
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.backgroundImageView)
        addSubview(confirmButton)
        setupConfirmButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    func startAnimation(){
        self.confirmButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: { 
            self.confirmButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    
}

// MARK: -自定义的一些方法
extension NewFeatureCell{
    
    @objc fileprivate func confirmButtonClicked(){
        NotificationCenter.default.post(name: WBSwitchRootViewControllerNotification, object: nil, userInfo: ["sender":WBSwitchRootVCNotificationSender.NewFeature])
    }
}



/// MARK: -子控件的布局和风格
extension NewFeatureCell{
 
   fileprivate func setupConfirmButton(){
        confirmButton.isHidden = true
        confirmButton.setTitleColor(UIColor.white, for: .normal)
        confirmButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).multipliedBy(0.8)
            make.centerX.equalTo(self.snp.centerX)
        }
    
    confirmButton.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
    }

}

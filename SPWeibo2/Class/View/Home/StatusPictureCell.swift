//
//  StatusPictureCell.swift
//  Weibo10
//
//  Created by 侯亮宏 on 17/3/8.
//  Copyright © 2017年 itheima. All rights reserved.
//

import UIKit
import SDWebImage


class StatusPictureCell: UICollectionViewCell {
    
    private var picView:UIImageView?
    var picURLStr:String?{
        didSet{
        self.picView?.sd_setImage(with: URL(string:picURLStr ?? ""),
                                  placeholderImage: nil,
                            options:[SDWebImageOptions.retryFailed,SDWebImageOptions.refreshCached])    // SD 超时时长 15s，一旦超时会记入黑名单

        }
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        let picView = UIImageView()
        self.picView = picView
        picView.contentMode = .scaleAspectFill
        picView.clipsToBounds = true
        
        
       contentView.addSubview(picView)
       contentView.layer.isOpaque = true
        picView.frame = contentView.frame
    
    }
    
}


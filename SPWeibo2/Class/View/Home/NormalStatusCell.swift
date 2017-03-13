//
//  NormakStatusCell.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/9.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class NormalStatusCell: StatusCell {

    override func setupUI() {
        super.setupUI()
        
        picturesView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(statusMargin)
            make.left.equalTo(contentView.snp.left).offset(statusMargin)
            make.size.equalTo(CGSize(width: 50, height:50))
        }

        
    }

}

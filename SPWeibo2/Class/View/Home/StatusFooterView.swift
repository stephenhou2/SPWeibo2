//
//  StatusFooterView.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/10.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class StatusFooterView: UITableViewHeaderFooterView {


    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        let textLabel = UILabel(text: "上拉显示更多")
        addSubview(textLabel)
        
        textLabel.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        })
    }
}

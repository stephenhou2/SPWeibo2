//
//  StatusesView.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/4.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class StatusesView: UITableView {

    init() {
        super.init(frame: screenRect, style: UITableViewStyle.plain)
            }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    

}

// MARK: -自定义方法
extension StatusesView{
    
//    fileprivate func loadStatues(){
//        NetworkTool.sharedManager.loadStatues()
//
//    }
}

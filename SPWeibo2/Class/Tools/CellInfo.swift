//
//  File.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/10.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class CellInfo{
    
    var cellHeights:[CGFloat]
    var cellReuseIds:[String]
    


    
    init(cellHeights:[CGFloat],cellReuseIds:[String]) {
        self.cellHeights = cellHeights
        self.cellReuseIds = cellReuseIds
    }
}

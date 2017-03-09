//
//  ArrayDynamicRowHeightTool.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/7.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class ArrayDynamicRowHeightTool: ArrayTableViewTool {
    
    // 行高
    var rowHeights:[CGFloat]?
    
    // 如果异步获取数据需要在去的数据后刷新dataArray 和 rowHeights
    
    func updateData(dataArray:[AnyObject]?,rowHeights:[CGFloat]?,configureCellBlock:((AnyObject,AnyObject)->())?){
        super.updateData(dataArray: dataArray, configureCellBlock: configureCellBlock)
        self.rowHeights = rowHeights
    }
    
    // 确定动态行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return  rowHeights == nil ? 0 : rowHeights![indexPath.row]
   
    }
    

    
}

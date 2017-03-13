//
//  ArrayDynamicRowHeightTool.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/7.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class ArrayDynamicTableViewTool: ArrayTableViewTool {
    

    
    
    // 确定动态行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return cellInfo == nil ? 0 : cellInfo!.cellHeights[indexPath.row]
   
    }
    

    
}

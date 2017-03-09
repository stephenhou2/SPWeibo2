//
//  ArrayDataSourceTool.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/7.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class ArrayTableViewTool: NSObject,UITableViewDataSource,UITableViewDelegate {
    
    
    
    
    private var dataArray:[AnyObject]?
    private var reuseIdentifier:String?
    private var configureCellBlock:(AnyObject,AnyObject)->()
    
    // 初始化方法
    init(dataArray:[AnyObject],reuseIdentifier:String,configereCellBlock:@escaping (AnyObject,AnyObject)->()){
        self.dataArray = dataArray
        self.reuseIdentifier = reuseIdentifier
        self.configureCellBlock = configereCellBlock
        super.init()
    }
    
    convenience init(dataArray:[AnyObject],reuseIdentifier:String,configereCellBlock:@escaping (AnyObject,AnyObject)->(),rowHeight:CGFloat){
        
    }
    
    // 确定行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    // 创建cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier!, for: indexPath)
        return cell
        
    }
    // 绑定数据
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let item = dataArray![indexPath.row]
         configureCellBlock(cell!,item)
    }
    
}

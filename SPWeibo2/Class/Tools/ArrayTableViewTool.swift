//
//  ArrayDataSourceTool.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/7.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class ArrayTableViewTool: NSObject,UITableViewDataSource,UITableViewDelegate {
    
    
    
    // 数据源
    private var dataArray:[AnyObject]?
    // cell可重用标示
    private var cellReuseIdentifiers:[String]?
    // 完成回调
    private var configureCellBlock:((AnyObject,AnyObject)->())?
    
    // headerFooterView可重用标识
    private var headerFooterViewReuseIdentifier:String?

    var cellInfo:CellInfo?

    /// 判断是否是向下滑动
    var crossDownwards = true
    
    
    // 构造方法
    init(tableView:UITableView,rowHeight:CGFloat?,
         cellRegisterInfo:[String:AnyClass],
         headerFooterViewReuseIdentifier:String?,
         registerHeaderFooterViewClass:AnyClass?){
        super.init()
        
        // 设置代理，注册cell
        tableView.delegate = self
        tableView.dataSource = self
        
        // 注册headerFooterView
        if let registerHeaderFooterViewClass = registerHeaderFooterViewClass,headerFooterViewReuseIdentifier != nil{
            tableView.register(registerHeaderFooterViewClass, forHeaderFooterViewReuseIdentifier: headerFooterViewReuseIdentifier!)
            self.headerFooterViewReuseIdentifier = headerFooterViewReuseIdentifier!
            
        }
        
        // 注册cell
        for key in cellRegisterInfo.keys{
            tableView.register(cellRegisterInfo[key], forCellReuseIdentifier: key)
        }

        
        // 设置默认行高
        if rowHeight != nil{
            tableView.rowHeight = rowHeight!
        }
        
        
    }
    convenience init(tableView:UITableView,cellRegisterInfo:[String:AnyClass]){
        self.init(tableView:tableView,
                  rowHeight:nil,
                  cellRegisterInfo:cellRegisterInfo,
                  headerFooterViewReuseIdentifier:nil,
                  registerHeaderFooterViewClass:nil)
    }
    
    // 更新数据，完成回调
    func updateData(dataArray:[AnyObject]?,cellInfo:CellInfo,configureCellBlock:((AnyObject,AnyObject)->())?){

        self.dataArray = dataArray
        self.configureCellBlock = configureCellBlock
        self.cellInfo = cellInfo
    }
    
    // 确定行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    // 创建cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
   
        let cell = tableView.dequeueReusableCell(withIdentifier: cellInfo!.cellReuseIds[indexPath.row], for: indexPath)
        return cell
        
    }
    // 绑定cell数据
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let item = dataArray![indexPath.row]
        if let configureCellBlock = self.configureCellBlock{
            configureCellBlock(cell,item)
        }
    }
    
    
    
    // 创建headerFooterView
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerFooterViewReuseIdentifier!)
        return footerView
    }
    // 设置顶部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    // 设置底部高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }

}

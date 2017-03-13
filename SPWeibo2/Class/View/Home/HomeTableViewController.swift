//
//  HomeTableViewController.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/1.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit


class HomeTableViewController: UserViewController {

    let normalStatusReuseIdentifier = "normalStatusIdentifier"
    let retweetedStatusReuseIdentifier = "retweetedStatusReuseIdentifier"
    let headerFooterViewReuseIdentifier = "headerFooterViewReuseIdentifier"
    /// 用户首页最新微博
    fileprivate var statuses:[Status] = [Status]()
    fileprivate var loadNew:Bool = true
    /// 微博的id
    fileprivate var since_id:Int{
        return loadNew ? (statuses.first?.id ?? 0) : 0
    }
    fileprivate var max_id:Int{
        guard !loadNew else{
            return 0
        }
        guard statuses.last?.id != nil else{
            return 0
        }
        return  (statuses.last?.id)! - 1
    }
    
    private lazy var footerView:UIView = StatusFooterView(reuseIdentifier: self.headerFooterViewReuseIdentifier)
    
    /// 行高数组
    fileprivate var statusCellInfo:CellInfo{
        return checkCellInfo()
    }

    
    
    /// tableView管类类工具
    fileprivate var dataSourceAndDelegateTool:ArrayDynamicTableViewTool?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 如果进入访客视图，加载访客视图的相关资源
        guard visitor == nil else {
            visitor!.setupUI(backgroudImageName: "visitordiscover_feed_image_smallicon", iconName:
                "visitordiscover_feed_image_house", text: "npanpengpabwpegasnfgpiaewgbsepongpawebbkkkkkkkkkkk")
            return
        }
        
        // 进入用户界面
        /// 设置界面风格
        setupStyle()
        
        //初始化tableView管理工具
        dataSourceAndDelegateTool = ArrayDynamicTableViewTool(tableView: self.tableView,
                                                              rowHeight:nil,
                                                              cellRegisterInfo: [normalStatusReuseIdentifier:NormalStatusCell.self,
                                                                            retweetedStatusReuseIdentifier:RetweetedStatusCell.self],
                                                              headerFooterViewReuseIdentifier:headerFooterViewReuseIdentifier,
                                                              registerHeaderFooterViewClass:StatusFooterView.self)
        
        /// 加载用户首页微博信息
        loadNewStatuses()
        
        NotificationCenter.default.addObserver(forName: WBHomeLoadEarlierStatusesNofification, object: tableView.delegate, queue: nil) {[weak self](notification) in
            self?.loadEarlierStatues()
            
            
        
            
        }
  
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
   
}

// MARK: - 自定义方法
extension HomeTableViewController{
    
    @objc fileprivate func loadStatues(completion:(()->())?){
        
        /// 获取网络数据方法
        NetworkTool.sharedManager.loadStatues(since_id:since_id, max_id:max_id) { (responseObject) in

            
            DispatchQueue.global().async(execute: { 
                var items = [Status]()
                for item in responseObject{
                    let status = Status(dic: item as! [String:AnyObject])
                    items.append(status)
                }
                if self.loadNew{
                    self.statuses = items + self.statuses
                }
                else{
                    self.statuses = self.statuses + items
                }
                /// 加载网络数据
                self.dataSourceAndDelegateTool?.updateData(dataArray: self.statuses,cellInfo:self.statusCellInfo){
                    (cell, item) in
                    let statusCell = cell as! StatusCell
                    let status = item as! Status
                    statusCell.status = status
                    
                }
                // 重新显示数据
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    if completion != nil {
                        completion!()
                    }
                })
            })
            
        }
        
    }
    /// 设置界面风格
    fileprivate func setupStyle(){
        
        tableView.estimatedRowHeight = 600
        tableView.separatorStyle = .none
        tableView.layer.isOpaque = true
        
        
        if #available(iOS 10.0, *) {
            refreshControl = RefreshControlView(refreshBlock: loadNewStatuses)
            refreshControl?.isEnabled = true

        } else {
            // Fallback on earlier versions
            print("不支持refreshcontrol")
        }
   
    }
    
    
    /// cell信息
    fileprivate func checkCellInfo()->CellInfo{
        
        var statusCellHeights = [CGFloat]()
        var statusCellReuseIds = [String]()
        for i in 0..<self.statuses.count{
            let status = self.statuses[i]
            let statusCell:StatusCell
            let statusCellReuseId:String
            if status.retweeted_status != nil{
                statusCell = RetweetedStatusCell(style: .default, reuseIdentifier: retweetedStatusReuseIdentifier)
                statusCellReuseId = retweetedStatusReuseIdentifier
            }
            else {
                statusCell = NormalStatusCell(style:.default, reuseIdentifier: normalStatusReuseIdentifier)
                statusCellReuseId = normalStatusReuseIdentifier
            }
            statusCell.status = status
            let rowHeight = statusCell.rowHeight
            statusCellHeights.append(rowHeight)
            statusCellReuseIds.append(statusCellReuseId)
        }
        return CellInfo(cellHeights: statusCellHeights, cellReuseIds: statusCellReuseIds)

    }
    
    
    
    // 加载新微博
    func loadNewStatuses(){
        
        if since_id == 0 && max_id == 0{
            
            loadStatues(completion: nil)
        }
        else{
            loadNew = true
            loadStatues {
            // 停止刷新菊花的动作
            self.refreshControl?.endRefreshing()
            }
        }
    }
    
    // 加载老微博
    func loadEarlierStatues(){
        loadNew = false
        if max_id != 0{
            loadNew = false
            loadStatues(completion: nil)
        }
    }

}

/// MARK: - 代理方法
extension ArrayTableViewTool{

    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        NotificationCenter.default.post(name: WBHomeLoadEarlierStatusesNofification, object: self)
    }
 
}



//
//  HomeTableViewController.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/1.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

let statusReuseIdentifier = "Status"


class HomeTableViewController: UserViewController {

    
    // 用户首页最新微博
    fileprivate var statuses:[Status] = [Status]()
    
    fileprivate lazy var statuesCellHeights:[CGFloat] = {
       
        var statuesCellHeights = [CGFloat]()
        for i in 0..<self.statuses.count{
            let statusCell = StatusCell(style: .default, reuseIdentifier: statusReuseIdentifier)
            statusCell.status = self.statuses[i]
//            let cellHeight = statusCell.rowHeight(vm: self.statuses[i])
            let cellHeight = statusCell.rowHeight
            statuesCellHeights.append(cellHeight)
        }
        return statuesCellHeights
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 如果进入访客视图，加载访客视图的相关资源
        guard visitor == nil else {
            visitor!.setupUI(backgroudImageName: "visitordiscover_feed_image_smallicon", iconName:
                "visitordiscover_feed_image_house", text: "npanpengpabwpegasnfgpiaewgbsepongpawebbkkkkkkkkkkk")
            return
        }
        
        tableView.estimatedRowHeight = 200
//        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // 如果进入用户界面，加载用户首页微博信息
       
        // 注册显示的cell
        tableView.register(StatusCell.self, forCellReuseIdentifier: statusReuseIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        
        loadStatues()
        
        
        
    }

   
}

// MARK: - 自定义方法
extension HomeTableViewController{
    
    fileprivate func loadStatues(){
        NetworkTool.sharedManager.loadStatues { (responseObject) in
            guard responseObject != nil else{
                print("数据获取失败")
                return
            }
            let statuses = responseObject as! [[String:AnyObject]]
            for statusDic in statuses{
                let status = Status(dic:statusDic)
                self.statuses.append(status)
            }
            self.tableView.reloadData()
        }
        
    }
}


// MARK: -数据源方法
extension HomeTableViewController{
    
    
    //／ 行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses.count
    }
    
    /// cell初始化
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 创建cell
        let cell = tableView.dequeueReusableCell(withIdentifier: statusReuseIdentifier, for: indexPath) as? StatusCell
        
        // 这里不要进行数据绑定
//        cell?.status = statuses[indexPath.row]
        
        return cell!

    }
//    /// 这里进行数据绑定
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 获取即将显示的cell
        let statusCell = cell as! StatusCell
        // 给cell绑定数据
        statusCell.status = statuses[indexPath.row]

        
    }
    // 计算行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return statuesCellHeights[indexPath.row]
    }

}

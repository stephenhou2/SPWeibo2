//
//  RefreshControlView.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/9.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit


class RefreshControlView: UIRefreshControl {
    
    fileprivate lazy var pullView:UIView = UIView()
    fileprivate lazy var arrowView = UIImageView(image:#imageLiteral(resourceName: "tableview_pull_refresh"))
    fileprivate lazy var pullLabel:UILabel = UILabel(text: "下拉刷新",fontSize:14, textColor:UIColor.darkGray,margin:0)
    
    fileprivate lazy var loadingView:UIView = UIView()
    fileprivate lazy var spinView = UIImageView(image: #imageLiteral(resourceName: "tableview_loading"))
    fileprivate lazy var loadingLabel = UILabel(text: "正在加载中", fontSize: 14, textColor: UIColor.darkGray)
    
    fileprivate lazy var rotationKey = "transform.rotation"
    
    // 刷新数据的回调
    fileprivate var refreshBlock:()->()
    
    // 构造函数
    init(refreshBlock:@escaping ()->()){
        self.refreshBlock = refreshBlock
        super.init()
        tintColor = UIColor.clear
        backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        setupUI()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    // 重写开始刷新方法
    override func beginRefreshing() {
        super.beginRefreshing()
        // 开始刷新菊花的动作
        startSpinViewAnimation()
        refreshBlock()
        
    }
    
    // 重写结束刷新方法
    override func endRefreshing() {
        super.endRefreshing()
        self.spinView.layer.removeAnimation(forKey: rotationKey)
        
    }

    
}

extension RefreshControlView{
    
    // 开始箭头旋转动画
    func startArrowAnimation(crossDownwards:Bool){
        
       
        // 箭头动画
        let angle:CGFloat = crossDownwards ? CGFloat(M_PI) - 0.000001 : 0
        pullLabel.text = (!crossDownwards) ? " 下拉刷新" : "可以松手了"
        let keyPath = "transform.rotation"
        let anim = CABasicAnimation(keyPath: keyPath)
        anim.toValue = angle
        anim.duration = 0.5
        anim.repeatCount = 1
        arrowView.layer.add(anim, forKey: keyPath)
        /// 使用CABasicAnimation时，原始图层不会动，执行动画的是系统拷贝的一个缓存，动画结束后该图层缓存默认会被清除，因此必须把原图层的位置尽心改变
        self.arrowView.transform = CGAffineTransform(rotationAngle: angle)
  
    }
    
    // 开始loading旋转动画
    func startSpinViewAnimation(){
        DispatchQueue.main.async {
            let anim = CABasicAnimation(keyPath: self.rotationKey)
            anim.toValue = 2 * M_PI
            anim.repeatCount = MAXFLOAT
            anim.duration = 0.5
            anim.isRemovedOnCompletion = false
            self.spinView.layer.add(anim, forKey: self.rotationKey)
            self.loadingView.isHidden = false
            
        }

    }
    
    
}

// 代理方法
extension ArrayTableViewTool{
    
    // 滚动过程中判断箭头动画是否执行
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        DispatchQueue.global().async {
            if #available(iOS 10.0, *) {
                let refreshControlView = (scrollView as!UITableView).refreshControl as! RefreshControlView
                
                if contentOffsetY <= -64 && self.crossDownwards{
                    
                    refreshControlView.startArrowAnimation(crossDownwards:self.crossDownwards)
                    self.crossDownwards = !self.crossDownwards
                }
                else if contentOffsetY > -64 && !self.crossDownwards{
                    refreshControlView.startArrowAnimation(crossDownwards:self.crossDownwards)
                    self.crossDownwards = !self.crossDownwards
                }
                
                
                
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
//    // 停止拖动时判断是否要开始刷新数据
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        DispatchQueue.global().async { 
            
            if #available(iOS 10.0, *) {
                let refreshControlView = (scrollView as!UITableView).refreshControl as! RefreshControlView
                if scrollView.contentOffset.y <= -64{
                    // 刷新网络数据
                    DispatchQueue.main.async(execute: { 
                         refreshControlView.beginRefreshing()
                    })
                   
                    
                    
                }
            } else {
                // Fallback on earlier versions
            }
            if scrollView.contentOffset.y <= -scrollView.contentSize.height + screenHeight{
                DispatchQueue.main.async(execute: { 
                    scrollView.setContentOffset(CGPoint(x:0, y:-scrollView.contentSize.height + screenHeight), animated: true)
                })
            }
        }
        
    }
    // 回弹到原始位置时loadingView隐藏
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if #available(iOS 10.0, *) {
            let refreshControlView = (scrollView as!UITableView).refreshControl as! RefreshControlView
            if scrollView.contentOffset.y >= 0{
                refreshControlView.loadingView.isHidden = true
                
            }
        } else {
            // Fallback on earlier versions
        }

    }
}

/// MARK: - 设置布局和风格
extension RefreshControlView{

    fileprivate func setupUI(){
        
        // 加载子控件
        pullView.addSubview(arrowView)
        pullView.addSubview(pullLabel)
        
        loadingView.addSubview(spinView)
        loadingView.addSubview(loadingLabel)
        loadingView.backgroundColor = UIColor.white
        loadingView.layer.isOpaque = true
        
        addSubview(pullView)
        addSubview(loadingView)
        print(loadingView.frame)
        loadingView.isHidden = true
        
        // 设置约束
        
        pullView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }
        loadingView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }
        
        /// 下拉刷新view
        arrowView.snp.makeConstraints { (make) in
            make.centerY.equalTo(pullView.snp.centerY)
            make.left.equalTo(pullView.snp.left).offset(bounds.size.width * 0.4)
            make.size.equalTo(arrowView.bounds.size)
        }
        pullLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(pullView.snp.centerY)
            make.left.equalTo(arrowView.snp.right)
            
        }
        

        // 正在加载view
        let iconW = spinView.bounds.size.width
        let iconH = spinView.bounds.size.height
        
        let loadingText = "正在加载中"
        
        let labelSize = (loadingText as NSString).boundingRect(with:CGSize(width: screenWidth, height: CGFloat(MAXFLOAT)),options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 14)], context: nil).size
        let viewW = bounds.size.width
        let viewH = bounds.size.height
        
        
        let iconX = viewW * 0.4
        let iconY = (viewH - iconH) / 2
        
        spinView.frame = CGRect(x: iconX, y: iconY, width: iconW, height: iconH)
        
        let labelX = iconX + iconW
        let labelY = (viewH - labelSize.height) / 2
        
        loadingLabel.frame = CGRect(origin: CGPoint(x:labelX,y:labelY), size: labelSize)
        
        
    }
    
}

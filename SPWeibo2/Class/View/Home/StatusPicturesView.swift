//
//  StatusImagesView.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/5.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit
import SDWebImage




class StatusPicturesView: UICollectionView {
    
    
    
    // 可重用标示
    fileprivate let picCellReuseIdentifier = "picCell"
    // 图片地址数组
    var pictureURLs:[String]? = [String](){
        didSet{
            setupLayout()
            reloadData()
        }
    }
    // 图片间距
    private let pictureMargin:CGFloat = 8
    // layout
    fileprivate var layout:UICollectionViewFlowLayout?
    
    var picturesViewHeight:CGFloat{
        let rowCount = (pictureURLs!.count - 1) / 3 + 1
        let viewH = (layout!.itemSize.height + pictureMargin) * CGFloat(rowCount) - pictureMargin
        return viewH
    }
    // 初始化collectionView
    init(){
        
        let layout = UICollectionViewFlowLayout()
        
        
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        
        self.layout = layout
        
        dataSource = self
        delegate = self
        
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: picCellReuseIdentifier)
        backgroundColor = UIColor.white
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout(){
        
        layout!.minimumLineSpacing = pictureMargin
        layout!.minimumInteritemSpacing = pictureMargin
        
        
        
        let picWidth = Int(screenWidth - 2 * statusMargin - 2 * pictureMargin) / 3
        print("width:\(picWidth)")
        if self.pictureURLs!.count == 0{
            layout!.itemSize = CGSize(width: 0, height: 0)
        }
        else if self.pictureURLs!.count == 1{
            layout!.itemSize = CGSize(width: 120, height: 150)
        }
        else if self.pictureURLs!.count == 4{
            layout!.itemSize = CGSize(width: picWidth + 1, height: picWidth + 1)
        }
        else {
            layout!.itemSize = CGSize(width: picWidth, height: picWidth)
            
        }

    }
    
    
   }

extension StatusPicturesView:UICollectionViewDataSource,UICollectionViewDelegate{

    // 设置cell数量
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureURLs!.count
        

    }
    
    // 创建cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picCellReuseIdentifier, for: indexPath)
        return cell
    }
    
    // 显示前加载数据
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        let picView = UIImageView(frame: cell.contentView.bounds)
        guard let picURL = pictureURLs?[indexPath.item] else{
            return
        }
        picView.sd_setImage(with: URL(string:picURL), placeholderImage: nil, options:[SDWebImageOptions.retryFailed,    // SD 超时时长 15s，一旦超时会记入黑名单
            SDWebImageOptions.refreshCached])
        cell.contentView.addSubview(picView)
    }
    
    
}


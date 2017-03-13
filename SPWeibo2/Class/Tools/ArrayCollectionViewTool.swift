//
//  ArrayCollectionViewTool.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/7.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class ArrayCollectionViewTool:NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
    
    // 重用标示
    private let reuseIdentifier:String
    // 数据源数组
    private var dataArray:[AnyObject]?
    // 完成回调
    private var configureCellBlock:((AnyObject,AnyObject)->())?
    
    // 初始化方法
    init(collectionView:UICollectionView,reuseIdentifier:String,cellRegisterClass:AnyClass){
        self.reuseIdentifier = reuseIdentifier
        super.init()
        
        // 注册cell
        collectionView.register(cellRegisterClass, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func updateData(dataArray:[AnyObject]?,configureCellBlock:@escaping (AnyObject,AnyObject)->()){
        self.dataArray = dataArray
        self.configureCellBlock = configureCellBlock
    }
    
    
    // 确认cell个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray!.count
    }
    
    // 创建cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
    // 数据绑定
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let item = dataArray![indexPath.item] as AnyObject
        if let configureCellBlock = self.configureCellBlock{
            configureCellBlock(cell,item)
        }

    }
    
}

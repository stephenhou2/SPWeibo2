//
//  StatusImagesView.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/5.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit
import SDWebImage




class StatusPicturesCollectionView: UICollectionView {
    
    // 图片间距
    let picMargin:CGFloat = 5
    
    var picArray:[String]? = [String](){
        didSet{
            
            sizeToFit()
            
            arrayDataSourceDelegate?.updateData(dataArray: picArray as [AnyObject]?, configureCellBlock: { (cell, item) in
                let cell = cell as! StatusPictureCell
                let picUrl = item as? String
                cell.picURLStr = picUrl
            })
            
            reloadData()
        }
    }
    
    
    fileprivate let statusPicReuseIdentifier = "statusPic"
    
    private var arrayDataSourceDelegate:ArrayCollectionViewTool?
    
    
    init(){
        
        let layout = SPCollectionViewFlowLayout(minimumLineSpacing: picMargin, minimumInteritemSpacing: picMargin)
        super.init(frame: CGRect.zero, collectionViewLayout:layout)
        
        setupStyle()
        
        
        setupCollectionView()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupStyle(){
        // 不允许滚动
        isScrollEnabled = false
        // 设置背景色
        backgroundColor = UIColor(white: 0.9 , alpha: 1.0)
        layer.isOpaque = true
    }
    
    private func setupCollectionView(){
        arrayDataSourceDelegate = ArrayCollectionViewTool(collectionView: self,
                                                              reuseIdentifier: statusPicReuseIdentifier,
                                                              cellRegisterClass:StatusPictureCell.self)
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 配图数量
        let picCount = picArray!.count
        
        // 配图大小
        let picWidthHeight:CGFloat = (screenWidth - statusMargin * 2 - picMargin * 2) / 3
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSize(width: picWidthHeight , height: picWidthHeight )
        
        let rowCount = CGFloat((picArray!.count - 1) / 3 + 1)
        
        let w = screenWidth - statusMargin * 2
        
        // 没有配图
        if picCount == 0{
            return CGSize.zero
        }
        // 一张配图
        else if picCount == 1{
            return CGSize(width: 150, height: 150)

        }
        // 四张配图
        else if picCount == 4{
            let h = picWidthHeight * 2 + picMargin
            let w = picWidthHeight * 2 + picMargin
            layout.itemSize = CGSize(width: picWidthHeight , height: picWidthHeight)
            return CGSize(width: w , height: h )

        }
        // 其他情况
        else {
            
            let h = picWidthHeight * rowCount + picMargin * (rowCount - 1)
            return CGSize(width: w , height: h )
        }
        
    }
    
    
    
}

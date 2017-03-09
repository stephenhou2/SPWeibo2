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
    
    // 图片间距
    let picMargin:CGFloat = 5
    
    var picArray:[String]?{
        didSet{
            
            sizeToFit()

            self.setupCollectionView()
            
        }
    }
    
    
    fileprivate let statusPicReuseIdentifier = "statusPic"
    
    
    
    init(){
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = CGFloat(picMargin)
        layout.minimumInteritemSpacing = CGFloat(picMargin)
        
        super.init(frame: CGRect.zero, collectionViewLayout:layout)
        
        register(StatusPictureCell.self, forCellWithReuseIdentifier: statusPicReuseIdentifier)
        
        backgroundColor = UIColor.white
        
        isScrollEnabled = false
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView(){
        let arrayDataSourceDelegate = ArrayCollectionViewTool(dataArray: picArray as [AnyObject]?, reuseIdentifier: statusPicReuseIdentifier) {(cell, item) in
            let cell = cell as! StatusPictureCell
            cell.picURLStr = item as? String
            
        }
        dataSource = arrayDataSourceDelegate
        delegate = arrayDataSourceDelegate
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        // 配图数量
        let picCount = picArray!.count
        
        // 配图大小
        let picWidthHeight:CGFloat = (screenWidth - statusMargin * 2 - picMargin * 2) / 3
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: picWidthHeight, height: picWidthHeight)
        
        let rowCount = CGFloat((picArray!.count - 1) / 3 + 1)
        let colCount = CGFloat((picArray!.count - 1) % 3 + 1)
        
        // 没有配图
        if picCount == 0{
            return CGSize.zero
        }
        // 一张配图
        else if picCount == 1{
            return CGSize(width: 50, height: 50)

        }
        // 四张配图
        else if picCount == 4{
            let w = picWidthHeight * 2 + picMargin
            let h = picWidthHeight * 2 + picMargin
            return CGSize(width: w , height: h )

        }
        // 其他情况
        else {
            let w = picWidthHeight * colCount + picMargin * (colCount - 1)
            let h = picWidthHeight * rowCount + picMargin * (rowCount - 1)
            return CGSize(width: w , height: h )
        }
        
    }
    
    
    
}

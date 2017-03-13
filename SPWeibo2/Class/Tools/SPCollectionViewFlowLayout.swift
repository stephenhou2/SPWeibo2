//
//  SPCollectionViewFlowLayout.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/12.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class SPCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    
    init(minimumLineSpacing:CGFloat? = 8,minimumInteritemSpacing:CGFloat? = 8) {
        super.init()

        self.minimumLineSpacing = minimumLineSpacing!
        self.minimumInteritemSpacing = minimumInteritemSpacing!
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

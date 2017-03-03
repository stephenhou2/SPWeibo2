//
//  NewFeatureViewController.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/2.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

private let reuseIdentifier = "NewFeature"

class NewFeatureViewController: UICollectionViewController {

    private let imageNumber = 4
    private var currentPage:Int = 0{
        didSet{
            let cell = collectionView?.cellForItem(at: IndexPath(item: currentPage, section: 0)) as! NewFeatureCell
            cell.confirmButton.isHidden = currentPage != imageNumber - 1
            if currentPage == 3{
                cell.startAnimation()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false

        
        // Register cell classes
        self.collectionView!.register(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        }

    init() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIScreen.main.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("新特性析构")
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageNumber
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? NewFeatureCell
    
        cell?.backgroudImage = UIImage(named:"new_feature_\(indexPath.item + 1)")
        return cell!
    }
    
  
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! NewFeatureCell
        cell.confirmButton.isHidden = true
       
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.size.width)
    }
    
    
    
}

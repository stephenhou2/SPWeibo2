//
//  EmoticonView.swift
//  WBEmoticon
//
//  Created by 侯亮宏 on 17/3/14.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

// 底部toolBar的高度
fileprivate let bottomBarHeight:CGFloat = 36

class EmoticonView: UIView {

    fileprivate lazy var emoticonKeyboard:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmoticonLayout())
    
    fileprivate lazy var bottomBar:UIToolbar = UIToolbar()
    
    fileprivate lazy var emoticonReuseIdentifier = "emoticon"

    fileprivate lazy var emoticons:EmoticonManager = EmoticonManager.sharedManager
    
    var selectEmoticonCallBack:((Emoticon)->())?
    
    
    /// 构造函数
    init(selectEmoticonCallBack:@escaping ((Emoticon)->())){
        let emotFrame:CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 216)
        self.selectEmoticonCallBack = selectEmoticonCallBack
        super.init(frame: emotFrame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("表情键盘析构")
    }

}
// MARK: - 设置表情键盘
fileprivate extension EmoticonView{
    
    
    func setupUI(){
        
        // 添加子控件
        addSubview(bottomBar)
        addSubview(emoticonKeyboard)
        
        // 设置子控件布局
        
//        // 表情键盘view
        let emotX:CGFloat = 0
        let emotY:CGFloat = 0
        let emotW:CGFloat = bounds.width
        let emotH:CGFloat = bounds.height - bottomBarHeight
        emoticonKeyboard.frame = CGRect(x: emotX, y: emotY, width: emotW, height: emotH)
        // 底部toolBar
        let bottomBarX:CGFloat = 0
        let bottomBarY:CGFloat = bounds.height - bottomBarHeight
        let bottomBarW = bounds.width
        let bottomBarH = bottomBarHeight
        bottomBar.frame = CGRect(x: bottomBarX , y: bottomBarY, width: bottomBarW, height: bottomBarH)
        
        prepareToolBar()
        prepareEmotKeyboard()
        
        
        
        
    }
    
    private func prepareToolBar(){
        bottomBar.tintColor = UIColor.blue
        var items = [UIBarButtonItem]()
        var index = 0
        for t in emoticons.emoticonGroups{
            let item = UIBarButtonItem(title: t.group_name_cn, style: .plain, target: self, action: #selector(toolBarBtnClicked(toolBarButton:)))
            item.width = 40
            item.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 14),NSForegroundColorAttributeName:UIColor.black], for: UIControlState.normal)
            item.tag = index
            index += 1
            items.append(item)
            
            let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            items.append(flexibleItem)
            
        }
        items.removeLast()
        bottomBar.setItems(items, animated: false)
        
    }
    
    private func prepareEmotKeyboard(){
        
        
        emoticonKeyboard.backgroundColor = UIColor.white
        emoticonKeyboard.isPagingEnabled = true
        emoticonKeyboard.bounces = false
        emoticonKeyboard.showsHorizontalScrollIndicator = false
        
        // 设置emoticonKeyboard数据源和代理
        emoticonKeyboard.delegate = self
        emoticonKeyboard.dataSource = self
        emoticonKeyboard.register(EmoticonCell.self, forCellWithReuseIdentifier:emoticonReuseIdentifier)
    }
    
    @objc private func toolBarBtnClicked(toolBarButton:UIBarButtonItem){
        print("点击了第 \(toolBarButton.tag) 个按钮")
        let indexPath = IndexPath(item: 0, section: toolBarButton.tag)
        emoticonKeyboard.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
        
        
    }
    
}

// MARK: - 数据源方法和代理方法
extension EmoticonView:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emoticons.emoticonGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let emoticonGroup = emoticons.emoticonGroups[section]
        return emoticonGroup.emoticons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emoticonReuseIdentifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cell = cell as! EmoticonCell
        
        let emoticon = emoticons.emoticonGroups[indexPath.section].emoticons[indexPath.item]
   
        cell.emoticonBtn.setImage(UIImage(contentsOfFile: emoticon.emoticonImagePath ?? ""), for: .normal)
      
 
        cell.emoticonBtn.setTitle(emoticon.emoji, for: .normal)

    

        cell.contentView.addSubview(cell.emoticonBtn)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let em = emoticons.emoticonGroups[indexPath.section].emoticons[indexPath.item]
        selectEmoticonCallBack?(em)
    }
    
}


// 表情键盘布局类
class EmoticonLayout: UICollectionViewFlowLayout {
    
    
    override func  prepare(){
        super.prepare()
        
        let row:CGFloat = 3
        let col:CGFloat = 7
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        let itemW:CGFloat = collectionView!.bounds.width / col
        let itemH:CGFloat = itemW
        
        
        let insetMargin = (collectionView!.bounds.height - row * itemH) / 2
        sectionInset = UIEdgeInsets(top: insetMargin, left: 0, bottom: insetMargin, right: 0)
        
        itemSize = CGSize(width: itemW, height: itemH)
        scrollDirection = .horizontal
        estimatedItemSize = itemSize
        

    }
    
}

class EmoticonCell: UICollectionViewCell {
    
    var emoticonBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){

        emoticonBtn.frame = bounds.insetBy(dx: 4, dy: 4)
        emoticonBtn.backgroundColor = UIColor.white
        
        emoticonBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        
        emoticonBtn.isUserInteractionEnabled = false
        

    }
    
}



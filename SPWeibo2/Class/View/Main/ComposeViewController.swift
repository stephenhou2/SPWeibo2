//
//  ComposeViewController.swift
//  SPWeibo2
//
//  Created by 侯亮宏 on 17/3/15.
//  Copyright © 2017年 侯亮宏. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    // 输入文本框
    fileprivate lazy var composeView:UITextView = UITextView(frame: CGRect.zero)
    // 键盘顶部工具条
    fileprivate lazy var keyBoardToolBar:UIToolbar = UIToolbar(frame: CGRect.zero)
    
    fileprivate lazy var isEmoticonKeyboard:Bool = true
    
    fileprivate lazy var placeHolderLabel = UILabel(text: "分享一些新鲜事...", fontSize: 16, textColor: UIColor.darkGray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        composeView.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
    }



}

// 自定义方法
extension ComposeViewController{
    
    /// 取消按钮点击响应方法
    @objc fileprivate func cancelBtnClicked(){
        composeView.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    /// 发布按钮点击响应方法
    @objc fileprivate func postBtnClicked(){
        print(composeView.attributeString)
    }
    
    @objc fileprivate func keyboardWillChangeFrame(notification:Notification){
        let destinateY:CGFloat = (notification.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! NSValue).cgRectValue.origin.y
        let curve = notification.userInfo!["UIKeyboardAnimationCurveUserInfoKey"] as! Int
        UIView.animate(withDuration: 0.25) {
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve)!)
            self.keyBoardToolBar.transform = CGAffineTransform(translationX: 0, y: destinateY - screenHeight)
            
        }
        
    }
}

// 设置布局
extension ComposeViewController{
    
    fileprivate func setupUI(){
        
        // 设置界面风格
        view.backgroundColor = UIColor.white
        // 添加子控件
        view.addSubview(composeView)
        view.addSubview(keyBoardToolBar)
        
 
        // 设置子控件大小和位置
        // toolBar
        let toolBarW:CGFloat = screenWidth
        let toolBarH:CGFloat = 36
        let toolBarX:CGFloat = 0
        let toolBarY:CGFloat = screenHeight - toolBarH
        keyBoardToolBar.frame = CGRect(x: toolBarX, y: toolBarY, width: toolBarW, height: toolBarH)
        
        let composeViewW = screenWidth
        let composeViewH = toolBarY
        composeView.frame = CGRect(x: 0, y:0 , width: composeViewW, height: composeViewH)
        
        prepareToolBar()
        prepareComposeView()
        prepareNavigationBar()
        
        
        
    }
    // 准备键盘辅助输入toolBar
    private func prepareToolBar(){
        // 3. 添加按钮
        let itemSettings = [["imageName": "compose_toolbar_picture", "actionName": "selectPicture"],
                            ["imageName": "compose_mentionbutton_background"],
                            ["imageName": "compose_trendbutton_background"],
                            ["imageName": "compose_emoticonbutton_background", "actionName": "selectEmoticon"],
                            ["imageName": "compose_addbutton_background"]]
        var items = [UIBarButtonItem]()
        for itemDic in itemSettings {
            let itemBtn = UIButton(title: nil, imageName: itemDic["imageName"], backgroundImageName: nil)
            if itemDic["actionName"] != nil{
                itemBtn.addTarget(self, action: #selector(emoticonBtnClicked(emoticonBtn:)), for: UIControlEvents.touchUpInside)
            }
            let item = UIBarButtonItem(customView: itemBtn)
            items.append(item)
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        keyBoardToolBar.items = items
        
  
        
    }
    
    @objc private func emoticonBtnClicked(emoticonBtn:UIButton){
        print("点击了表情按钮")
         composeView.resignFirstResponder()
        if isEmoticonKeyboard{
            emoticonBtn.setImage(UIImage(named:"compose_keyboardbutton_background"), for: .normal)
            composeView.inputView = EmoticonView(selectEmoticonCallBack: {[weak self] (emoticon) in
                self?.composeView.inserEmoticon(em:emoticon)
            })
        }
        else{
            emoticonBtn.setImage(UIImage(named:"compose_emoticonbutton_background"), for: .normal)
            composeView.inputView = nil
        }
        composeView.becomeFirstResponder()
        isEmoticonKeyboard = !isEmoticonKeyboard
    }
    private func prepareComposeView(){
        composeView.font = UIFont.systemFont(ofSize: 16)
        composeView.textColor = UIColor.darkGray
        
        composeView.alwaysBounceVertical = true
        composeView.keyboardDismissMode = .onDrag
        
        composeView.delegate = self
        
        // 添加占位label
        composeView.addSubview(placeHolderLabel)
        placeHolderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(composeView.snp.left).offset(4)
            make.top.equalTo(composeView.snp.top).offset(8)
        }
        
    }
    
    private func prepareNavigationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelBtnClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(postBtnClicked))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
}

/// MARK: - uitextView代理方法
extension ComposeViewController:UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    
    
}


